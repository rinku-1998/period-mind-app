//
//  ViewController.h
//  uraInsta
//
//  Created by mac12 on 2019/12/10.
//  Copyright © 2019 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *testarr;
}
@property (strong, nonatomic) IBOutlet UITableView *mytableview;
@property (strong, nonatomic) IBOutlet UITextField *textEmail;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
@property (strong, nonatomic) IBOutlet UITextView *labelText;

@end

