//
//  TotalGamesViewController.h
//  QuizMasterGame
//
//  Created by Jack Leon on 11/6/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TotalGamesViewController : UIViewController<UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableViewGames;

@property NSArray *usersDataGames;

@end
