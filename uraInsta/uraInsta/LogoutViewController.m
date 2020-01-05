//
//  LogoutViewController.m
//  uraInsta
//
//  Created by eb211 on 2020/1/4.
//  Copyright © 2020 mac12. All rights reserved.
//

#import "LogoutViewController.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)logout:(id)sender {
    [self goLogout];
}
-(void)goLogout{
    
    NSString *SERVER_URL_PREFIX = [NSString stringWithFormat:@"%@", SERVER_URL];
    NSString *url_string = [NSString stringWithFormat:@"%@logout", SERVER_URL_PREFIX];
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"Get error :%@", error.localizedDescription);
        }else{
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", result);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"go2Login" sender:nil];
            });
        }
        
    }];
    [task resume];
}

@end
