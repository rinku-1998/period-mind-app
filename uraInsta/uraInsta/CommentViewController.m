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
    self.navigationItem.backBarButtonItem.title = @"";
 
}
- (IBAction)btn_postComment:(id)sender {
    [self getCSRFTokenAndComment];
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

-(void)getCSRFTokenAndComment{
    
    NSString *url_string = @"http://127.0.0.1:5000/api/comment";
    __block NSString *csrf_token = @"";
    NSURL *url = [NSURL URLWithString:url_string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            // If error happened, print out error msg
            NSLog(@"Get error :%@", error.localizedDescription);
        }else{
            NSString *target_tag = @"<input id=\"csrf_token\" name=\"csrf_token\" type=\"hidden\" value=\""; //Set catch tag
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]; //HTML content
            if([result rangeOfString:target_tag].location){
                NSUInteger start_point = [result rangeOfString:target_tag].location + [result rangeOfString:target_tag].length;
                csrf_token = [result substringWithRange:NSMakeRange(start_point, 91)];
                //If csrf token is caught successfully, do http post request in main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"csrf=%@", csrf_token);
                    [self sendComment:csrf_token];
                });
            }
        }
    }];
    [task resume];
}
-(void)sendComment:(NSString *)csrf_token{
    NSString *commentContent = self.textCommentContent.text;
    NSString *url_string = @"http://127.0.0.1:5000/api/comment";
    NSURL *url = [NSURL URLWithString:url_string];
    NSString *boundary = [[NSUUID UUID] UUIDString];
    NSString *headerString = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:30.0];
    [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:headerString forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *httpBody = [NSMutableData data];
    // csrf_token
    NSString *csrfTokenParam = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", boundary, @"csrf_token", csrf_token, nil];
    [httpBody appendData:[csrfTokenParam dataUsingEncoding:NSUTF8StringEncoding]];
    // Post content text
    NSString *postIDParam = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", boundary, @"postID", [self.postInfo objectForKey:@"postID"], nil];
    [httpBody appendData:[postIDParam dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *commentParam = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", boundary, @"commentContent", commentContent, nil];
    [httpBody appendData:[commentParam dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *fileParam = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n", boundary, @"commentImage", @"", nil];
    [httpBody appendData:[fileParam dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *endSting = [NSString stringWithFormat:@"--%@--", boundary];
    [httpBody appendData:[endSting dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *upload_task = [session uploadTaskWithRequest:request fromData:httpBody completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }else{
            NSLog(@"Upload success!");
            NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if([result isEqualToString:@"ok"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.textCommentContent.text = @"";
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }
        }
    }];
    [upload_task resume];
    
}
@end
