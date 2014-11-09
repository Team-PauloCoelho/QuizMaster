//
//  RegisterViewController.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/5/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>
#import "Globals.h"

@interface RegisterViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *takePhotoBtn;

@end

@implementation RegisterViewController {
    PFFile *avatar;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)signUpTapped:(UIButton *)sender {
  NSMutableString *stringBuilderError = [NSMutableString string];
  BOOL hasError = NO;

  if (self.username.text.length < MIN_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", TOO_SHORT_USERNAME];
    hasError = YES;
  }

  if (self.username.text.length > MAX_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", TOO_LONG_USERNAME];
    hasError = YES;
  }

  if (![self isValidEmail:self.email.text]) {
    [stringBuilderError appendFormat:@"%@\n", INVALID_EMAIL_FORMAT];
    hasError = YES;
  }

  if (self.password.text.length < MIN_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", TOO_SHORT_PASSWORD];
    hasError = YES;
  }

  if (self.password.text.length > MAX_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", TOO_LONG_PASSWORD];
    hasError = YES;
  }

  if (![self.password.text isEqualToString:self.confirmPassword.text]) {
    [stringBuilderError appendFormat:@"%@\n", PASSOWRDS_DONT_MATCH];
    hasError = YES;
  }

  if (hasError) {
    UIAlertView *validationError =
        [[UIAlertView alloc] initWithTitle:ERROR_VALIDATION_TITLE
                                   message:stringBuilderError
                                  delegate:nil
                         cancelButtonTitle:CANCEL_TITLE
                         otherButtonTitles:nil];

    [validationError show];

    [self.navigationController popViewControllerAnimated:YES];

  } else {

    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    user.email = self.email.text;
      
    user[@"games"] = @0;
    user[@"points"] = @0;
    user[@"image"] = avatar;
      
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
          UIAlertView *success =
              [[UIAlertView alloc] initWithTitle:SUCCESS_TITLE
                                         message:SUCCESSFUL_REGISTRATION_MESSAGE
                                        delegate:nil
                               cancelButtonTitle:CANCEL_TITLE
                               otherButtonTitles:nil];

          [success show];
          [self dismissViewControllerAnimated:YES completion:nil];
        } else {
          NSString *errorString = [error userInfo][@"error"];
          UIAlertView *error = [[UIAlertView alloc] initWithTitle:ERROR_TITLE
                                                          message:errorString
                                                         delegate:nil
                                                cancelButtonTitle:CANCEL_TITLE
                                                otherButtonTitles:nil];

          [error show];
        }
    }];
  }
}

- (BOOL)isValidEmail:(NSString *)checkString {
  BOOL stricterFilter = NO;

  NSString *stricterFilterString =
      @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
  NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
  NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
  NSPredicate *emailTest =
      [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:checkString];
}


- (IBAction)getPhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    NSData *imageData = UIImagePNGRepresentation(chosenImage);

    avatar = [PFFile fileWithName:@"image123.png" data:imageData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    self.imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
