//
//  FindPasswordByEmailViewController.h
//  uraInsta
//
//  Created by phantomSTo on 2019/12/23.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindPasswordByEmailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UITextField *textVerifyCode;
@property (strong, nonatomic) IBOutlet UIButton *btnSendVerifyCode;
@property (strong, nonatomic) IBOutlet UIButton *btnCheckVerifyCode;

@end

NS_ASSUME_NONNULL_END
