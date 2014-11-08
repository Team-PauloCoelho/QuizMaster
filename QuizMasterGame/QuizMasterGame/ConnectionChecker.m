//
//  ConectionChecker.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/8/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "ConnectionChecker.h"

@implementation ConnectionChecker

+ (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
