//
//  NewPostViewController.h
//  uraInsta
//
//  Created by mac18 on 2019/12/25.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebAPIServerSetting.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewPostViewController : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImagePickerController *imagePicker;
    UIImage *selectedImage;
}

@property (strong, nonatomic) IBOutlet UITextView *textPostContent;
@property (strong, nonatomic) IBOutlet UILabel *labelAccountName;
@property (strong, nonatomic) IBOutlet UILabel *labelDisplayname;
@property (strong, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (strong, nonatomic) IBOutlet UIImageView *imgPreviewImage;
@property (strong, nonatomic) NSString *tempPostContent;
@end

NS_ASSUME_NONNULL_END
