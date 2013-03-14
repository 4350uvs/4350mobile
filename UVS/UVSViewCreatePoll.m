//
//  UVSViewCreatePoll.m
//  UVS
//
//  Created by Richard Bruneau on 2013-03-14.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import "UVSViewCreatePoll.h"

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
        //NSLog(@"Seg pressed %d", selectedIndex);
        
        [self.pollChoice3 setEnabled:NO];
        
        [self.pollChoice4 setEnabled:NO];
        
        [self.pollChoice5 setEnabled:NO];
    }else if( selectedIndex == 1){
        //NSLog(@"Seg pressed %d", selectedIndex);
        
        [self.pollChoice3 setEnabled:YES];
        
        [self.pollChoice4 setEnabled:NO];
        
        [self.pollChoice5 setEnabled:NO];
    }else if( selectedIndex == 2){
        //NSLog(@"Seg pressed %d", selectedIndex);
        
        [self.pollChoice3 setEnabled:YES];
        
        [self.pollChoice4 setEnabled:YES];
        
        [self.pollChoice5 setEnabled:NO];
    }else if( selectedIndex == 3){
        //NSLog(@"Seg pressed %d", selectedIndex);
        
        [self.pollChoice3 setEnabled:YES];
        
        [self.pollChoice4 setEnabled:YES];
        
        [self.pollChoice5 setEnabled:YES];
    }
        
}

- (IBAction)submitPoll:(id)sender {
    
    //http://ec2-54-235-121-23.compute-1.amazonaws.com:8274/polls
    //@"http://postcatcher.in/catchers/514240ccdbb8050200000268"]
    NSString *urlStr = [NSString stringWithFormat:@"http://ec2-54-235-121-23.compute-1.amazonaws.com:8274/polls"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //title + 5 choices
    //@"[{'title': '%@', 'choice': '%@', 'choice': '%@', 'choice': '%@', 'choice': '%@', 'choice': '%@'}]"
    //@"title=%@&choice=%@&choice=%@&choice=%@&choice=%@&choice=%@"
    
    NSString *dataStr = [NSString stringWithFormat:@"title=%@&choice=%@&choice=%@&choice=%@&choice=%@&choice=%@", self.pollTitle.text, self.pollChoice1.text, self.pollChoice2.text, self.pollChoice3.text, self.pollChoice4.text, self.pollChoice5.text];
    
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //NSURLResponse *response;
    //NSError *err;
    //NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    //NSLog(@"Error(s): %@", err);
    
    
    NSLog(@"Form values: %@ %@ %@ %@ %@ %@ %@ %@", self.pollTitle.text, self.pollCreator.text, self.pollQuestion.text, self.pollChoice1.text, self.pollChoice2.text, self.pollChoice3.text, self.pollChoice4.text, self.pollChoice5.text );
    
}

@end
