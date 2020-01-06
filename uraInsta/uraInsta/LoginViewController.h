//
//  LoginViewController.h
//  uraInsta
//
//  Created by mac18 on 2019/12/18.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebAPIServerSetting.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@end

NS_ASSUME_NONNULL_END
