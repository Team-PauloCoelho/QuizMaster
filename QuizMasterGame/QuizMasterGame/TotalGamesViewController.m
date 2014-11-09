//
//  TotalGamesViewController.m
//  QuizMasterGame
//
//  Created by Jack Leon on 11/6/14.
//  Copyright (c) 2014 PauloCoelho. All rights reserved.
//

#import "TotalGamesViewController.h"
#import <Parse/Parse.h>
#import "UIImageView+WebCache.h"
#import "CustomTableViewCell.h"

@interface TotalGamesViewController ()

@end

@implementation TotalGamesViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.usersDataGames = [NSArray array];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    self.usersDataGames = [NSArray array];
  }

  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    self.usersDataGames = [NSArray array];
  }

  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(tappedRightButton:)];
  [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
  [self.view addGestureRecognizer:swipeLeft];

  UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(tappedLeftButton:)];
  [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
  [self.view addGestureRecognizer:swipeRight];

    [self.tableViewGames setDataSource:self];
    
  [self getData];
}

- (IBAction)tappedRightButton:(id)sender {
  NSUInteger selectedIndex = [self.tabBarController selectedIndex];

  [self.tabBarController setSelectedIndex:selectedIndex + 1];
}

- (IBAction)tappedLeftButton:(id)sender {
  NSUInteger selectedIndex = [self.tabBarController selectedIndex];

  [self.tabBarController setSelectedIndex:selectedIndex - 1];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)getData {
  __weak id weakSelf = self;
  PFQuery *query = [PFUser query];
  [query orderByDescending:@"games"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
      [weakSelf setUsersDataGames:[NSMutableArray arrayWithArray:objects]];
      [[weakSelf tableViewGames] reloadData];
  }];
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [self.usersDataGames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"CellGames";

    CustomTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:cellIdentifier];
    }
    
    PFUser *userData = (PFUser *)[self.usersDataGames objectAtIndex:indexPath.row];
    
    // Image
    PFFile *imageFile = [userData objectForKey:@"image"];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageFile.url]
                      placeholderImage:[UIImage imageNamed:@"long.png"]];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // Label
    NSMutableString *cellContent = [NSMutableString string];
    
    NSString *points = [NSString stringWithFormat:@"%@ %@", [userData objectForKey:@"games"], @"games"];
    
    [cellContent appendFormat:@"%ld. %@", (long)indexPath.row + 1, userData.username];
    
    
    cell.textLabel.text = cellContent;
    cell.detailTextLabel.text = points;
  return cell;
}

@end
