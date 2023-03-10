package jwt

import (
	"github.com/golang-jwt/jwt"
	"tinytiktok/pkg/errno"
)

// JWT signing Key
type JWT struct {
	SigningKey []byte
}

var (
	ErrTokenExpired     = errno.WithCode(errno.TokenExpiredErr)
	ErrTokenMalformed   = errno.WithCode(errno.TokenBadFormErr)
	ErrTokenInvalid     = errno.WithCode(errno.TokenInvalidErr)
	ErrTokenNotValidYet = errno.WithCode(errno.TokenValidationErr)
)

// private claims, share information between parties that agree on using them
// CustomClaims Structured version of Claims Section, as referenced at https://tools.ietf.org/html/rfc7519#section-4.1 See examples for how to use this with your own claim types
type CustomClaims struct {
	Id          int64
	AuthorityId int64
	jwt.StandardClaims
}

func NewJWT(SigningKey []byte) *JWT {
	return &JWT{
		SigningKey,
	}
}

// CreateToken creates a new token
func (j *JWT) CreateToken(claims CustomClaims) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	// zap.S().Debugf(token.SigningString())
	return token.SignedString(j.SigningKey)

}

// ParseToken parses the token.
func (j *JWT) ParseToken(tokenString string) (*CustomClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &CustomClaims{}, func(token *jwt.Token) (interface{}, error) {
		return j.SigningKey, nil
	})
	if err != nil {
		if ve, ok := err.(*jwt.ValidationError); ok {
			if ve.Errors&jwt.ValidationErrorMalformed != 0 {
				return nil, ErrTokenMalformed
			} else if ve.Errors&jwt.ValidationErrorExpired != 0 {
				return nil, ErrTokenExpired
			} else if ve.Errors&jwt.ValidationErrorNotValidYet != 0 {
				return nil, ErrTokenNotValidYet
			} else {
				return nil, ErrTokenInvalid
			}

		}
	}
	// verify the token claims
	if claims, ok := token.Claims.(*CustomClaims); ok && token.Valid {
		return claims, nil
	}
	return nil, ErrTokenInvalid
}

// 获取当前登录用户ID
func (j *JWT) GetUserIDFromToken(tokenString string) (int64, error) {
	claims, err := j.ParseToken(tokenString)
	if err != nil {
		return -1, err
	}
	return claims.Id, nil
}
