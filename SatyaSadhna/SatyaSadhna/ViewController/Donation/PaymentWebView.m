//
//  PaymentWebView.m
//  SatyaSadhna
//
//  Created by kishlay kishore on 26/02/21.
//  Copyright © 2021 Roshan Singh Bisht. All rights reserved.
//
#import "PaymentWebView.h"

@interface PaymentWebView()<UIWebViewDelegate>
    

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PaymentWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = kLangualString(@"Transaction");
    self.addLeftBarBarBackButtonEnabled = YES;
    _webView.opaque = YES;
    _webView.scalesPageToFit = YES;
    
  //  [self.view addSubview:activityIndicatorView];
   // [activityIndicatorView startAnimating];
    self.view.backgroundColor = kBgImage;
    self.view.layer.contents = (id)[UIImage imageNamed:@"loginBg"].CGImage;
    //NSURL *URL = [NSURL URLWithString:@"http://www.google.com"];
    [_webView loadRequest:[NSURLRequest requestWithURL:_targetURL]];

}

//fileprivate func checkResponseUrl() {
//    let string = (viewWeb.request?.url?.absoluteString)!
//    print("String :: \(string)")
//
//    if(string.contains(redirectUrl))
//    {
//        print(viewWeb.isLoading)
//        guard let htmlTemp:NSString = viewWeb.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML") as NSString? else{
//            print("failed to evaluate javaScript")
//            return
//        }
//
//        let html = htmlTemp
//        print("html :: ",html)
//        var transStatus = "Not Known"
//
//        if ((html ).range(of: "tracking_id").location != NSNotFound) && ((html ).range(of: "bin_country").location != NSNotFound) {
//            if ((html ).range(of: "Aborted").location != NSNotFound) || ((html ).range(of: "Cancel").location != NSNotFound) {
//                transStatus = "Transaction Cancelled"
//                let controller: CCResultViewController = CCResultViewController()
//                controller.transStatus = transStatus
//                self.present(controller, animated: true, completion: nil)
//            }
//            else if ((html ).range(of: "Success").location != NSNotFound) {
//                transStatus = "Transaction Successful"
//                let controller: CCResultViewController = CCResultViewController()
//                controller.transStatus = transStatus
//                self.present(controller, animated: true, completion: nil)
//            }
//            else if ((html ).range(of: "Fail").location != NSNotFound) {
//                transStatus = "Transaction Failed"
//                let controller: CCResultViewController = CCResultViewController()
//                controller.transStatus = transStatus
//                self.present(controller, animated: true, completion: nil)
//            }
//        }
//        else{
//            print("html does not contain any related data")
//            displayAlert(msg: "html does not contain any related data for this transaction.")
//        }
//    }
//}

- (void)checkResponseUrl {
    //
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *string = _webView.request.URL.absoluteString;
   // printf(@"String =" \(string))
    if ([string containsString:@"https://www.satyasadhna.com/payment-gateway/payment-response.php"])  {
        printf([_webView isLoading]);
        NSString *htmlTemp = [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
       // printf(@"HTML" [htmlTemp]);
        NSString *html = htmlTemp;
        printf("%s", htmlTemp);
//        if ([html rangeOfString:@"<[^>]+>|&nbsp;" options:NSRegularExpressionSearch]).location != NSNotFound] = @"true") {
//
//        }
    }
   // [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
   // [activityIndicatorView stopAnimating];
}
@end
