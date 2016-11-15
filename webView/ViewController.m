//
//  ViewController.m
//  webView
//
//  Created by label on 15/11/3.
//  Copyright © 2015年 . All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (strong ,nonatomic) UIWebView *webView;

@property (assign ,nonatomic) BOOL flage;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    //按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-60, 100, 40)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"弹框" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //网页
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60)];
    
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    // 获得网页文件的全路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"helpS.html" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:filePath];

    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    //拦截url
    NSString *str  = request.URL.absoluteString ;
    
    //JS调用OC
    if([str isEqualToString:@"ios://jwzhangjie"])
        
    {
        TwoViewController *two = [[TwoViewController alloc]init];
        [self.navigationController pushViewController:two animated:YES];
        
    }
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{

//    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    NSLog(@"当前标题：%@",[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
//    NSLog(@"当前url：%@",[webView stringByEvaluatingJavaScriptFromString:@"document.URL"]);
//    NSLog(@"当前域名：%@",[webView stringByEvaluatingJavaScriptFromString:@"btnClick;"]);
    
    if (self.flage == YES) {
        //OC调用JS
        [webView stringByEvaluatingJavaScriptFromString:@"show(1212)"];
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}

/**
 *  监听按钮点击
 */
- (void)clickBtn
{
    //刷新网页
    [self.webView reload];
    
    self.flage = YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
