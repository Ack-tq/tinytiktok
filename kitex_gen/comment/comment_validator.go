// Code generated by Validator v0.1.4. DO NOT EDIT.

package comment

import (
	"bytes"
	"fmt"
	"reflect"
	"regexp"
	"strings"
	"time"
)

// unused protection
var (
	_ = fmt.Formatter(nil)
	_ = (*bytes.Buffer)(nil)
	_ = (*strings.Builder)(nil)
	_ = reflect.Type(nil)
	_ = (*regexp.Regexp)(nil)
	_ = time.Nanosecond
)

func (p *Comment) IsValid() error {
	if p.User != nil {
		if err := p.User.IsValid(); err != nil {
			return fmt.Errorf("filed User not valid, %w", err)
		}
	}
	return nil
}
func (p *DouyinCommentActionRequest) IsValid() error {
	return nil
}
func (p *DouyinCommentActionResponse) IsValid() error {
	if p.Comment != nil {
		if err := p.Comment.IsValid(); err != nil {
			return fmt.Errorf("filed Comment not valid, %w", err)
		}
	}
	return nil
}
func (p *DouyinCommentListRequest) IsValid() error {
	return nil
}
func (p *DouyinCommentListResponse) IsValid() error {
	return nil
}
