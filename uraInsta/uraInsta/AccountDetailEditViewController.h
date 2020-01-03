//
//  AccountDetailEditViewController.h
//  uraInsta
//
//  Created by phantomSTo on 2019/12/24.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountDetailEditViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textAcountName;
@property (strong, nonatomic) IBOutlet UITextView *textAccountDetail;
@property (strong, nonatomic) IBOutlet UITextField *textAccountDisplayName;
@property (strong, nonatomic) IBOutlet UILabel *labelAccountEmail;
@property (strong, nonatomic) IBOutlet UITextField *textAccountEmail;
@property (nonatomic,copy) NSString *accountEmail;
@property (nonatomic,copy) NSString *accountName;
@property(nonatomic,copy) NSString *accountDetail;

@end

NS_ASSUME_NONNULL_END
