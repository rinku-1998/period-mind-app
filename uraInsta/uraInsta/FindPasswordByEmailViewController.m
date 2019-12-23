//
//  FindPasswordByEmailViewController.m
//  uraInsta
//
//  Created by phantomSTo on 2019/12/23.
//  Copyright © 2019 mac12. All rights reserved.
//

#import "FindPasswordByEmailViewController.h"

@interface FindPasswordByEmailViewController ()

@end

@implementation FindPasswordByEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)sendVerifyCode:(id)sender {
    _textVerifyCode.enabled=YES;
    _btnCheckVerifyCode.enabled=YES;
}

/*
#pragma mark - Naviga	tion

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
