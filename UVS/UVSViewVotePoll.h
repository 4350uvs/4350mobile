//
//  UVSViewVotePoll.h
//  UVS
//
//  Created by Richard Bruneau on 2013-03-13.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UVSViewVotePoll : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITableView *pollTable;


@end