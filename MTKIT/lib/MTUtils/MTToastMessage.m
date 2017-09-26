//
//  MTToastMessage.m
//  MTRealEstate
//
//  Created by HaoSun on 16/11/25.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import "MTToastMessage.h"

@implementation MTToastMessage
//麦麦
NSString *const MM_Name                        = @"消息";

NSString *const MTToastSuccess                 = @"成功";
NSString *const MTToastFailed                  = @"失败";
NSString *const MTToastError                   = @"错误";

NSString *const MTToast_NET_Failed             = @"网络连接失败，请查看网络设置";
NSString *const MTToast_NET_Error              = @"网络错误"; //300
NSString *const MTToast_SEV_Failed             = @"服务器连接失败，请稍后再试";//400
NSString *const MTToast_MOB_Failed             = @"服务器连接失败，请稍后再试";//500
NSString *const MTToast_SEV_OverTime           = @"服务器请求超时，请稍后重试";//超时
NSString *const MTToast_SEV_Loading            = @"";

NSString *const MTToastDelSuccess              = @"删除成功";
NSString *const MTToastDelFailed               = @"删除失败";

NSString *const MTToastAddSuccess              = @"添加成功";
NSString *const MTToastAddFailed               = @"添加失败";
NSString *const MTToastShareSuccess            = @"分享成功";


NSString *const MTToastNoSpeak                 = @"您已被禁言";

NSString *const MTToastNoSearchData            = @"没有查到你所需要的数据！";
NSString *const MTToastNoSearchPWD             = @"找回密码失败,请稍后再试";

NSString *const MTToastMaxImg                  = @"所选图片已达到9张";

NSString *const MTToast_NoMsg                  = @"没有查到你所需要的数据!";

NSString *const MTToast_NoSearchResult         = @"没有查到你所需要的数据!";

#pragma mark - 麦麦
NSString *const MTToast_MM_Microphone          = @"请获取使用麦克风的权限";
NSString *const MTToast_MM_AlreadySigne        = @"此账号正在其他设备上登录,您已被迫下线";
NSString *const MTToast_MM_GrounpLimit         = @"人数已达上限";
NSString *const MTToast_MM_GrounpName          = @"修改群名失败";
NSString *const MTTosat_MM_GroupMemberDel      = @"人员已被删除";
//此处不要修改，因为后台返回的信息为【群组成员】必须填写，的view长度太长了，为了居中显示。
NSString *const MTTosat_MM_MinPeople           = @"群组创建失败!";
NSString *const MTTosat_MM_AlreadyExist        = @"添加群成员失败!";

#pragma mark - 通讯录
NSString *const MTToast_AD_NoNum               = @"该联系人暂无手机号";
NSString *const MTToast_AD_NoData              = @"没有查到你所需要的数据!";
NSString *const MTToast_AD_VerCode             = @"请输入正确的验证码";

NSString *const MTToast_AD_UpDataFailed        = @"数据更新失败，请稍后再试";
NSString *const MTToast_AD_NoSearchData        = @"没有查到你所需要的数据";

NSString *const MTToast_AD_NoSearchPer         = @"没找到指定人员";

#pragma mark - 工作
NSString *const MTToast_GZ_NoSearchText        = @"数据为空";//
NSString *const MTToast_GZ_SuccessNotice       = @"已关注";
NSString *const MTToast_GZ_FailNotice          = @"关注失败";
NSString *const MTToast_GZ_SuccessFollowUp     = @"已提交";
NSString *const MTToast_GZ_FailFollowUp        = @"新增失败";
NSString *const MTToast_GZ_MaxFollowUp         = @"您关注的物业已达上限";
NSString *const MTToast_GZ_ClearHistory        = @"已清空";
NSString *const MTToast_GZ_CancelSuccess       = @"取消成功";
//
NSString *const MTToast_GZ_NoEntryCheck        = @"您无权限查看该房源，请联系运营人员";
NSString *const MTToast_GZ_FallToTaobaoPool    = @"您查看的房源已掉入淘宝池";
NSString *const MTToast_GZ_Forbidden           = @"您已被禁言，请联系管理员";


#pragma mark - 菩提模块
//问答与学堂模块
NSString *const MTToast_PT_SearChAns           = @"搜索答案";
NSString *const MTToast_PT_SearChQus           = @"搜索你想知道的问题";
//语音模块
NSString *const MTToast_PT_OverLimit           = @"录入内容超限，请重新录入！";
NSString *const MTToast_PT_VoiceRecognition    = @"语音识别中";
NSString *const MTToast_PT_UnVoiceRecognition  = @"未识别出你说的话，长按，即可重新录入";
NSString *const MTToast_PT_UnRecognition       = @"长按，可重新录入";
NSString *const MTToast_PT_VoiceRecording      = @"语音录入中";
//搜索提问模块
NSString *const MTToast_PT_NoSearch            = @"没有您要搜索的答案";
NSString *const MTToast_PT_OverAsk             = @"已超过3次提问，请明天再来";
NSString *const MTToast_PT_CareSuccess         = @"关注成功";
NSString *const MTToast_PT_CancleCare          = @"取消关注";
NSString *const MTToast_PT_GoldShortage        = @"麦币不足";
NSString *const MTToast_PT_OverGold            = @"超过最大悬赏金额";
NSString *const MTToast_PT_UpGold             = @"提高悬赏";
NSString *const MTToast_PT_ChangeLabel         = @"请为问题选择标签";
NSString *const MTToast_PT_ThreeLabel          = @"最多只能选择三个标签";

NSString *const MTToast_PT_FillInGold          = @"填写悬赏金额";
NSString *const MTToast_PT_AddGold             = @"增加悬赏，能吸引更多的人回答你的问题";
NSString *const MTToast_PT_MaxGold             = @"已超过您的最大麦币数";
NSString *const MTToast_PT_MaxImg              = @"最多选择3张图片";
NSString *const MTToast_PT_Reports             = @"该内容已被举报删除";
NSString *const MTToast_PT_ChangeReports       = @"请选择举报内容";
NSString *const MTToast_PT_CareLabel           = @"已关注的标签，长按删除";

NSString *const MTToast_PT_MinLabel            = @"最少选择三个";
NSString *const MTToast_PT_StopAsk             = @"停止提醒后有新回答不再动态消息中提醒？";
NSString *const MTToast_PT_DelLabel            = @"确认删除该问题吗？";
NSString *const MTToast_PT_BestAns             = @"确认将该回答置为最佳答案吗？";
NSString *const MTToast_PT_ContentDel          = @"该内容已被删除！";
NSString *const MTToast_PT_ChangeSigns         = @"请选择感兴趣的标签！";
NSString *const MTToast_PT_SignsSuccess        = @"提交成功";

#pragma mark - 联络人
NSString *const MTToast_LI_Search              = @"请输入搜索内容";
//单独工作模块
#pragma mark - 圈子

NSString *const MTToast_CC_CommentFailed       = @"发送评论失败";
NSString *const MTToast_CC_DelCommentFailed    = @"删除评论失败";

NSString *const MTToast_CC_LikeSuccess         = @"点赞成功";
NSString *const MTToast_CC_LikeFailed          = @"点赞失败";

NSString *const MTToast_CC_ShieldFailed        = @"屏蔽失败";
NSString *const MTToast_CC_ShieldSuccess       = @"屏蔽成功";
NSString *const MTToast_CC_CancleShieldFailed  = @"取消屏蔽失败";
NSString *const MTToast_CC_CancleShieldSuccess = @"取消屏蔽成功";

NSString *const MTToast_CC_CommitMaxWord       = @"评论文字应在650以内";

NSString *const MTToast_CC_NoReports           = @"不能举报自己";

NSString *const MTToast_CC_CommitReports       = @"您的举报已提交";

NSString *const MTToast_CC_ShareMinWord        = @"您多少也写一个字啊~";

NSString *const MTToast_CC_NoTitle             = @"请输入标题";

NSString *const MTToast_CC_ForBit              = @"所编写的内容太少啦~不如发个动态去？";

NSString *const MTToast_CC_ForBitMax           = @"内容不能大于1500字";

NSString *const MTToast_CC_Tiding              = @"动态内容不能为空";

NSString *const MTToast_CC_TidingFaild         = @"动态发表失败";

NSString *const MTToast_CC_DynamicSendSuccess  = @"发布成功";
NSString *const MTToast_CC_ArticleSendSuccess  = @"发布成功";

NSString *const MTToast_CC_DelCommit           = @"是否确定删除该评论";

NSString *const MTToast_CC_DelYESNO            = @"确认删除吗?";

NSString *const MTToast_CC_ShieldYESNO         = @"是否屏蔽";

NSString *const MTToast_CC_CancleShieldYESNO   = @"是否取消屏蔽";

//NSString *const MTToast_CC_MaxOrMinWord        = @"请输入正文，最少140字，最多1500字";
NSString *const MTToast_CC_MaxOrMinWord        = @"想法、见解、感受、经历、经验...你想说的，也许也是我们想听的...";
NSString *const MTToast_CC_ReportMaxWord        = @"您的输入已超过上限";
NSString *const MTToast_CC_ShareToFriend        = @"给你的好友留言";

#pragma mark - 我的

NSString *const MTToast_MY_ChangePho           = @"请选择您的照片";
NSString *const MTToast_MY_UpLoadSuccess       = @"上传成功";

NSString *const MTToast_MY_AddImpSuccess       = @"添加印象成功";
NSString *const MTToast_MY_AddImpFailed        = @"添加印象失败，请稍后.....";
NSString *const MTToast_MY_InputImp            = @"请输入您对好友的印象";

NSString *const MTToast_MY_FeedBack            = @"您的意见已收到";
NSString *const MTToast_MY_FeedError           = @"反馈消息发送失败";


NSString *const MTToast_MY_CommentFailed       = @"评论失败";
NSString *const MTToast_MY_CommentError        = @"回复评论失败";

NSString *const MTToast_MY_ColSuccess          = @"收藏成功";
NSString *const MTToast_MY_ColFailed           = @"收藏失败";
NSString *const MTToast_MY_CancleColFailed     = @"取消失败";
NSString *const MTToast_MY_CancleColSuccess    = @"已取消";


NSString *const MTToast_MY_CareSuccess         = @"关注成功";
NSString *const MTToast_MY_CareFailed          = @"关注失败";

NSString *const MTToast_MY_CancleCareSuccess   = @"取消关注成功";
NSString *const MTToast_MY_CancleCareFailed    = @"取消关注失败";

NSString *const MTToast_MY_FixSuccess          = @"修改成功";
NSString *const MTToast_MY_FixFailed           = @"修改失败";

NSString *const MTToast_MY_PwdError            = @"密码输入错误";

NSString *const MTToast_MY_NoIMP               = @"小伙伴当前还没有印象，快来添加吧！";

NSString *const MTToast_MY_NoHPIMP             = @"还没有好友对此进行描述...";

NSString *const MTToast_MY_NoNull              = @"您输入的密码不能为空，请重新输入";
NSString *const MTToast_MY_LeaveOff            = @"该员工已离职，无法联系";
NSString *const MTToast_MY_NoPower             = @"您没有权限联系该用户";
NSString *const MTToast_LI_ExceedWord          = @"录入内容已超限！";



@end
