namespace go api

struct User {
    1: i64 id // 用户id
    2: string name // 用户名称
    3: i64 follow_count // 关注总数
    4: i64 follower_count // 粉丝总数
    5: bool is_follow // true-已关注，false-未关注
}
struct Video {
    1: i64 id // 视频唯一标识
    2: User author // 视频作者信息
    3: string play_url // 视频播放地址
    4: string cover_url // 视频封面地址
    5: i64 favorite_count // 视频的点赞总数
    6: i64 comment_count // 视频的评论总数
    7: bool is_favorite // true-已点赞，false-未点赞
    8: string title // 视频标题
}
struct Comment {
    1: i64 id // 视频评论id
    2: User user // 评论用户信息
    3: string content // 评论内容
    4: string create_date // 评论发布日期，格式 mm-dd
}

// User
struct DouyinUserRegisterRequest {
    1: string username (api.query="username", api.vd="len($) > 0")// 注册用户名，最长32个字符
    2: string password (api.query="password", api.vd="len($) > 0")// 密码，最长32个字符
}
struct DouyinUserRegisterResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: i64 user_id // 用户id
    4: string token // 用户鉴权token
}
struct DouyinUserLoginRequest {
    1: string username (api.query="username", api.vd="len($) > 0")// 注册用户名，最长32个字符
    2: string password (api.query="password", api.vd="len($) > 0")// 密码，最长32个字符
}
struct DouyinUserLoginResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: i64 user_id // 用户id
    4: string token // 用户鉴权token
}
struct DouyinUserRequest {
    1: i64 user_id (api.query="user_id", api.vd="len($) > 0")// 用户id
    2: string token (api.query="token", api.vd="len($) > 0")// 用户鉴权token
}
struct DouyinUserResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: User user // 用户信息
}

// Feed
struct DouyinFeedRequest {
    1: i64 latest_time (api.query="latest_time", api.vd="len($) > 0")// 可选参数，限制返回视频的最新投稿时间戳，精确到秒，不填表示当前时间
    2: string token (api.query="token", api.vd="len($) > 0")// 可选参数，登录用户设置
}
// 按照投稿时间戳逆序返回视频列表
struct DouyinFeedResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: list<Video> video_list // 视频列表
    4: i64 next_time // 本次返回的视频中，发布最早的时间，作为下次请求时的latest_time
}

// Publish
struct DouyinPublishActionRequest {
    1: string token (api.form="token", api.vd="len($) > 0")// 用户鉴权token
    2: binary data (api.form="data", api.vd="len($) > 0")// 视频数据
    3: string title (api.form="title", api.vd="len($) > 0")// 视频标题
}
struct DouyinPublishActionResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
}
struct douyinPublishListRequest {
    1: i64 user_id (api.query="user_id", api.vd="len($) > 0")// 用户id
    2: string token (api.query="token", api.vd="len($) > 0")// 用户鉴权token
}
struct DouyinPublishListResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: list<Video> video_list // 用户发布的视频列表
}

// Favorite
struct DouyinFavoriteActionRequest {
    1: i64 user_id // 用户id (api文档无此字段，但数据库表的用户与视频点赞关系表需要此字段)
    2: string token (api.query="token", api.vd="len($) > 0")// 用户鉴权token
    3: i64 video_id (api.query="video_id", api.vd="len($) > 0")// 视频id
    4: i32 action_type (api.query="action_type", api.vd="len($) > 0")// 1-点赞，2-取消点赞
}
struct douyinFavoriteActionResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
}
struct DouyinFavoriteListRequest {
    1: i64 user_id (api.query="user_id", api.vd="len($) > 0")// 用户id
    2: string token (api.query="token", api.vd="len($) > 0")// 用户鉴权token
}
struct DouyinFavoriteListResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: list<Video> video_list // 用户点赞视频列表
}

// Relation
struct DouyinRelationActionRequest {
    1: i64 user_id // 用户id 同上视频点赞请求
    2: string token (api.query="token", api.vd="len($) > 0")// 用户鉴权token
    3: i64 to_user_id (api.query="to_user_id", api.vd="len($) > 0")// 对方用户id
    4: i32 action_type (api.query="action_type", api.vd="len($) > 0")// 1-关注，2-取消关注
}
struct DouyinRelationActionResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
}
struct DouyinRelationFollowListRequest {
    1: i64 user_id (api.query="user_id", api.vd="len($) > 0")// 用户id
    2: string token (api.query="token", api.vd="len($) > 0")// 用户鉴权token
}
struct DouyinRelationFollowListResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: list<User> user_list // 用户信息列表
}
struct DouyinRelationFollowerListRequest {
    1: i64 user_id (api.query="user_id", api.vd="len($) > 0")// 用户id
    2: string token (api.query="token", api.vd="len($) > 0")// 用户鉴权token
}
struct DouyinRelationFollowerListResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: list<User> user_list // 用户列表
}

// Comment
struct DouyinCommentActionRequest {
    1: i64 user_id // 用户id
    2: string token (api.query="token", api.vd="len($) > 0")// 用户鉴权token
    3: i64 video_id (api.query="video_id", api.vd="len($) > 0")// 视频id
    4: i32 action_type (api.query="action_type", api.vd="len($) > 0")// 1-发布评论，2-删除评论
    5: string comment_text (api.query="comment_text", api.vd="len($) > 0")// 用户填写的评论内容，在action_type=1的时候使用
    6: i64 comment_id (api.query="comment_id", api.vd="len($) > 0")// 要删除的评论id，在action_type=2的时候使用
}
struct DouyinCommentActionResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: Comment comment // 评论成功返回评论内容，不需要重新拉取整个列表
}
struct DouyinCommentListRequest {
    1: string token (api.query="token", api.vd="len($) > 0")// 用户鉴权token
    2: i64 video_id (api.query="video_id", api.vd="len($) > 0")// 视频id
}
struct DouyinCommentListResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: list<Comment> comment_list // 评论列表
}

service ApiService {
    DouyinUserRegisterResponse Register (1: DouyinUserRegisterRequest req) (api.post="/douyin/user/register/")
    DouyinUserLoginResponse Login (1: DouyinUserLoginRequest req) (api.post="/douyin/user/login/")
    DouyinUserResponse GetUserByID (1: DouyinUserRequest req) (api.get="/douyin/user/")

    DouyinFeedResponse GetUserFeed (1: DouyinFeedRequest req) (api.get="/douyin/feed/")

    DouyinPublishActionResponse PublishAction (1: DouyinPublishActionRequest req) (api.post="/douyin/publish/action/")
    DouyinPublishListResponse PublishList (1: douyinPublishListRequest req) (api.get="/douyin/publish/list/")

    douyinFavoriteActionResponse FavoriteAction (1: DouyinFavoriteActionRequest req) (api.post="/douyin/favorite/action/")
    douyinFavoriteActionResponse FavoriteList (1: DouyinFavoriteListRequest req) (api.get="/douyin/favorite/list/")

    DouyinRelationActionResponse RelationAction (1: DouyinRelationActionRequest req) (api.post="/douyin/relation/action/")
    DouyinRelationFollowListResponse RelationFollowList (1: DouyinRelationFollowListRequest req) (api.get="/douyin/relation/follow/list/")
    DouyinRelationFollowerListResponse RelationFollowerList (1: DouyinRelationFollowerListRequest req) (api.get="/douyin/relation/follower/list/")

    DouyinCommentActionResponse CommentAction (1: DouyinCommentActionRequest req) (api.post="/douyin/comment/action/")
    DouyinCommentListResponse CommentList (1: DouyinCommentListRequest req) (api.get="/douyin/comment/list/")
}