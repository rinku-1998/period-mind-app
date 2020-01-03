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

@end
