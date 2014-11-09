//
//  Cheat.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/9/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "Cheat.h"


@implementation Cheat

@dynamic date;
@dynamic type;

-(instancetype)initWithType:(NSString *)type andDate:(NSDate *)date {
    self = [super init];
    if (self) {
        self.type = type;
        self.date = date;
        
    }
    
    return self;
}

@end
