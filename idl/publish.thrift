namespace go publish

include "feed.thrift"

struct DouyinPublishActionRequest {
    1: string token // 用户鉴权token
    2: binary data // 视频数据
    3: string title // 视频标题
}
struct DouyinPublishActionResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
}
struct douyinPublishListRequest {
    1: i64 user_id // 用户id
    2: string token // 用户鉴权token
}
struct DouyinPublishListResponse {
    1: i32 status_code // 状态码，0-成功，其他值-失败
    2: string status_msg // 返回状态描述
    3: list<feed.Video> video_list // 用户发布的视频列表
}

service PublishService {
    DouyinPublishActionResponse PublishAction (1: DouyinPublishActionRequest req)
    DouyinPublishListResponse PublishList (1: douyinPublishListRequest req)
}
