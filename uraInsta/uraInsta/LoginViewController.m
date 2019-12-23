//
//  LoginViewController.m
//  uraInsta
//
//  Created by mac18 on 2019/12/18.
//  Copyright © 2019 mac12. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.destinationViewController isKindOfClass:[ViewController class]])
//    {
//        NSLog(@"ok");
//    }
//    else
//    {
//        NSLog(@"no");
//    }
//}

//- (IBAction)btnLogin:(id)sender {
//    if ([_textEmail.text isEqualToString:@"1"]) {
//        NSLog(@"go");
//        ViewController *view = [[ViewController alloc] init];
//        [self showDetailViewController:view sender:nil];
//    }
//    else
//    {
//        NSLog(@"no");
//    }
//}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"gotoindex"]){
        NSLog(@"%@", identifier);
        NSString *url_string = @"http:127.0.0.1:5000/login";
//        NSString *url_string = @"http:127.0.0.1:5000/index";
        
        NSURL *url = [NSURL URLWithString:url_string];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
//        [request setHTTPMethod:@"GET"];
        [request setTimeoutInterval:10.0];
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        /*
        NSDictionary *parameterDict = @{@"email":@"aaa@aaa.com", @"password":@"aaa"};
        NSMutableString *parameter_string = [[NSMutableString alloc]init];
        int pos=0;
        for(NSString *key in parameterDict.allKeys){
            [parameter_string appendFormat:@"%@=%@", key, parameterDict[key]];
            if(pos<parameterDict.allKeys.count-1){
                [parameter_string appendString:@"&"];
            }
            pos++;
        }*/
        NSString *parameter = @"email=aaa@aaa.com&password=aaa&submit=submit";
//        NSLog(@"%@", parameter_string);
        NSData *parameter_data = [parameter dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:parameter_data];
//        [request setHTTPBody:[nssringfro]]
        
//        NSLog(@"%@", request);
        NSURLSession *session = [NSURLSession sharedSession];
//        NSURLSessionConfiguration *session_conf = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:session_conf];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if(error){
                NSLog(@"Get error :%@", error.localizedDescription);
            }else{
                
                NSLog(@"%@", result);
            }
        }];
        [task resume];
        /*
        NSData *recieved = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSData *new = [
        NSString *str = [[NSString alloc]initWithData:recieved  encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
         */
        if([self.textEmail.text isEqualToString:@"123"]){
            return YES;
        }
    }else{
        return YES;
    }
    return NO;
}


@end
