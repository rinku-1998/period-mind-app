//
//  CommentViewController.m
//  uraInsta
//
//  Created by eb211 on 2020/1/4.
//  Copyright © 2020 mac12. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    // Do any additional setup after loading the view.
    NSLog(@"postID=%@", [self.postInfo objectForKey:@"postID"]);
    [self getCommentCentent:[self.postInfo objectForKey:@"postID"]];
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger cell_counts = 1 + [commentArray count];
    return cell_counts;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if(indexPath.row == 0){
        NSString *cellID = @"postContentCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        UILabel *accountName = [cell viewWithTag:1];
        UIImageView *postImage = [cell viewWithTag:2];
        UILabel *postTime = [cell viewWithTag:3];
        UITextField *postContent = [cell viewWithTag:4];
        
        accountName.text = [self.postInfo objectForKey:@"accountName"];
        postImage.image = [self.postInfo objectForKey:@"postImage"];
        postTime.text = [self.postInfo objectForKey:@"postTime"];
        postContent.text = [self.postInfo objectForKey:@"postContent"];
        
    }else{
        NSString *cellID = @"commentContentCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        UILabel *accountName = [cell viewWithTag:5];
        UILabel *commentTime = [cell viewWithTag:6];
        UILabel *commentContent = [cell viewWithTag:7];
        
        NSDictionary *comment_dict = [commentArray objectAtIndex:indexPath.row-1];
        
        accountName.text = [comment_dict objectForKey:@"accountName"];
        commentTime.text = [comment_dict objectForKey:@"commentTime"];
        commentContent.text = [comment_dict objectForKey:@"commentContent"];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)getCommentCentent:(NSString*)postID{
    NSString *url_string = [NSString stringWithFormat:@"http://127.0.0.1:5000/api/getComment/%@", postID];
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"Get error :%@", error.localizedDescription);
        }else{
            NSError* json_load_rror;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&json_load_rror];
            self->commentArray = [NSMutableArray arrayWithArray:jsonArray];
            NSLog(@"comment count=%lu", [jsonArray count]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_tableView reloadData];
            });
        }
        
    }];
    [task resume];
}
@end
