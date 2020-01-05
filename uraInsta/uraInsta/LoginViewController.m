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

- (IBAction)btn_login:(id)sender {
    [self getCSRFTokenAndLogin];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    //Check current segue identifier
    if([identifier isEqualToString:@"gotoindex"]){
        NSLog(@"%@", identifier);
//        [self getCSRFToken];
        
        if([self.textEmail.text isEqualToString:@"123"]){
            return YES;
        }
    }else{
        return YES;
    }
    return NO;
}

-(void)getCSRFTokenAndLogin{
    
    NSString *SERVER_URL_PREFIX = [NSString stringWithFormat:@"%@", SERVER_URL];
    NSString *url_string = [NSString stringWithFormat:@"%@login", SERVER_URL_PREFIX];
    __block NSString *csrf_token = @""; //'__block' makes block code can access this variable
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            // If error happened, print out error msg
            NSLog(@"Get error :%@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"伺服器沒有回應" message:@"請確認您的網路線線，然後再試一次" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *dismissMsg = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:dismissMsg];
                [self presentViewController:alert animated:YES completion:nil];
            });
            
            
        }else{
            NSString *target_tag = @"<input id=\"csrf_token\" name=\"csrf_token\" type=\"hidden\" value=\""; //Set catch tag
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]; //HTML content
            if([result rangeOfString:target_tag].location){
                NSUInteger start_point = [result rangeOfString:target_tag].location + [result rangeOfString:target_tag].length;
                csrf_token = [result substringWithRange:NSMakeRange(start_point, 91)];
                //If csrf token is caught successfully, do http post request in main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"csrf=%@", csrf_token);
                    [self login:csrf_token];
                });
            }
        }
    }];
    [task resume];
}

-(void)login:(NSString *)csrf_token{
    NSString *email = self.textEmail.text;
    NSString *password = self.textPassword.text;
    NSString *SERVER_URL_PREFIX = [NSString stringWithFormat:@"%@", SERVER_URL];
    NSString *url_string = [NSString stringWithFormat:@"%@login", SERVER_URL_PREFIX];
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:10.0];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    NSString *parameter = [[NSString alloc]initWithFormat:@"csrf_token=%@&email=%@&password=%@&submit=submit",csrf_token, email, password];
    NSData *parameter_data = [parameter dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:parameter_data];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            // If error happened, print out error msg
            NSLog(@"Get error :%@", error.localizedDescription);
            
        }else{
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", result);
            if([result isEqualToString:@"ok"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"gotoindex" sender:nil];
                });
                
            }
        }
    }];
    [task resume];
    
}

@end
