//
//  ConectionChecker.h
//  QuizMasterGame
//
//  Created by Jack Leon on 11/8/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface ConnectionChecker : NSObject

+ (BOOL)connected;

@end
