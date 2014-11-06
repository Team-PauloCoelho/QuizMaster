//
//  GameViewController.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/5/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIImage *imageView = [UIImage imageNamed:@"background-home-1.png"];

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
