//
//  UVSViewPollDetail.h
//  UVS
//
//  Created by Richard Bruneau on 2013-03-15.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UVSViewPollDetail : UIViewController


@property (nonatomic) NSUInteger pollNum;
@property (nonatomic) NSString *pollName;
@property (strong, nonatomic) IBOutlet UITextView *pollDetailText;
@property (strong, nonatomic) IBOutlet UILabel *pollTitleLabel;


@end
