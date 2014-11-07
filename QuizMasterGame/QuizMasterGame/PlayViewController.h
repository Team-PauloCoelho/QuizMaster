//
//  PlayViewController.h
//  QuizMasterGame
//
//  Created by Jack Leon on 11/6/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameFinishViewController.h" 

@interface PlayViewController : UIViewController<UIAlertViewDelegate>
@property(weak, nonatomic) IBOutlet UILabel *question;
@property(weak, nonatomic) IBOutlet UIButton *answerA;
@property(weak, nonatomic) IBOutlet UIButton *answerB;
@property(weak, nonatomic) IBOutlet UIButton *answerC;
@property(weak, nonatomic) IBOutlet UIButton *answerD;

@property GameFinishViewController *gameFinishView;
@property int points;
@property NSArray *questions;
@property int questionNumber;
@property long currentAnswer;

- (void)getNextQuestion;
- (void)getAllQuestions;
- (BOOL)checkAnswer:(int)answer;

@end
