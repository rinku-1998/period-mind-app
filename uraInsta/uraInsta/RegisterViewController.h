//
//  RegisterViewController.h
//  uraInsta
//
//  Created by mac18 on 2019/12/18.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebAPIServerSetting.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textAccountName;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UITextField *textPassword2;
@property (strong, nonatomic) IBOutlet UITextField *textDisplayname;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;

@end

NS_ASSUME_NONNULL_END
