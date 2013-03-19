//
//  UVSViewCreatePoll.m
//  UVS
//
//  Created by Richard Bruneau on 2013-03-14.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import "UVSViewCreatePoll.h"

static int numSelected = 2;

@interface UVSViewCreatePoll ()

@end

@implementation UVSViewCreatePoll

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
    
    [self.pollChoice3 setEnabled:NO];
    
    [self.pollChoice4 setEnabled:NO];
    
    [self.pollChoice5 setEnabled:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) choiceSegment:(id)sender{
    NSLog(@"Segment action",nil);
    
    UISegmentedControl *segControl = sender;
    int selectedIndex = [segControl selectedSegmentIndex];
    
    //disable fields based on segment index
    if ( selectedIndex == 0){
        NSLog(@"Seg pressed %d", selectedIndex);
        
        numSelected = 2;
        
        [self.pollChoice3 setEnabled:NO];
        
        [self.pollChoice4 setEnabled:NO];
        
        [self.pollChoice5 setEnabled:NO];
        
        NSLog(@"Selected %d", numSelected);
    }else if( selectedIndex == 1){
        NSLog(@"Seg pressed %d", selectedIndex);
        
        numSelected = 3;
        
        [self.pollChoice3 setEnabled:YES];
        
        [self.pollChoice4 setEnabled:NO];
        
        [self.pollChoice5 setEnabled:NO];
        
        NSLog(@"Selected %d", numSelected);
    }else if( selectedIndex == 2){
        NSLog(@"Seg pressed %d", selectedIndex);
        
        numSelected = 4;
        
        [self.pollChoice3 setEnabled:YES];
        
        [self.pollChoice4 setEnabled:YES];
        
        [self.pollChoice5 setEnabled:NO];
        
        NSLog(@"Selected %d", numSelected);
    }else if( selectedIndex == 3){
        NSLog(@"Seg pressed %d", selectedIndex);
        
        numSelected = 5;
        
        [self.pollChoice3 setEnabled:YES];
        
        [self.pollChoice4 setEnabled:YES];
        
        [self.pollChoice5 setEnabled:YES];
        
        NSLog(@"Selected %d", numSelected);
    }
        
}

- (IBAction)submitPoll:(id)sender {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://ec2-54-235-121-23.compute-1.amazonaws.com:8274/polls"];
    //NSString *urlStr = [NSString stringWithFormat:@"https://posttestserver.com/post.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //title + choices as parameters to api - :8274/polls
    NSString *dataStr = [self getChoices];
    
    //all other HTTP values set automatically
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[dataStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    //response will contain poll id, otherwise error
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSLog(@"Error(s): %@", err);
    
    
    
    NSLog(@"RESPONSE: %@", responseData);
    
    
    NSLog(@"Form values: %@ %@ %@ %@ %@ %@ %@ %@", self.pollTitle.text, self.pollCreator.text, self.pollQuestion.text, self.pollChoice1.text, self.pollChoice2.text, self.pollChoice3.text, self.pollChoice4.text, self.pollChoice5.text );
    
}

-(NSString*)getChoices{
    
    //creates output for 2
    NSString *retStr = [NSString stringWithFormat:@"title=%@&choice=%@&choice=%@", self.pollTitle.text, self.pollChoice1.text, self.pollChoice2.text];
    
    if( numSelected >= 3){
        retStr = [retStr stringByAppendingString:[NSString stringWithFormat:@"&choice=%@", self.pollChoice3.text]];
    }
    
    if ( numSelected >= 4){
        retStr = [retStr stringByAppendingString:[NSString stringWithFormat:@"&choice=%@", self.pollChoice4.text]];
    }
    
    if ( numSelected >= 5){
        retStr = [retStr stringByAppendingString:[NSString stringWithFormat:@"&choice=%@", self.pollChoice5.text]];
    }
    
    return retStr;
}

@end
