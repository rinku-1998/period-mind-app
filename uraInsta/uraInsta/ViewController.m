//
//  ViewController.m
//  uraInsta
//
//  Created by mac12 on 2019/12/10.
//  Copyright © 2019 mac12. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mytableview.delegate=self;
    _mytableview.dataSource=self;
    UINib *cell_nib=[UINib nibWithNibName:@"tableHeader" bundle:nil];
    [self.mytableview registerNib:cell_nib forCellReuseIdentifier:@"newPostCell"];
    
    testarr= [[NSMutableArray alloc]initWithObjects:nil];
    for (int i=0; i<10; i++) {
        [testarr addObject:[NSString stringWithFormat:@"%d",i]];
        for (int j=0;j<=i;j++) {
            NSString *s = [testarr objectAtIndex:i];
            s = [s stringByAppendingString:@"我是大佬"];
            [testarr replaceObjectAtIndex:i withObject:s];
        }
    }
    
    [self getPostCentent];
// Do any additional setup after loading the view.
//    int rgbValue = 0xF44336;
//    [_button_postAndShare setBackgroundColor:[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]];
//    [_button_postAndShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_button_postAndShare.layer setCornerRadius:5.f];
//
//    _textView_postContent.textColor = [UIColor lightGrayColor];
//    _textView_postContent.text = @"寫點什麼吧";
//
//    [_textView_postContent setDelegate:self];
}
//-(void)textViewDidChange:(UITextView *)textView{
//    if(_textView_postContent.text.length == 0){
//        _textView_postContent.textColor = [UIColor lightGrayColor];
//        _textView_postContent.text = @"寫點什麼吧";
//        [_textView_postContent resignFirstResponder];
//    }
//}
//
//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    _textView_postContent.text = @"";
//    _textView_postContent.textColor = [UIColor blackColor];
//    return YES;
//}
//- (void)textViewDidEndEditing:(UITextView *)textView{
//    if(_textView_postContent.text.length == 0){
//        _textView_postContent.textColor = [UIColor lightGrayColor];
//        _textView_postContent.text = @"寫點什麼吧";
//        [_textView_postContent resignFirstResponder];
//    }
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UITableViewCell *view = [tableView dequeueReusableCellWithIdentifier:@"newPostCell"];
//    return view;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 220;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [postArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==0) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newPostCell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//    else
//    {
//        NSString *cellID=@"cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        }
//        NSString *str = [testarr objectAtIndex:indexPath.row];
//        cell.textLabel.text=str;
//        return cell;
//    }
    NSString *cellID=@"postContentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
    NSString *str = [testarr objectAtIndex:indexPath.row];
    UITextView *tv = [cell viewWithTag:1];
    UILabel *accountName = [cell viewWithTag:2];
    UIImageView *postImage = [cell viewWithTag:4];
    UILabel *postTime = [cell viewWithTag:5];
    NSDictionary *post_data = [postArray objectAtIndex:indexPath.row];
    tv.text = [post_data objectForKey:@"postContent"];
    [tv setEditable:NO];
    accountName.text = [post_data objectForKey:@"accountName"];
    postTime.text = [post_data objectForKey:@"postTime"];
    if([imageDict objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]]){
        postImage.image = [imageDict objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    tv.text = [testarr objectAtIndex:indexPath.row];
    return cell;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UITableViewCell *view = [tableView dequeueReusableCellWithIdentifier:@"postContentLastCell"];
//    return view;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 100.0f;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    if (indexPath.row==0) {
////        return 220.0f;
////    }
//    return 500.f;
//}



-(void)getPostCentent{
    NSString *url_string = @"http://127.0.0.1:5000/api/index";
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
            postArray = jsonArray;
            NSLog(@"%lu", [jsonArray count]);
            NSInteger length = [jsonArray count];
            imageDict = [NSMutableDictionary new];
            for(int i=0;i<length;i++){
                [self getPostImage: [jsonArray[i] objectForKey:@"postImage"] currentIndex:i];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                [_mytableview reloadData];
            });
        }
        
    }];
    [task resume];
}

-(void)getPostImage:(NSString *)imgName currentIndex:(NSInteger)index{
    NSLog(@"%@", imgName);
    NSString *img_url = [NSString stringWithFormat:@"http://127.0.0.1:5000/static/images/%@", imgName];
    NSURL *url = [NSURL URLWithString:img_url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"Get error :%@", error.localizedDescription);
        }else{
            if(data){
                UIImage *image = [UIImage imageWithData:data];
                [self->imageDict setObject:image forKey:[NSString stringWithFormat:@"%ld", index]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self->_mytableview reloadData];
                                
                });
            }
            
        }
        
    }];
    [task resume];
}
- (IBAction)editProfile:(id)sender {
}
@end
