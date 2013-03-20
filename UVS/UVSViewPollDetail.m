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
    
NSMutableArray *choiceArray;
NSMutableArray *cidArray;
NSMutableArray *countArray;

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
    
    [self generateVoteButtons];
    
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
    
    NSString *urlStr = [NSString stringWithFormat:@"http://ec2-54-235-121-23.compute-1.amazonaws.com:8274/polls/%d", self.pollNum];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSError *err;
    NSURLResponse *response;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSLog(@"Response: %@", responseData);
    
    jsonData = [[NSMutableData alloc]init];
    [jsonData setLength:0];
    [jsonData appendData:responseData];
    
    NSError *jsonErr;
    
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonErr];
    
    NSDictionary *poll = [allDataDictionary objectForKey:@"poll"];
    
    NSArray *choices = [poll objectForKey:@"choices"];
    
    for (NSDictionary *dict in choices) {
        NSString *choiceTitle = [dict objectForKey:@"content"];
        NSInteger cid = [[dict objectForKey:@"id"] intValue];
        NSInteger chosenTimes = [[dict objectForKey:@"chosenTimes"] intValue];
        
        [choiceArray addObject:choiceTitle];
        [cidArray addObject:[NSNumber numberWithInteger:cid]];
        [countArray addObject:[NSNumber numberWithInteger:chosenTimes]];

    }
    
}

//return array of choices
- (void)generateVoteButtons{
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(89, 157, 600, 600)];
    
    int size = [choiceArray count];
    
    NSLog(@"count: %d", size);
    
    for (int i = 0; i < 5; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(58, 75 * i, 200, 65);
        
        NSString *title = [choiceArray objectAtIndex:i];
        
        [button setTitle:title forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview: button];
        
    }
    
    [self.view addSubview:buttonView];

}


- (IBAction) buttonTouchUpInside:(id)sender {
    UIButton *buttonClicked = (UIButton *)sender;
    
    //call submitPollVote
    //get tag for button -send as choiceID
    //send pidInt
    
    NSLog(@"Pressed");
    
}


//submit a poll choice to the server
- (void)submitPollVote:(int)pidInt cid:(int)choiceID
{
    NSLog(@"param - submitPollVote: %d  %d", pidInt, choiceID);
    
    
    
}


@end
