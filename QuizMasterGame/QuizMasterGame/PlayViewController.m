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
#import "CoreDataHelper.h"
#import "Cheat.h"

@interface PlayViewController ()
@property(nonatomic, strong) CoreDataHelper *cdHelper;
@end

@implementation PlayViewController

- (void)viewDidLoad {
  _cdHelper = [[CoreDataHelper alloc] init];
  [_cdHelper setupCoreData];

  self.gameFinishView =
      [GameFinishViewController initWithParentView:self andType:YES];

  self.points = 0;
  self.questionNumber = 0;
  self.index = 0;
  self.pointsLabel.text =
      [NSString stringWithFormat:@"Points: %d", self.points];
  [self getAllQuestions];

  [self deleteCheats];
  [self checkAllBonusses];

  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma marks - Questions
- (void)checkAllBonusses {
  if ([self checkIfCheatUsedToday:CHEAT_RESET_GAME_LABEL]) {
    self.resetGameIcon.backgroundColor = [UIColor redColor];
  }

  if ([self checkIfCheatUsedToday:CHEAT_CORRECT_ANSWER_LABEL]) {
    self.correctAnswerIcon.backgroundColor = [UIColor redColor];
  }

  if ([self checkIfCheatUsedToday:CHEAT_CHANGE_QUESTION_LABEL]) {
    self.changeQuestionIcon.backgroundColor = [UIColor redColor];
  }

  if ([self checkIfCheatUsedToday:CHEAT_NEXT_QUESTION_LABEL]) {
    self.nextQuestionIcon.backgroundColor = [UIColor redColor];
  }
}

- (void)getNextQuestion {
  if (self.questionNumber < 10) {
    if (self.index == self.questions.count) {
      self.index = 0;
    }

    PFObject *currentQuestionObject = self.questions[self.index];
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
    ++self.index;

    self.questionLabel.text =
        [NSString stringWithFormat:@"Question #%d", self.questionNumber];
  } else {
    [self showEndGameScreen];
  }
}

- (void)getAllQuestions {
  PFQuery *query = [PFQuery queryWithClassName:CLASS_NAME_QUESTION];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      if (!error) {

        self.questions = objects;
        self.index = arc4random() % self.questions.count;
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

#pragma marks - Answer buttons tapped
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
    self.pointsLabel.text =
        [NSString stringWithFormat:@"Points: %d", self.points];
    [self getNextQuestion];
  } else {
    [self showGameOverScreen];
  }
}

- (BOOL)checkAnswer:(int)answer {
  if (self.currentAnswer == answer) {
    return YES;
  } else {
    return NO;
  }
}

- (void)showEndGameScreen {
  [self saveUserPoints];
  self.gameFinishView.isGameOver = NO;
  [self.gameFinishView showOnScreen];
  UIAlertView *winnerMessage = [[UIAlertView alloc] initWithTitle:WINNER_TITLE
                                                          message:WINNER_MESSAGE
                                                         delegate:self
                                                cancelButtonTitle:CANCEL_TITLE
                                                otherButtonTitles:nil];

  [winnerMessage show];
}

- (void)showGameOverScreen {
  [self saveUserPoints];
  self.gameFinishView.isGameOver = YES;
  [self.gameFinishView showOnScreen];
  UIAlertView *error = [[UIAlertView alloc] initWithTitle:GAME_OVER_TITLE
                                                  message:GAME_OVER_MESSAGE
                                                 delegate:self
                                        cancelButtonTitle:CANCEL_TITLE
                                        otherButtonTitles:nil];

  [error show];
}

- (void)saveUserPoints {
  PFUser *currentUser = [PFUser currentUser];
  if (currentUser) {
    long userNewPoints = [[currentUser objectForKey:@"points"] integerValue];
    userNewPoints += self.points;
    long userNewGames = [[currentUser objectForKey:@"games"] integerValue];

    userNewGames++;

    currentUser[@"points"] = [NSNumber numberWithLong:userNewPoints];
    currentUser[@"games"] = [NSNumber numberWithLong:userNewGames];
    [currentUser saveInBackground];
  } else {
    UIAlertView *cheat = [[UIAlertView alloc] initWithTitle:ERROR_TITLE
                                                    message:@"Unknown user"
                                                   delegate:nil
                                          cancelButtonTitle:CANCEL_TITLE
                                          otherButtonTitles:nil];
    [cheat show];
  }
}

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  [self.gameFinishView hideFromScreen];

  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma marks - Gestures
- (IBAction)longPressGesture:(UILongPressGestureRecognizer *)sender {
  if (sender.state == UIGestureRecognizerStateEnded) {
    if (![self checkIfCheatUsedToday:CHEAT_CORRECT_ANSWER_LABEL]) {

      --self.points;
      self.pointsLabel.text =
          [NSString stringWithFormat:@"Points: %d", self.points];

      NSString *answer;

      if (self.currentAnswer == 1) {
        answer = self.answerA.titleLabel.text;
      } else if (self.currentAnswer == 2) {
        answer = self.answerB.titleLabel.text;
      } else if (self.currentAnswer == 3) {
        answer = self.answerC.titleLabel.text;
      } else if (self.currentAnswer == 4) {
        answer = self.answerD.titleLabel.text;
      }

      UIAlertView *cheat =
          [[UIAlertView alloc] initWithTitle:CHEAT_CORRECT_ANSWER
                                     message:answer
                                    delegate:nil
                           cancelButtonTitle:CANCEL_TITLE
                           otherButtonTitles:nil];

      [cheat show];
      [self useCheat:CHEAT_CORRECT_ANSWER_LABEL];
      [self checkAllBonusses];
    } else {
      [self showAlertWithTitle:@"Persmision denied"
                    andMessage:@"You can't use this cheat until tomorrow!"];
    }
  }
}

- (IBAction)rotationGesture:(UIRotationGestureRecognizer *)sender {
  if (sender.state == UIGestureRecognizerStateEnded) {
    if (![self checkIfCheatUsedToday:CHEAT_NEXT_QUESTION_LABEL]) {

      --self.points;
      self.pointsLabel.text =
          [NSString stringWithFormat:@"Points: %d", self.points];
      [self getNextQuestion];
      [self useCheat:CHEAT_NEXT_QUESTION_LABEL];
      [self checkAllBonusses];
    } else {
      [self showAlertWithTitle:@"Persmision denied"
                    andMessage:@"You can't use this cheat until tomorrow!"];
    }
  }
}

- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
  if (![self checkIfCheatUsedToday:CHEAT_CHANGE_QUESTION_LABEL]) {
    --self.questionNumber;
    [self getNextQuestion];
    [self useCheat:CHEAT_CHANGE_QUESTION_LABEL];
    [self checkAllBonusses];
  } else {
    [self showAlertWithTitle:@"Persmision denied"
                  andMessage:@"You can't use this cheat until tomorrow!"];
  }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
  if (motion == UIEventSubtypeMotionShake) {
    if (![self checkIfCheatUsedToday:CHEAT_RESET_GAME_LABEL]) {

      self.questionNumber = 0;
      self.questionLabel.text =
          [NSString stringWithFormat:@"%d", self.questionNumber];
      self.points = 0;
      self.pointsLabel.text =
          [NSString stringWithFormat:@"Points: %d", self.points];

      [self getNextQuestion];
      [self showAlertWithTitle:@"RESET GAME"
                    andMessage:@"The game starts from the beginning. All "
                    @"points and question are reset!"];
      [self useCheat:CHEAT_RESET_GAME_LABEL];
      [self checkAllBonusses];
    } else {
      [self showAlertWithTitle:@"Persmision denied"
                    andMessage:@"You can't use this cheat until tomorrow!"];
    }
  }
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:CANCEL_TITLE
                                            otherButtonTitles:nil];
  [alertView show];
}

#pragma marks - Cheat
- (void)useCheat:(NSString *)type {
  Cheat *cheat =
      [NSEntityDescription insertNewObjectForEntityForName:@"Cheat"
                                    inManagedObjectContext:_cdHelper.context];
  cheat.type = type;
  cheat.date = [NSDate date];

  [_cdHelper.context insertObject:cheat];

  [self.cdHelper saveContext];
}

- (BOOL)checkIfCheatUsedToday:(NSString *)type {
  BOOL isUsedToday = NO;

  NSFetchRequest *request =
      [NSFetchRequest fetchRequestWithEntityName:@"Cheat"];
  [request setPredicate:[NSPredicate predicateWithFormat:@"type == %@", type]];

  NSArray *fetchedObjects =
      [_cdHelper.context executeFetchRequest:request error:nil];

  if (fetchedObjects.count != 0) {
    isUsedToday = YES;
  }

  return isUsedToday;
}

- (void)deleteCheats {
  NSFetchRequest *allCheats = [[NSFetchRequest alloc] init];
  [allCheats setEntity:[NSEntityDescription entityForName:@"Cheat"
                                   inManagedObjectContext:_cdHelper.context]];
  [allCheats setIncludesPropertyValues:NO];
  NSError *error = nil;
  NSArray *cheats =
      [_cdHelper.context executeFetchRequest:allCheats error:&error];

  for (NSManagedObject *cheat in cheats) {
    [_cdHelper.context deleteObject:cheat];
  }
}

@end
