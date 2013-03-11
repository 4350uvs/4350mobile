//
//  UVSViewVotePoll.m
//  UVS
//
//  Created by Richard Bruneau on 2013-03-11.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import "UVSViewVotePoll.h"

@interface UVSViewVotePoll ()

@end

@implementation UVSViewVotePoll

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
	
    self.jsonURL = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://ec2-54-235-205-104.compute-1.amazonaws.com:8274/polls/2"] encoding:NSUTF8StringEncoding error:nil];
    
    self.testBox.text = self.jsonURL;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
