//
//  AccountDetailEditViewController.m
//  uraInsta
//
//  Created by phantomSTo on 2019/12/24.
//  Copyright © 2019 mac12. All rights reserved.
//

#import "AccountDetailEditViewController.h"

@interface AccountDetailEditViewController ()

@end

@implementation AccountDetailEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _textAccountEmail.text=self.accountEmail;
    _textAccountTopName.text=self.accountTopName;
    _textAccountBottomName.text=self.accountBottomName;
    _textAccountDetail.text=self.accountDetail;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveAndBack:(id)sender {
//    [self performSegueWithIdentifier:@"saveAndBack" sender:sender];
    [self getCSRFTokenAndChange];
}

-(void)getCSRFTokenAndChange{
    
    NSString *url_string = @"http://127.0.0.1:5000/api/editProfile";
    __block NSString *csrf_token = @"";
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            // If error happened, print out error msg
            NSLog(@"Get error :%@", error.localizedDescription);
        }else{
            NSString *target_tag = @"<input id=\"csrf_token\" name=\"csrf_token\" type=\"hidden\" value=\""; //Set catch tag
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]; //HTML content
            if([result rangeOfString:target_tag].location){
                NSUInteger start_point = [result rangeOfString:target_tag].location + [result rangeOfString:target_tag].length;
                csrf_token = [result substringWithRange:NSMakeRange(start_point, 91)];
                //If csrf token is caught successfully, do http post request in main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"csrf=%@", csrf_token);
                    [self changeProfile:csrf_token];
                });
            }
        }
    }];
    [task resume];
}
-(void)changeProfile:(NSString *)csrf_token{
    NSString *username = self.textAcountName.text;
    NSString *displayname = self.textAccountDisplayName.text;
    NSString *email = self.textAccountEmail.text;
    NSString *profile_info = self.textAccountDetail.text;
    NSString *url_string = @"http://127.0.0.1:5000/api/editProfile";
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:10.0];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    NSString *parameter = [[NSString alloc]initWithFormat:@"csrf_token=%@&username=%@&display_name=%@&profileInfo=%@",csrf_token, username, displayname, profile_info];
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
            if([result isEqualToString:@"changed"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
                
            }
        }
    }];
    [task resume];
    
}

@end
