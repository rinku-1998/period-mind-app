//
//  CommentViewController.h
//  uraInsta
//
//  Created by eb211 on 2020/1/4.
//  Copyright © 2020 mac12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebAPIServerSetting.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    NSMutableArray *commentArray;
    
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImage *accountAvatar;
@property (strong, nonatomic) NSNumber *postID;
@property (strong, nonatomic) NSString *accountName;
@property (strong, nonatomic) NSString *postTime;
@property (strong, nonatomic) NSString *postContent;
@property (strong, nonatomic) NSMutableDictionary *postInfo;
@property (strong, nonatomic) IBOutlet UITextView *textCommentContent;

@end

NS_ASSUME_NONNULL_END
