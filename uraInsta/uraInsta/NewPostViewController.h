//
//  NewPostViewController.h
//  uraInsta
//
//  Created by mac18 on 2019/12/25.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewPostViewController : UIViewController <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textPostContent;

@end

NS_ASSUME_NONNULL_END
