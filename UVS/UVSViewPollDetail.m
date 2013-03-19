//
//  UVSViewPollDetail.m
//  UVS
//
//  Created by Richard Bruneau on 2013-03-15.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import "UVSViewPollDetail.h"

@interface UVSViewPollDetail ()
@end

@implementation UVSViewPollDetail

@synthesize pollDetailText;
@synthesize pollNum;
@synthesize pollTitleLabel;
@synthesize pollName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    pollDetailText.text = [NSString stringWithFormat:@"%d", (int) self.pollNum];
    pollTitleLabel.text = self.pollName;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
