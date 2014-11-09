//
//  Cheat.h
//  QuizMasterGame
//
//  Created by Jack Leon on 11/9/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cheat : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * type;


-(instancetype) initWithType:(NSString*)type
                      andDate:(NSDate*) date;

@end
