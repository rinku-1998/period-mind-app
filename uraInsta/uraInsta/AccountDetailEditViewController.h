//
//  AccountDetailEditViewController.h
//  uraInsta
//
//  Created by phantomSTo on 2019/12/24.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebAPIServerSetting.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountDetailEditViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textAccountTopName;
@property (strong, nonatomic) IBOutlet UITextView *textAccountDetail;
@property (strong, nonatomic) IBOutlet UITextField *textAccountEmail;
@property (strong, nonatomic) IBOutlet UITextField *textAccountBottomName;
@property (nonatomic,copy) NSString *accountEmail;
@property (nonatomic,copy) NSString *accountBottomName;
@property (nonatomic,copy) NSString *accountTopName;
@property (nonatomic,copy) NSString *accountDetail;

@end

NS_ASSUME_NONNULL_END
