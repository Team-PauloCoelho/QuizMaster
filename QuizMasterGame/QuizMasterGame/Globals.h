//
//  Globals.h
//  QuizMasterGame
//
//  Created by Jack Leon on 11/7/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject
extern NSString *const TOO_SHORT_USERNAME;
extern NSString *const TOO_LONG_USERNAME;
extern NSString *const TOO_SHORT_PASSWORD;
extern NSString *const TOO_LONG_PASSWORD;
extern NSString *const PASSOWRDS_DONT_MATCH;
extern NSString *const INVALID_EMAIL_FORMAT;
extern const int MIN_LENGTH;
extern const int MAX_LENGTH;
extern const int ZERO_LENGTH;

// Resources constants
extern NSString *const BACKGROUND_HOME;

// Message constants
extern NSString *const ERROR_VALIDATION_TITLE;
extern NSString *const SUCCESS_TITLE;
extern NSString *const SUCCESSFUL_REGISTRATION_MESSAGE;
extern NSString *const ERROR_TITLE;
extern NSString *const CANCEL_TITLE ;
extern NSString *const WINNER_TITLE;
extern NSString *const WINNER_MESSAGE;
extern NSString *const GAME_WON_IMAGE;
extern NSString *const GAME_OVER_TITLE;
extern NSString *const GAME_OVER_MESSAGE;
extern NSString *const GAME_OVER_IMAGE;



// Storyboard and views
extern NSString *const STORYBOARD_NAME;
extern NSString *const GAME_ID;

// Parse objects
extern NSString *const QUESTION_CORRECT_ANSWER;
extern NSString *const QUESTION_NAME;
extern NSString *const QUESTION_ANSWER_A;
extern NSString *const QUESTION_ANSWER_B;
extern NSString *const QUESTION_ANSWER_C;
extern NSString *const QUESTION_ANSWER_D;
extern NSString *const CLASS_NAME_QUESTION;

// Rotation
extern const float MATH_PI;

// Cheats
extern NSString *const CHEAT_CORRECT_ANSWER;

@end


