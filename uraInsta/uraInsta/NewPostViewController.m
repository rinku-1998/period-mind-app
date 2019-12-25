//
//  NewPostViewController.m
//  uraInsta
//
//  Created by mac18 on 2019/12/25.
//  Copyright © 2019 mac12. All rights reserved.
//

#import "NewPostViewController.h"

@interface NewPostViewController ()

@end

@implementation NewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        int rgbValue = 0xF44336;
    
        _textPostContent.textColor = [UIColor lightGrayColor];
        _textPostContent.text = @"寫點什麼吧";
    
        [_textPostContent setDelegate:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)textViewDidChange:(UITextView *)textView{
    if(_textPostContent.text.length == 0){
        _textPostContent.textColor = [UIColor lightGrayColor];
        _textPostContent.text = @"寫點什麼吧";
        [_textPostContent resignFirstResponder];
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _textPostContent.text = @"";
    _textPostContent.textColor = [UIColor blackColor];
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(_textPostContent.text.length == 0){
        _textPostContent.textColor = [UIColor lightGrayColor];
        _textPostContent.text = @"寫點什麼吧";
        [_textPostContent resignFirstResponder];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewCell *view = [tableView dequeueReusableCellWithIdentifier:@"newPostCell"];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 220;
}


@end
