//
//  RegisterViewController.h
//  QuizMasterGame
//
//  Created by Jack Leon on 11/5/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

- (BOOL)isValidEmail:(NSString *)checkString;

@end
