//
//  MainViewController.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/5/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "MainViewController.h"
#import "AudioController.h"
#import "GameViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>
#import "Globals.h"
#import "ConnectionChecker.h"

@interface MainViewController ()

@property(strong, nonatomic) AudioController *audioController;

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.audioController = [[AudioController alloc] init];
  [self.audioController tryPlayMusic];

  UIImage *imageView = [UIImage imageNamed:BACKGROUND_HOME];

  UIImageView *backgroundImage =
      [[UIImageView alloc] initWithFrame:self.view.frame];
  [backgroundImage setImage:imageView];

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

  if (self.username.text.length < MIN_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", TOO_SHORT_USERNAME];
    hasError = YES;
  }

  if (self.username.text.length > MAX_LENGTH) {
    [stringBuilderError appendFormat:@"%@\n", TOO_LONG_USERNAME];
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

  if (hasError) {
    UIAlertView *validationError =
        [[UIAlertView alloc] initWithTitle:ERROR_VALIDATION_TITLE
                                   message:stringBuilderError
                                  delegate:nil
                         cancelButtonTitle:CANCEL_TITLE
                         otherButtonTitles:nil];

    [validationError show];
  } else {
    if ([ConnectionChecker connected]) {

      [PFUser
          logInWithUsernameInBackground:self.username.text
                               password:self.password.text
                                  block:^(PFUser *user, NSError *error) {
                                      if (!error) {
                                        UIStoryboard *storyboard = [UIStoryboard
                                            storyboardWithName:STORYBOARD_NAME
                                                        bundle:nil];
                                        GameViewController *viewController =
                                            (GameViewController *)[storyboard
                                                instantiateViewControllerWithIdentifier:
                                                    GAME_ID];
                                        [self
                                            presentViewController:viewController
                                                         animated:YES
                                                       completion:nil];
                                      } else {
                                        NSString *errorString =
                                            [error userInfo][@"error"];
                                        UIAlertView *error =
                                            [[UIAlertView alloc]
                                                    initWithTitle:ERROR_TITLE
                                                          message:errorString
                                                         delegate:nil
                                                cancelButtonTitle:CANCEL_TITLE
                                                otherButtonTitles:nil];

                                        [error show];
                                      }
                                  }];
    } else {
        NSString *errorConnection = MISSING_CONNECTION_ERROR;
        UIAlertView *error =
        [[UIAlertView alloc]
         initWithTitle:ERROR_TITLE
         message:errorConnection
         delegate:nil
         cancelButtonTitle:CANCEL_TITLE
         otherButtonTitles:nil];
        
        [error show];
    }
  }
}

- (IBAction)returnToMain:(UIStoryboardSegue *)segue {
}

@end
