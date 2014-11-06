//
//  MainViewController.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/5/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "MainViewController.h"
#import <Parse/Parse.h>
#import "GameViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
NSString *const MAIN_TOO_SHORT_USERNAME = @"Username is too short!";
NSString *const MAIN_TOO_LONG_USERNAME = @"Username is too long!";
NSString *const MAIN_TOO_SHORT_PASSWORD = @"Password is too short!";
NSString *const MAIN_TOO_LONG_PASSWORD = @"Password is too long!";
const int MAIN_MIN_LENGTH = 6;
const int MAIN_MAX_LENGTH = 20;

- (void)viewDidLoad {
  [super viewDidLoad];
    
    UIImage *imageView = [UIImage imageNamed:@"background-home-1.png"
    ];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    [backgroundImage setImage: imageView
];
    

    [backgroundImage setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.view insertSubview:backgroundImage atIndex:0];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)buttonSignInTapped:(UIButton *)sender {
  NSMutableString *stringBuilderError = [NSMutableString string];
  BOOL hasError = NO;

  if (self.username.text.length < MAIN_MIN_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", MAIN_TOO_SHORT_USERNAME];
    hasError = YES;
  }

  if (self.username.text.length > MAIN_MAX_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", MAIN_TOO_LONG_USERNAME];
    hasError = YES;
  }

  if (self.password.text.length < MAIN_MIN_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", MAIN_TOO_SHORT_PASSWORD];
    hasError = YES;
  }

  if (self.password.text.length > MAIN_MAX_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", MAIN_TOO_LONG_PASSWORD];
    hasError = YES;
  }

  if (hasError) {
    UIAlertView *validationError =
        [[UIAlertView alloc] initWithTitle:@"Validation Error!"
                                   message:stringBuilderError
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];

    [validationError show];
  } else {

    [PFUser
        logInWithUsernameInBackground:self.username.text
                             password:self.password.text
                                block:^(PFUser *user, NSError *error) {
                                    if (!error) {
                                      UIAlertView *success = [
                                          [UIAlertView alloc]
                                              initWithTitle:@"Information!"
                                                    message:@"Successful login!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];

                                      [success show];
                                      UIStoryboard *storyboard = [UIStoryboard
                                          storyboardWithName:@"Main"
                                                      bundle:nil];
                                      GameViewController *viewController =
                                          (GameViewController *)[storyboard
                                              instantiateViewControllerWithIdentifier:
                                                  @"GameViewControllerID"];
                                      [self presentViewController:viewController
                                                         animated:YES
                                                       completion:nil];
                                    } else {
                                      NSString *errorString =
                                          [error userInfo][@"error"];
                                      UIAlertView *error = [[UIAlertView alloc]
                                              initWithTitle:@"Error!"
                                                    message:errorString
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];

                                      [error show];
                                    }
                                }];
  }
}

- (IBAction)returnToMain:(UIStoryboardSegue *)segue {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
