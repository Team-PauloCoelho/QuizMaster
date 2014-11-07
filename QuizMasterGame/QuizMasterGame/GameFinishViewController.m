//
//  GameFinishViewController.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/7/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "GameFinishViewController.h"
#import "Globals.h"

@implementation GameFinishViewController

+ (instancetype)initWithParentView:(UIViewController *)parentViewController
                           andType:(BOOL)isGameOver {
  GameFinishViewController *instance = [[GameFinishViewController alloc] init];
  instance.parentViewController = parentViewController;

  instance.isGameOver = isGameOver;

  return instance;
}

- (void)viewDidLoad {
  UIImage *image;
  if (self.isGameOver) {
    image = [UIImage imageNamed:GAME_OVER_IMAGE];
  } else {
    image = [UIImage imageNamed:GAME_WON_IMAGE];
  }

  [self.imageView setImage:image];

  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  [self runSpinAnimationOnView:self.imageView duration:1 angle:360 repeat:10];
}

- (void)runSpinAnimationOnView:(UIView *)view
                      duration:(CGFloat)duration
                         angle:(CGFloat)angle
                        repeat:(float)repeat;

{
  CABasicAnimation *rotationAnimation;

  rotationAnimation =
      [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];

  rotationAnimation.toValue = [NSNumber numberWithFloat:MATH_PI / 180 * angle];

  rotationAnimation.duration = duration;

  rotationAnimation.speed = 0.3;

  rotationAnimation.autoreverses = YES;
  rotationAnimation.cumulative = YES;

  rotationAnimation.repeatCount = repeat;

  [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)showOnScreen {
  if (self.parentViewController != nil) {
    [UIView transitionWithView:self.parentViewController.view
                      duration:0.5
                       options:UIViewAnimationOptionShowHideTransitionViews
                    animations:^{
                        [self.parentViewController.view addSubview:self.view];
                        [self.parentViewController addChildViewController:self];
                    }
                    completion:nil];
  }
}

- (void)hideFromScreen {
  if (self.parentViewController != nil) {
    [NSThread sleepForTimeInterval:.5];
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
  }
}

@end
