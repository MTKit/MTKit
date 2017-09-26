//
//  MTToastMessage.h
//  MTRealEstate
//
//  Created by HaoSun on 16/11/25.
//  Copyright © 2016年 MaiTianMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTToastMessage : NSObject

#pragma mark - 统一信息
//环信账号登录失败的提示
UIKIT_EXTERN NSString *const MM_Name;
UIKIT_EXTERN NSString *const MTToast_MOB_Failed;
UIKIT_EXTERN NSString *const MTToastSuccess;
UIKIT_EXTERN NSString *const MTToastFailed;
UIKIT_EXTERN NSString *const MTToastError;

UIKIT_EXTERN NSString *const MTToast_NET_Failed;
UIKIT_EXTERN NSString *const MTToast_NET_Error;
UIKIT_EXTERN NSString *const MTToast_SEV_Failed;
UIKIT_EXTERN NSString *const MTToast_SEV_OverTime;

UIKIT_EXTERN NSString *const MTToastDelSuccess;
UIKIT_EXTERN NSString *const MTToastDelFailed;

UIKIT_EXTERN NSString *const MTToastAddSuccess;
UIKIT_EXTERN NSString *const MTToastAddFailed;
UIKIT_EXTERN NSString *const MTToastShareSuccess;

UIKIT_EXTERN NSString *const MTToastNoSpeak;
UIKIT_EXTERN NSString *const MTToastNoSearchData;
UIKIT_EXTERN NSString *const MTToastNoSearchPWD;

UIKIT_EXTERN NSString *const MTToastMaxImg;

UIKIT_EXTERN NSString *const MTToast_NoMsg;
UIKIT_EXTERN NSString *const MTToast_NoSearchResult;

UIKIT_EXTERN NSString *const MTToast_SEV_Loading;
#pragma mark - 麦麦

UIKIT_EXTERN NSString *const MTToast_MM_Microphone;
UIKIT_EXTERN NSString *const MTToast_MM_AlreadySigne;

UIKIT_EXTERN NSString *const MTToast_MM_GrounpLimit;

UIKIT_EXTERN NSString *const MTToast_MM_GrounpName;
UIKIT_EXTERN NSString *const MTTosat_MM_GroupMemberDel;
UIKIT_EXTERN NSString *const MTTosat_MM_MinPeople;
UIKIT_EXTERN NSString *const MTTosat_MM_AlreadyExist;

#pragma mark - 通讯录
UIKIT_EXTERN NSString *const MTToast_AD_NoNum;
UIKIT_EXTERN NSString *const MTToast_AD_NoData;
UIKIT_EXTERN NSString *const MTToast_AD_VerCode;


UIKIT_EXTERN NSString *const MTToast_AD_UpDataFailed;
UIKIT_EXTERN NSString *const MTToast_AD_NoSearchData;


UIKIT_EXTERN NSString *const MTToast_AD_NoSearchPer;

#pragma mark - 工作模块
UIKIT_EXTERN NSString *const MTToast_GZ_NoSearchText;
UIKIT_EXTERN NSString *const MTToast_GZ_SuccessFollowUp;
UIKIT_EXTERN NSString *const MTToast_GZ_FailFollowUp;
UIKIT_EXTERN NSString *const MTToast_GZ_MaxFollowUp;
UIKIT_EXTERN NSString *const MTToast_GZ_ClearHistory;//
UIKIT_EXTERN NSString *const MTToast_GZ_NoEntryCheck;
UIKIT_EXTERN NSString *const MTToast_GZ_FallToTaobaoPool;
UIKIT_EXTERN NSString *const MTToast_GZ_SuccessNotice;//
UIKIT_EXTERN NSString *const MTToast_GZ_FailNotice;
UIKIT_EXTERN NSString *const MTToast_GZ_Forbidden;
UIKIT_EXTERN NSString *const MTToast_GZ_CancelSuccess;

#pragma mark - 菩提模块
//问答与学堂模块
UIKIT_EXTERN NSString *const MTToast_PT_SearChAns;
UIKIT_EXTERN NSString *const MTToast_PT_SearChQus;
//语音模块
UIKIT_EXTERN NSString *const MTToast_PT_OverLimit;
UIKIT_EXTERN NSString *const MTToast_PT_VoiceRecognition;
UIKIT_EXTERN NSString *const MTToast_PT_UnVoiceRecognition;
UIKIT_EXTERN NSString *const MTToast_PT_UnRecognition;
UIKIT_EXTERN NSString *const MTToast_PT_VoiceRecording;
//搜索提问模块
UIKIT_EXTERN NSString *const MTToast_PT_NoSearch;
UIKIT_EXTERN NSString *const MTToast_PT_OverAsk;
UIKIT_EXTERN NSString *const MTToast_PT_CareSuccess;
UIKIT_EXTERN NSString *const MTToast_PT_CancleCare;
UIKIT_EXTERN NSString *const MTToast_PT_GoldShortage;
UIKIT_EXTERN NSString *const MTToast_PT_UpGold;
UIKIT_EXTERN NSString *const MTToast_PT_AddGold;
UIKIT_EXTERN NSString *const MTToast_PT_MaxGold;


UIKIT_EXTERN NSString *const MTToast_PT_ChangeLabel;
UIKIT_EXTERN NSString *const MTToast_PT_ThreeLabel;

UIKIT_EXTERN NSString *const MTToast_PT_FillInGold;
UIKIT_EXTERN NSString *const MTToast_PT_AddGold;
UIKIT_EXTERN NSString *const MTToast_PT_MaxImg;
UIKIT_EXTERN NSString *const MTToast_PT_Reports;
UIKIT_EXTERN NSString *const MTToast_PT_ChangeReports;
UIKIT_EXTERN NSString *const MTToast_PT_CareLabel;

UIKIT_EXTERN NSString *const MTToast_PT_MinLabel;
UIKIT_EXTERN NSString *const MTToast_PT_StopAsk;
UIKIT_EXTERN NSString *const MTToast_PT_DelLabel;
UIKIT_EXTERN NSString *const MTToast_PT_BestAns;
UIKIT_EXTERN NSString *const MTToast_PT_ContentDel;
UIKIT_EXTERN NSString *const MTToast_PT_ChangeSigns;
UIKIT_EXTERN NSString *const MTToast_PT_SignsSuccess;


#pragma mark - 联络人
UIKIT_EXTERN NSString *const MTToast_LI_Search;

#pragma mark - 圈子

UIKIT_EXTERN NSString *const MTToast_CC_CommentFailed;
UIKIT_EXTERN NSString *const MTToast_CC_DelCommentFailed;

UIKIT_EXTERN NSString *const MTToast_CC_LikeSuccess;
UIKIT_EXTERN NSString *const MTToast_CC_LikeFailed;

UIKIT_EXTERN NSString *const MTToast_CC_ShieldFailed;
UIKIT_EXTERN NSString *const MTToast_CC_CancleShieldFailed;
UIKIT_EXTERN NSString *const MTToast_CC_ShieldSuccess;
UIKIT_EXTERN NSString *const MTToast_CC_CancleShieldSuccess;


UIKIT_EXTERN NSString *const MTToast_CC_CommitMaxWord;
UIKIT_EXTERN NSString *const MTToast_CC_NoReports;
UIKIT_EXTERN NSString *const MTToast_CC_CommitReports;

UIKIT_EXTERN NSString *const MTToast_CC_ShareMinWord;

UIKIT_EXTERN NSString *const MTToast_CC_NoTitle;

UIKIT_EXTERN NSString *const MTToast_CC_ForBit;
UIKIT_EXTERN NSString *const MTToast_CC_ForBitMax;

UIKIT_EXTERN NSString *const MTToast_CC_Tiding;

UIKIT_EXTERN NSString *const MTToast_CC_TidingFaild;

UIKIT_EXTERN NSString *const MTToast_CC_DynamicSendSuccess;

UIKIT_EXTERN NSString *const MTToast_CC_ArticleSendSuccess;
UIKIT_EXTERN NSString *const MTToast_CC_DelCommit;

UIKIT_EXTERN NSString *const MTToast_CC_DelYESNO;

UIKIT_EXTERN NSString *const MTToast_CC_ShieldYESNO;
UIKIT_EXTERN NSString *const MTToast_CC_CancleShieldYESNO;
UIKIT_EXTERN NSString *const MTToast_CC_MaxOrMinWord;
UIKIT_EXTERN NSString *const MTToast_CC_ReportMaxWord;
UIKIT_EXTERN NSString *const MTToast_CC_ShareToFriend;

#pragma mark - 我的


UIKIT_EXTERN NSString *const MTToast_MY_ChangePho;
UIKIT_EXTERN NSString *const MTToast_MY_UpLoadSuccess;

UIKIT_EXTERN NSString *const MTToast_MY_AddImpSuccess;
UIKIT_EXTERN NSString *const MTToast_MY_AddImpFailed;
UIKIT_EXTERN NSString *const MTToast_MY_InputImp;

UIKIT_EXTERN NSString *const MTToast_MY_FeedError;

UIKIT_EXTERN NSString *const MTToast_MY_CommentFailed;
UIKIT_EXTERN NSString *const MTToast_MY_CommentError;

UIKIT_EXTERN NSString *const MTToast_MY_ColSuccess;
UIKIT_EXTERN NSString *const MTToast_MY_ColFailed;
UIKIT_EXTERN NSString *const MTToast_MY_CancleColFailed;
UIKIT_EXTERN NSString *const MTToast_MY_CancleColSuccess;


UIKIT_EXTERN NSString *const MTToast_MY_CareSuccess;
UIKIT_EXTERN NSString *const MTToast_MY_CareFailed;


UIKIT_EXTERN NSString *const MTToast_MY_CancleCareSuccess;
UIKIT_EXTERN NSString *const MTToast_MY_CancleCareFailed;

UIKIT_EXTERN NSString *const MTToast_MY_FixSuccess;
UIKIT_EXTERN NSString *const MTToast_MY_FixFailed;

UIKIT_EXTERN NSString *const MTToast_MY_PwdError;

UIKIT_EXTERN NSString *const MTToast_MY_FeedBack;

UIKIT_EXTERN NSString *const MTToast_MY_NoIMP;
UIKIT_EXTERN NSString *const MTToast_MY_NoHPIMP;
UIKIT_EXTERN NSString *const MTToast_MY_NoNull;
UIKIT_EXTERN NSString *const MTToast_MY_LeaveOff;
UIKIT_EXTERN NSString *const MTToast_MY_NoPower;
UIKIT_EXTERN NSString *const MTToast_LI_ExceedWord;

@end
