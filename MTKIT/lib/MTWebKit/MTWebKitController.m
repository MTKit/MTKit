//
//  MTWebKitController.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/4/7.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//  基于webkit的封装

#import "MTWebKitController.h"
#import "MTNO_NETView.h"
#import "UIImage+G.h"
#import "MTPopMenu.h"
#import <JavaScriptCore/JavaScriptCore.h>
#define StatusBarH 20
#define CloseBtn_H 30


@interface MTWebKitController ()<UIWebViewDelegate,UIActionSheetDelegate,WKNavigationDelegate>


@property (nonatomic, strong) JSContext *jsContext;
@property (assign, nonatomic) NSUInteger       loadCount;
@property (strong, nonatomic) UIProgressView  *progressView;
@property (strong, nonatomic) UIWebView       *webView;
@property (strong, nonatomic) WKWebView       *wkWebView;
@property (nonatomic, assign) NSInteger        intoType;//进入页面的方式
@end

@implementation MTWebKitController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backBtn setImage:[[UIImage imageNamed:@"back_blue"] changeImageColor:[UIColor whiteColor]]forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [backBtn addTarget:self action:@selector(alertdd) forControlEvents:UIControlEventTouchUpInside];

    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            self.intoType = 1;
        }
    }
    else{
        //present方式
        self.intoType = 2;
    }
    if ([MTHttpRequest_Helper jundgeNetworkStatus]) {
        [self configUI];
    }else{
        [self setNetError];
    }
    if (self.intoType == 1) {
        [self configBackItem];
        [self configMenuItem];
    }
    if (self.intoType == 2) {
        if (!self.statuColor) {
            self.statuColor = [[NSUserDefaults standardUserDefaults] objectForKey:MT_APP_COLOR_NAME];
        }
        [self setupStatusBar];
        [self setupCloseBtn];
    }
}

- (void)alertdd {
    if (self.dismissType==MTWebKitDismissPopAll) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    NSString *alertJS = @"goBackApp()";
    [self.jsContext evaluateScript:alertJS];
}
#pragma mark - 判断网络连接状态
- (void)setNetError{
    MTNO_NETView *no_netView = [[MTNO_NETView alloc] initWithView:self.view];
    [self.view addSubview:no_netView];
}

#pragma mark - ***** 进度条
- (UIProgressView *)progressView
{
    if (!_progressView)
    {
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        progressView.tintColor = [UIColor greenColor];
        progressView.trackTintColor = [UIColor whiteColor];
        [self.view addSubview:progressView];
        self.progressView = progressView;
    }
    return _progressView;
}
#pragma mark - setupStatusBar
- (void)setupStatusBar{
    UIView *statusBar = [[UIView alloc] init];
    statusBar.backgroundColor = [UIColor colorWithHexStr:_statuColor alpha:1];
    statusBar.frame = CGRectMake(0, 0, ScreenWidth, StatusBarH);
    [self.view addSubview:statusBar];
}

#pragma mark - ***** UI创建
- (void)configUI
{
    self.progressView.hidden = NO;
    /*! 网页 */
    if (IOS8x) {
        WKWebView *wkWebView = [[WKWebView alloc] init];
        if (self.intoType == 1) {
             wkWebView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        }else{
            wkWebView.frame = CGRectMake(0, StatusBarH, ScreenWidth, ScreenHeight-StatusBarH);
        }
        wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        wkWebView.backgroundColor = [UIColor whiteColor];
        wkWebView.navigationDelegate = self;

        /*! 适应屏幕 */
        //        wkWebView.scalesPageToFit = YES;
        /*! 解决iOS9.2以上黑边问题 */
        wkWebView.opaque = NO;
        /*! 关闭多点触控 */
        wkWebView.multipleTouchEnabled = YES;
        /*! 加载网页中的电话号码，单击可以拨打 */
        //        wkWebView.dataDetectorTypes = YES;

        [self.view insertSubview:wkWebView belowSubview:_progressView];

        [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
        [wkWebView loadRequest:request];
        self.wkWebView = wkWebView;
    }else {
        UIWebView *webView = [[UIWebView alloc] init];
        if (self.intoType == 1) {
            webView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        }else{
            webView.frame = CGRectMake(0, StatusBarH, ScreenWidth, ScreenHeight-StatusBarH);
        }
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

        webView.backgroundColor = [UIColor whiteColor];
        webView.delegate = self;
        /*! 适应屏幕 */
        webView.scalesPageToFit = YES;
        /*! 解决iOS9.2以上黑边问题 */
        webView.opaque = NO;
        /*! 关闭多点触控 */
        webView.multipleTouchEnabled = YES;
        /*! 加载网页中的电话号码，单击可以拨打 */
        webView.dataDetectorTypes = YES;

        [self.view insertSubview:webView belowSubview:_progressView];

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
        [webView loadRequest:request];
        self.webView = webView;
    }
}

#pragma mark - MTWebKitIntoTypePresent
- (void)setupCloseBtn{
    if (!self.moreBtnHidden) {
        UIImage *backImage = [UIImage imageNamed:@"House_Close"];
        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIButton *closeBtn = [[UIButton alloc] init];
        [closeBtn setBackgroundImage:backImage forState:UIControlStateNormal];
        [closeBtn setTintColor:[UIColor colorWithHexStr:Time_Color alpha:1]];
        [closeBtn sizeToFit];
        closeBtn.frame = CGRectMake(ScreenWidth-CloseBtn_H, StatusBarH, CloseBtn_H, CloseBtn_H);
        [closeBtn addTarget:self action:@selector(webKitCloseView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:closeBtn];
    }
}
//
- (void)webKitCloseView:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:^{

    }];
}
#pragma mark 导航栏的返回按钮
- (void)configBackItem
{
    if (self.dismissType == MTWebKitDismissPopAll) {
        [self dismissViewControllerAnimated:NO completion:^{

        }];
    }
    if (self.dismissType == MTWebKitDismissPopPage) {
        UIImage *backImage = [UIImage imageNamed:@"back_blue"];
        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIButton *backBtn = [[UIButton alloc] init];
        //    [backBtn setTintColor:[MTTools_MM getPTColor]];
        [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        [self.view addSubview:backBtn];
        UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = colseItem;
    }
    if (self.dismissType == MTWebKitPop) {
        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [backBtn setImage:[[UIImage imageNamed:@"back_blue"] changeImageColor:[UIColor whiteColor]]forState:UIControlStateNormal];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
        [backBtn addTarget:self action:@selector(alertdd) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    }
}

#pragma mark 导航栏的菜单按钮
- (void)configMenuItem
{
    if (self.pushBtnShow) {
        UIImage *menuImage = [UIImage imageNamed:@"more"];
        menuImage = [menuImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIButton *menuBtn = [[UIButton alloc] init];
        [menuBtn setImage:menuImage forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [menuBtn sizeToFit];

        UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
        self.navigationItem.rightBarButtonItem = menuItem;
    }
}

- (void)menuBtnAction:(UIButton *)sender{

    MTPopMenu *popMenu = [[MTPopMenu alloc] initWithTitles:@[@"   历史工资",@"   个人工资"] images:nil];
    [popMenu popViewForSender:sender inView:self.navigationController.view selectedIndex:^(NSUInteger index) {
        if (index == 0) {
            self.urlString = [NSString stringWithFormat:@"%@%@",MT_URL_CW,@"method=view&type=2"];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
            [_wkWebView loadRequest:request];
        }
        if (index == 1) {
            self.urlString = [NSString stringWithFormat:@"%@%@",MT_URL_CW,@"method=view&type=3"];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
            [_wkWebView loadRequest:request];
        }
    }];

}

#pragma mark 导航栏的关闭按钮
- (void)configColseItem
{
    UIButton *colseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [colseBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [colseBtn setTitleColor:[MTTools_MM getPTColor] forState:UIControlStateNormal];
    [colseBtn addTarget:self action:@selector(colseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [colseBtn sizeToFit];

    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:colseBtn];
    NSMutableArray *newArr = [NSMutableArray arrayWithObjects:self.navigationItem.leftBarButtonItem,colseItem, nil];
    self.navigationItem.leftBarButtonItems = newArr;
}

#pragma mark - ***** 按钮点击事件
#pragma mark 返回按钮点击
- (void)backBtnAction:(UIButton *)sender
{
    if (IOS8x) {
        if (self.wkWebView.canGoBack) {
            [self.wkWebView goBack];
            if (self.navigationItem.leftBarButtonItems.count == 1) {
                [self configColseItem];
            }
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        if (self.webView.canGoBack) {
            [self.webView goBack];
            if (self.navigationItem.leftBarButtonItems.count == 1) {
                [self configColseItem];
            }
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark 关闭按钮点击
- (void)colseBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WKNavigationDelegate 【该代理提供的方法，可以用来追踪加载过程（页面开始加载、加载完成、加载失败）、决定是否执行跳转。】
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    // 类似UIWebView的 -webViewDidStartLoad:
    NSLog(@"didStartProvisionalNavigation");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"didCommitNavigation");
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    // 类似 UIWebView 的 －webViewDidFinishLoad:
    NSLog(@"didFinishNavigation");
    if (webView.title.length > 0 && self.intoType == 1)
    {
        self.title = webView.title;
   
    }

    [_wkWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable string, NSError * _Nullable error) {
        NSLog(@"string = %@", string);
    }];

//    self:.jsContext = [self.wkWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//        __weak typeof(self) weakSelf = self;
//        self.jsContext[@"backAppPage"] = ^(){
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.navigationController popViewControllerAnimated:YES];
//            });
//        };
}
     
#pragma mark 页面加载失败时调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
//{
//    // 类似 UIWebView 的- webView:didFailLoadWithError:
//    NSLog(@"didFailProvisionalNavigation");
//}

/*! 页面跳转的代理方法有三种，分为（收到跳转与决定是否跳转两种）*/
#pragma mark 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {

}

#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler
{
    completionHandler(@"Client Not handler");
}

#pragma mark 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"-----这个调用么%@",message);
}


#pragma mark 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.wkWebView && [keyPath isEqualToString:@"estimatedProgress"])
    {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1)
        {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }
        else
        {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - ***** dealloc 记得取消监听
- (void)dealloc
{
    if (IOS8x)
    {
        [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}

#pragma mark - ***** UIWebViewDelegate
#pragma mark 计算webView进度条
- (void)setLoadCount:(NSUInteger)loadCount
{
    _loadCount = loadCount;
    if (loadCount == 0)
    {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }
    else
    {
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95)
        {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.loadCount ++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.loadCount --;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    // 获取内容高度
    CGFloat height =  [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];

    NSLog(@"html 的高度：%f", height);

    //    CGFloat htmlHeight;
    //    // 防止死循环
    //    if (height != htmlHeight)
    //    {
    //
    //        htmlHeight = height;
    //
    //        if (height > 0)
    //        {
    //            // 更新布局
    //            CGFloat paddingEdge = 10;
    //            [webView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //
    //                make.left.equalTo(self.view).with.offset(paddingEdge);
    //                make.right.mas_equalTo(-paddingEdge);
    //                make.top.equalTo(self.view).with.offset(paddingEdge);
    //                make.bottom.mas_equalTo(-paddingEdge);
    //
    //            }];
    //
    //            // 刷新cell高度
    ////            _viewModel.cellHeight = _viewModel.otherHeight + _viewModel.htmlHeight;
    ////            [_viewModel.refreshSubject sendNext:nil];
    //        }
    //        NSLog(@"html 的高度：%f", htmlHeight);
    //    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.loadCount --;
}

// 处理拨打电话以及Url跳转等等
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        });
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)sendEvent:(UIEvent *)event{

    NSLog(@"-----sendEvent");
}

- (void)backPage {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更UI
        [_wkWebView removeFromSuperview];
        _wkWebView = nil;
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
