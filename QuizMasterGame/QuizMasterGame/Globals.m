//
//  Globals.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/7/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "Globals.h"

@implementation Globals
NSString *const TOO_SHORT_USERNAME = @"Username is too short!";
NSString *const TOO_LONG_USERNAME = @"Username is too long!";
NSString *const TOO_SHORT_PASSWORD = @"Password is too short!";
NSString *const TOO_LONG_PASSWORD = @"Password is too long!";
NSString *const PASSOWRDS_DONT_MATCH = @"Passwords don't match!";
NSString *const INVALID_EMAIL_FORMAT = @"Invalid email format!";
const int MIN_LENGTH = 6;
const int MAX_LENGTH = 20;
const int ZERO_LENGTH = 0;

// Resources constants
NSString *const BACKGROUND_HOME = @"background-home-1.png";

// Message constants
NSString *const ERROR_VALIDATION_TITLE = @"Validation Error";
NSString *const SUCCESS_TITLE = @"Information";
NSString *const SUCCESSFUL_REGISTRATION_MESSAGE = @"Successful registration!";
NSString *const ERROR_TITLE = @"Error";
NSString *const CANCEL_TITLE = @"OK";
NSString *const WINNER_TITLE = @"Congratulation";
NSString *const WINNER_MESSAGE= @"Congratulation you complete the game!";
NSString *const GAME_WON_IMAGE = @"game-won.png";
NSString *const GAME_OVER_TITLE = @"Game over!";
NSString *const GAME_OVER_MESSAGE = @"You lose!";
NSString *const GAME_OVER_IMAGE = @"game-over.png";


// Storyboard and views
NSString *const STORYBOARD_NAME = @"Main";
NSString *const GAME_ID = @"GameViewControllerID";

// Parse objects
NSString *const QUESTION_CORRECT_ANSWER = @"correctAnswer";
NSString *const QUESTION_NAME = @"name";
NSString *const QUESTION_ANSWER_A = @"answerA";
NSString *const QUESTION_ANSWER_B = @"answerB";
NSString *const QUESTION_ANSWER_C = @"answerC";
NSString *const QUESTION_ANSWER_D = @"answerD";
NSString *const CLASS_NAME_QUESTION = @"Question";

// Rotation
const float MATH_PI = 3.14159265358979323846264338327950288;


@end
