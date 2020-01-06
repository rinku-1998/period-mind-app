//
//  SetNewPasswordViewController.h
//  uraInsta
//
//  Created by phantomSTo on 2019/12/24.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetNewPasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textNewPassword;
@property (strong, nonatomic) IBOutlet UITextField *textCheckNewPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnCheck;

@end

NS_ASSUME_NONNULL_END
