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

@end
