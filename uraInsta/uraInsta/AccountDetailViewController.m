//
//  AccountDetailViewController.m
//  uraInsta
//
//  Created by phantomSTo on 2019/12/24.
//  Copyright © 2019 mac12. All rights reserved.
//

#import "AccountDetailViewController.h"
#import "AccountDetailEditViewController.h"

@interface AccountDetailViewController ()

@end

@implementation AccountDetailViewController
@synthesize loadOnce;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadOnce = false;
    // Do any additional setup after loading the view.
    [self getMyProfileInfo];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.loadOnce){
        [self getMyProfileInfo];
    }
    self.loadOnce = true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AccountDetailEditViewController class]])
    {
        AccountDetailEditViewController *editPage = segue.destinationViewController;
        editPage.accountEmail=_labelAccountEmail.text;
        editPage.accountTopName=_labelAccountTopName.text;
        editPage.accountBottomName=_labelAccountBottomName.text;
        editPage.accountDetail=_labelAccountDetail.text;
        
    }
}
-(IBAction)backFromAccountDetailEditViewController:(UIStoryboardSegue *)backSegue
{
    if ([backSegue.sourceViewController isKindOfClass:[AccountDetailEditViewController class]])
    {
        AccountDetailEditViewController *editPage = backSegue.sourceViewController;
        _labelAccountTopName.text=editPage.textAccountTopName.text;
        _labelAccountBottomName.text=editPage.textAccountBottomName.text;
        _labelAccountDetail.text=editPage.textAccountDetail.text;
    }
}
-(void)getMyProfileInfo{
    NSString *url_string = @"http://127.0.0.1:5000/api/myprofile";
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"Get error :%@", error.localizedDescription);
        }else{
            NSError* json_load_rror;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&json_load_rror];

            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", result);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.labelAccountTopName.text = [jsonDict objectForKey:@"username"];
                self.labelAccountEmail.text = [jsonDict objectForKey:@"email"];
                NSString *display_name =[[NSString alloc]init];
                display_name = @"@";
                display_name = [display_name stringByAppendingString:[jsonDict objectForKey:@"display_name"]];
                self.labelAccountBottomName.text = display_name;
                self.labelAccountDetail.text = [jsonDict objectForKey:@"profile_info"];
                self.labelCreateTime.text = [jsonDict objectForKey:@"createTime"];
            });
        }
        
    }];
    [task resume];
}
@end
