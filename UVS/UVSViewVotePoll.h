//
//  UVSViewVotePoll.h
//  UVS
//

#import <UIKit/UIKit.h>

@interface UVSViewVotePoll : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITableView *pollTable;


@end