//
//  MTWebViewController.m
//  MTRealEstate
//
//  Created by HaoSun on 2017/5/11.
//  Copyright © 2017年 MaiTianMM. All rights reserved.
//

#import "MTNO_NETView.h"
#import "MTWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIImage+G.h"
#import "WYWebProgressLayer.h"

#define CheckWagesUrl MT_URL_CW
#define URL1 [self checkUrl]
#define URL2 [NSString stringWithFormat:@"%@%@",CheckWagesUrl,@"method=view&type=2"]//历史工资
#define URL3 [NSString stringWithFormat:@"%@%@",CheckWagesUrl,@"method=view&type=3"]//店员工资
#define Title1 @"工资核对"
#define Title2 @"历史工资查询"
#define Title3 @"店员工资核对"

@interface MTWebViewController ()<UIWebViewDelegate>
{
    WYWebProgressLayer *_progressLayer; ///< 网页加载进度条
}
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic, weak) UIButton *menuBtn;
@property (nonatomic, weak) UIBarButtonItem *menuItem;
@property (nonatomic, assign) NSInteger checkMenuType;
@property (nonatomic, weak) MTNO_NETView *no_netView;
@property (nonatomic, assign) BOOL netFlag;
@end

@implementation MTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUi];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backBtn setImage:[[UIImage imageNamed:@"back_blue"] changeImageColor:[UIColor whiteColor]]forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [backBtn addTarget:self action:@selector(goooback) forControlEvents:UIControlEventTouchUpInside];
    if (![MTHttpRequest_Helper jundgeNetworkStatus]) {
        [self setNetError];
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }else{
        if (_isFromMessage == 2) {
            //查工资
            [self setupMoreBtn];

        }
    }
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpUi {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    self.webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [_webView loadRequest:request];
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];

}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    _progressLayer = [WYWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, 42, SCREEN_WIDTH, 2);

    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    [_progressLayer startLoad];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

- (void)dealloc {

    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
    NSLog(@"i am dealloc");
}


- (void)setIsFromMessage:(NSInteger)isFromMessage {
    _isFromMessage = isFromMessage;
}
- (void)setUrl:(NSString *)url {
    _url = url;
}

- (void)goooback {
    if ([MTHttpRequest_Helper jundgeNetworkStatus] && self.netFlag == YES) {
        NSString *alertJS = @"goBackApp()";
        [self.jsContext evaluateScript:alertJS];
    }else{
        [self goBack];
    }}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
#pragma mark - 判断网络连接状态
- (void)setNetError{
    MTNO_NETView *no_netView = [[MTNO_NETView alloc] initWithView:self.view];
    _no_netView = no_netView;
    [self.view addSubview:_no_netView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.netFlag = YES;
    NSString *title = [NSString stringWithFormat:@"%@",[[webView request] URL]];
    if ([title isEqualToString:URL1] || [title isEqualToString:URL2] || [title isEqualToString:URL3]) {
        if ([title isEqualToString:URL1]) {
            self.checkMenuType = 0;
        }
        if ([title isEqualToString:URL2]) {
            self.checkMenuType = 1;
        }
        if ([title isEqualToString:URL3]) {
            self.checkMenuType = 2;
        }
        _menuBtn.hidden = NO;
    }else{
        _menuBtn.hidden = YES;
    }
    [_progressLayer finishedLoad];

    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __weak typeof(self) weakSelf = self;

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    self.jsContext[@"backAppPage"] = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    };

    self.jsContext[@"traferTitle"] = ^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
            NSArray *arg = [JSContext currentArguments];
            for (id object in arg) {
                if ([object isKindOfClass:[NSString class]]) {

                    weakSelf.title = (NSString *)object;
                }
            }

        });

    };

}

- (void)sayHello {

}
- (void)callback:(NSString *)call
{
    // 调用JS的方法
    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
    [jsParamFunc callWithArguments:@[@{@"a": @"10", @"b": @"1"}]];
}

- (void)setupMoreBtn{
    UIImage *menuImage = [UIImage imageNamed:@"more"];
    menuImage = [menuImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *menuBtn = [[UIButton alloc] init];
    [menuBtn setImage:menuImage forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn sizeToFit];
    _menuBtn = menuBtn;
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:_menuBtn];
    _menuItem = menuItem;
    self.navigationItem.rightBarButtonItem = _menuItem;
}

- (void)menuBtnAction:(UIButton *)sender{
    if (![MTHttpRequest_Helper jundgeNetworkStatus]) {
        return;
    }
    if (self.checkMenuType == 0) {
        MTPopMenu *popMenu = [[MTPopMenu alloc] initWithTitles:@[@"历史工资查询",@"店员工资复核"] images:nil];
        [popMenu popViewForSender:sender inView:self.navigationController.view selectedIndex:^(NSUInteger index) {
            if (index == 0) {//历史工资
                self.checkMenuType = 1;
                self.url = URL2;
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
                [_webView loadRequest:request];
            }
            if (index == 1) {//店员工资
                self.checkMenuType = 2;
                self.url = URL3;
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
                [_webView loadRequest:request];
            }
        }];
    }

    if (self.checkMenuType == 1) {
        MTPopMenu *popMenu = [[MTPopMenu alloc] initWithTitles:@[@"工资核对",@"店员工资复核"] images:nil];
        [popMenu popViewForSender:sender inView:self.navigationController.view selectedIndex:^(NSUInteger index) {
            if (index == 0) {//个人工资
                self.checkMenuType = 0;
                self.url = [self checkUrl];
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
                [_webView loadRequest:request];
            }
            if (index == 1) {//店员工资
                self.checkMenuType = 2;
                self.url = URL3;
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
                [_webView loadRequest:request];
            }
        }];
    }

    if (self.checkMenuType == 2) {
        MTPopMenu *popMenu = [[MTPopMenu alloc] initWithTitles:@[@"工资核对",@"历史工资查询"] images:nil];
        [popMenu popViewForSender:sender inView:self.navigationController.view selectedIndex:^(NSUInteger index) {
            if (index == 0) {//个人工资
                self.checkMenuType = 0;
                self.url = [self checkUrl];
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
                [_webView loadRequest:request];
            }
            if (index == 1) {//历史工资
                self.checkMenuType = 1;
                self.url = URL2;
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
                [_webView loadRequest:request];
            }
        }];
    }

}

//个人工资
- (NSString *)checkUrl{
    NSString *exBaseUrl = CheckWagesUrl;
    NSString *method = @"index";
    NSString *utf8Str = [MTInfoSingle shareInstance].userLoginName;
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)utf8Str,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8 ));
    NSString *passWord = [[[MTInfoSingle shareInstance].password md5String] substringWithRange:NSMakeRange(8, 16)];
    NSString *urlStr = [NSString stringWithFormat:@"%@method=%@&u=%@&p=%@",exBaseUrl,method,encodedString,passWord];
    return urlStr;
}

- (void)setNetFlag:(BOOL)netFlag{
    _netFlag = netFlag;
}
@end
