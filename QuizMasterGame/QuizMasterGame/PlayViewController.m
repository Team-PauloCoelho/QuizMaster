//
//  PlayViewController.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/6/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "PlayViewController.h"
#import <Parse/Parse.h>
#import "Globals.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.points = 0;
  self.questionNumber = 0;
  [self getAllQuestions];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)getNextQuestion {
  if (self.questionNumber < 10) {
    PFObject *currentQuestionObject = self.questions[self.questionNumber];
    self.currentAnswer = [[currentQuestionObject
        objectForKey:QUESTION_CORRECT_ANSWER] integerValue];

    self.question.text = [currentQuestionObject objectForKey:QUESTION_NAME];
    [self.answerA
        setTitle:[currentQuestionObject objectForKey:QUESTION_ANSWER_A]
        forState:UIControlStateNormal];
    [self.answerB
        setTitle:[currentQuestionObject objectForKey:QUESTION_ANSWER_B]
        forState:UIControlStateNormal];
    [self.answerC
        setTitle:[currentQuestionObject objectForKey:QUESTION_ANSWER_C]
        forState:UIControlStateNormal];
    [self.answerD
        setTitle:[currentQuestionObject objectForKey:QUESTION_ANSWER_D]
        forState:UIControlStateNormal];

    ++self.questionNumber;
  } else {
    UIAlertView *winnerMessage = [[UIAlertView alloc]
            initWithTitle: WINNER_TITLE
                  message: WINNER_MESSAGE
                 delegate:nil
        cancelButtonTitle:CANCEL_TITLE
        otherButtonTitles:nil];

    [winnerMessage show];
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

- (void)getAllQuestions {
  PFQuery *query = [PFQuery queryWithClassName: CLASS_NAME_QUESTION];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      if (!error) {

        self.questions = objects;

        [self getNextQuestion];
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

- (IBAction)answerATouched:(UIButton *)sender {
  [self handleAnswer:1];
}

- (IBAction)answerBTouched:(UIButton *)sender {
  [self handleAnswer:2];
}

- (IBAction)answerCTouched:(UIButton *)sender {
  [self handleAnswer:3];
}

- (IBAction)answerDTouched:(UIButton *)sender {
  [self handleAnswer:4];
}

- (void)handleAnswer:(int)answer {
  if ([self checkAnswer:answer]) {
    ++self.points;
    [self getNextQuestion];
  } else {
    UIAlertView *error = [[UIAlertView alloc] initWithTitle: GAME_OVER_TITLE
                                                    message: GAME_OVER_MESSAGE
                                                   delegate:nil
                                          cancelButtonTitle: CANCEL_TITLE
                                          otherButtonTitles:nil];

    [error show];
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

- (BOOL)checkAnswer:(int)answer {
  if (self.currentAnswer == answer) {
    return YES;
  } else {
    return NO;
  }
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
