//
//  MainViewController.h
//  QuizMasterGame
//
//  Created by Jack Leon on 11/5/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import <UIKit/UIKit.h>

@import AVFoundation;

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property AVAudioPlayer *backgroundMusicPlayer;

@end
