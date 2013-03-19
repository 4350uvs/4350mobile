//
//  UVSViewPollDetail.m
//  UVS
//
//  Created by Richard Bruneau on 2013-03-15.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import "UVSViewPollDetail.h"

@interface UVSViewPollDetail (){

NSMutableData *jsonData;
NSURLConnection *connection;
NSMutableArray *array;

}
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
    
    [self getPollByPid:self.pollNum];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//get the poll JSON object by pid
- (void)getPollByPid:(int)pidInt
{
    NSLog(@"param - getPollByPid: %d", pidInt);
    
    
    
}

//return array of choices
- (void)processPollJSONObject{
    
    
    
}

//submit a poll choice to the server
- (void)submitPollVote:(int)pidInt cid:(int)choiceID
{
    NSLog(@"param - submitPollVote: %d  %d", pidInt, choiceID);
    
    
}


@end
