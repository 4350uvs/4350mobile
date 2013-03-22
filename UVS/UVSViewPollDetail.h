//
//  UVSViewPollDetail.h
//  UVS
//
//  Copyright (c) COMP4350 - Group 3 - UVS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UVSViewPollDetail : UIViewController


@property (nonatomic) NSUInteger pollNum;
@property (nonatomic) NSString *pollName;
@property (strong, nonatomic) IBOutlet UITextView *pollDetailText;
@property (strong, nonatomic) IBOutlet UILabel *pollTitleLabel;


@end
