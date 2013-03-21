//
//  UVSViewPollDetail.h
//  UVS
//

#import <UIKit/UIKit.h>

@interface UVSViewPollDetail : UIViewController


@property (nonatomic) NSUInteger pollNum;
@property (nonatomic) NSString *pollName;
@property (strong, nonatomic) IBOutlet UITextView *pollDetailText;
@property (strong, nonatomic) IBOutlet UILabel *pollTitleLabel;


@end
