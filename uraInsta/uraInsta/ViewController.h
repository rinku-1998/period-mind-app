//
//  ViewController.h
//  uraInsta
//
//  Created by mac12 on 2019/12/10.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CommentViewController.h"
#import "WebAPIServerSetting.h"

@interface ViewController : UIViewController <UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *testarr;
    NSMutableArray *postArray;
    NSMutableDictionary *imageDict;
    NSInteger *selectedIndex;
    NSMutableDictionary *postInfo;
    NSNumber *postLength;
    NSNumber *loadLength;
    bool refresh;
}
@property (strong, nonatomic) IBOutlet UITableView *mytableview;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UITextView *labelText;


@end

