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
        if([self.textEmail.text isEqualToString:@"123"]){
            return YES;
        }
    }else{
        return YES;
    }
    return NO;
}

@end
