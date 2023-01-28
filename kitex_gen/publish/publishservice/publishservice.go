// Code generated by Kitex v0.4.4. DO NOT EDIT.

package publishservice

import (
	"context"
	client "github.com/cloudwego/kitex/client"
	kitex "github.com/cloudwego/kitex/pkg/serviceinfo"
	publish "tinytiktok/kitex_gen/publish"
)

func serviceInfo() *kitex.ServiceInfo {
	return publishServiceServiceInfo
}

var publishServiceServiceInfo = NewServiceInfo()

func NewServiceInfo() *kitex.ServiceInfo {
	serviceName := "PublishService"
	handlerType := (*publish.PublishService)(nil)
	methods := map[string]kitex.MethodInfo{
		"PublishAction": kitex.NewMethodInfo(publishActionHandler, newPublishServicePublishActionArgs, newPublishServicePublishActionResult, false),
		"PublishList":   kitex.NewMethodInfo(publishListHandler, newPublishServicePublishListArgs, newPublishServicePublishListResult, false),
	}
	extra := map[string]interface{}{
		"PackageName": "publish",
	}
	svcInfo := &kitex.ServiceInfo{
		ServiceName:     serviceName,
		HandlerType:     handlerType,
		Methods:         methods,
		PayloadCodec:    kitex.Thrift,
		KiteXGenVersion: "v0.4.4",
		Extra:           extra,
	}
	return svcInfo
}

func publishActionHandler(ctx context.Context, handler interface{}, arg, result interface{}) error {
	realArg := arg.(*publish.PublishServicePublishActionArgs)
	realResult := result.(*publish.PublishServicePublishActionResult)
	success, err := handler.(publish.PublishService).PublishAction(ctx, realArg.Req)
	if err != nil {
		return err
	}
	realResult.Success = success
	return nil
}
func newPublishServicePublishActionArgs() interface{} {
	return publish.NewPublishServicePublishActionArgs()
}

func newPublishServicePublishActionResult() interface{} {
	return publish.NewPublishServicePublishActionResult()
}

func publishListHandler(ctx context.Context, handler interface{}, arg, result interface{}) error {
	realArg := arg.(*publish.PublishServicePublishListArgs)
	realResult := result.(*publish.PublishServicePublishListResult)
	success, err := handler.(publish.PublishService).PublishList(ctx, realArg.Req)
	if err != nil {
		return err
	}
	realResult.Success = success
	return nil
}
func newPublishServicePublishListArgs() interface{} {
	return publish.NewPublishServicePublishListArgs()
}

func newPublishServicePublishListResult() interface{} {
	return publish.NewPublishServicePublishListResult()
}

type kClient struct {
	c client.Client
}

func newServiceClient(c client.Client) *kClient {
	return &kClient{
		c: c,
	}
}

func (p *kClient) PublishAction(ctx context.Context, req *publish.DouyinPublishActionRequest) (r *publish.DouyinPublishActionResponse, err error) {
	var _args publish.PublishServicePublishActionArgs
	_args.Req = req
	var _result publish.PublishServicePublishActionResult
	if err = p.c.Call(ctx, "PublishAction", &_args, &_result); err != nil {
		return
	}
	return _result.GetSuccess(), nil
}

func (p *kClient) PublishList(ctx context.Context, req *publish.DouyinPublishListRequest) (r *publish.DouyinPublishListResponse, err error) {
	var _args publish.PublishServicePublishListArgs
	_args.Req = req
	var _result publish.PublishServicePublishListResult
	if err = p.c.Call(ctx, "PublishList", &_args, &_result); err != nil {
		return
	}
	return _result.GetSuccess(), nil
}
