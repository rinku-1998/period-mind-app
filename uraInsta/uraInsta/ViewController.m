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
    return [testarr count];
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
    tv.text = [testarr objectAtIndex:indexPath.row];
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
@end
