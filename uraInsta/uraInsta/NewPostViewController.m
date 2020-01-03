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
- (IBAction)selectPicture:(id)sender {
    imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setEditing:YES];
    [imagePicker setAllowsEditing:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"請選擇開啟方式" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍攝相片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
        [imagePicker setMediaTypes:mediaTypes];
        [imagePicker setDelegate:self];
        [imagePicker setShowsCameraControls:YES];
        [imagePicker setCameraCaptureMode:UIImagePickerControllerCameraCaptureModePhoto];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"從相簿選取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:camera];
    [alert addAction:photo];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        selectedImage = image;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)postAndUpload:(id)sender {
    [self getCSRFTokenAndUpload];

}

-(void)getCSRFTokenAndUpload{
    
    NSString *url_string = @"http://127.0.0.1:5000/api/post";
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
                    [self sendPost:csrf_token];
                });
            }
        }
    }];
    [task resume];
}
-(void)sendPost:(NSString *)csrf_token{
    NSString *postContent = self.textPostContent.text;
    NSString *url_string = @"http://127.0.0.1:5000/api/post";
    NSURL *url = [NSURL URLWithString:url_string];
    NSString *boundary = [[NSUUID UUID] UUIDString];
    NSString *filename = [[NSUUID UUID] UUIDString];
    filename = [filename stringByAppendingString:@".jpeg"];
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
    NSString *contentParam = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", boundary, @"postContent", postContent, nil];
    [httpBody appendData:[contentParam dataUsingEncoding:NSUTF8StringEncoding]];
    // File(image)
    NSString *fileParam = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\nContent-Type: image/jpeg\r\n\r\n", boundary, @"postImage", filename, nil];
    [httpBody appendData:[fileParam dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *imgData = UIImageJPEGRepresentation(selectedImage, 1.0f);
    [httpBody appendData:imgData];
    [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *endSting = [NSString stringWithFormat:@"--%@--", boundary];
    [httpBody appendData:[endSting dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *upload_task = [session uploadTaskWithRequest:request fromData:httpBody completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }else{
            NSLog(@"Upload success!");
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textPostContent.text = @"";
                selectedImage = nil;
            });
        }
    }];
    [upload_task resume];
    
}


@end
