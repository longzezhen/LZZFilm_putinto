//
//  ViewController.m
//  LZZFilmPutinto
//
//  Created by 龙泽桢 on 2019/4/19.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ViewController.h"
#import "HWPKWebView.h"
#import "Masonry.h"
@interface ViewController ()<WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) HWPKWebView * webView;
@property (nonatomic,strong) WKUserContentController * userCC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL * url = [NSURL URLWithString:@"http://192.168.0.124:8080/"];
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    
    self.webView = [[HWPKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.127:8080"]]];
    
    //http://192.168.0.124:8080/
    
    [self.view addSubview:self.webView];
    
    self.userCC = config.userContentController;
    
    //此处相当于监听了JS中getMessage这个方法
    [self.userCC addScriptMessageHandler:self name:@"getMessage"];
}

#pragma mark - WKNavigationDelegate
//请求之前，决定是否要跳转:用户点击网页上的链接，需要打开新页面时，将先调用这个方法。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated){
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    NSLog(@"1");
}
//接收到相应数据后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    if (!navigationResponse.isForMainFrame){
        decisionHandler(WKNavigationResponsePolicyCancel);
    }else{
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
    NSLog(@"2");
}
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{

}
// 主机地址被重定向时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{

}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{

}
// 页面加载完毕时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{

}
//跳转失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{

}
//// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler
//{
//
//}




////9.0才能使用，web内容处理中断时会触发
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);

//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//
//}
//
//- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
//
//}

#pragma mark  WKScriptMessageHandler delegate
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //这个回调里面， message.name代表方法名（‘本例为 callFunction’）， message.body代表JS给我们传过来的参数
    if ([message.name isEqualToString:@"getMessage"]) {
        //执行相应代码
    }
}

#pragma mark - get
//-(HWPKWebView *)webView
//{
//    if (!_webView) {
//        _webView = [[HWPKWebView alloc] init];
//        _webView.navigationDelegate = self;
//        [self.view addSubview:_webView];
//        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(0);
//        }];
//    }
//    return _webView;
//}
@end
