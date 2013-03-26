//
//  UVSViewVotePoll.h
//  UVS
//
//  Copyright (c) COMP4350 - Group 3 - UVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UVSViewVotePoll : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *pollTable;

-(void)getListOfPolls;

@end