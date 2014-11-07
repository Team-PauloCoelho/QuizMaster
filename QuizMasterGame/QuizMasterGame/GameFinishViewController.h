//
//  GameFinishViewController.h
//  QuizMasterGame
//
//  Created by Jack Leon on 11/7/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameFinishViewController : UIViewController

@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(strong, nonatomic) UIViewController *parentViewController;
@property BOOL isGameOver;

+ (instancetype)initWithParentView:(UIViewController *)parentViewController
                           andType:(BOOL)isGameOver;
- (void)showOnScreen;
- (void)hideFromScreen;

@end
