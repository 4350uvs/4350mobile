//
//  UVSViewCreatePoll.m
//  UVS
//
//  Copyright (c) COMP4350 - Group 3 - UVS. All rights reserved.
//

#import "UVSViewCreatePoll.h"
#import "defines.h"

//Supposed to be the default for UISegmentControl
//but I don't trust it... therefore, set here
static int numSelected = 2;

@interface UVSViewCreatePoll ()

@property NSMutableArray *pollChoices;

- (void)disableChoiceFieldsBasedOnUserChoice:(int)numSelected;

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
    
    self.pollChoices = [[NSMutableArray alloc]initWithObjects: self.pollChoice1, self.pollChoice2, self.pollChoice3, self.pollChoice4, self.pollChoice5, nil];
    
    [self disableChoiceFieldsBasedOnUserChoice:numSelected];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction) choiceSegment:(id)sender{
    
    NSLog(@"Segment action",nil);
    
    UISegmentedControl *segControl = sender;
    int selectedIndex = [segControl selectedSegmentIndex];
    
    //disable fields based on segment index
    NSLog(@"Seg pressed %d", selectedIndex);
    numSelected = selectedIndex + 2;
    [self disableChoiceFieldsBasedOnUserChoice:numSelected];
    NSLog(@"Selected %d", numSelected);
}

- (void)disableChoiceFieldsBasedOnUserChoice:(int)numSelected {
    
    for (int i = 0; i < [self.pollChoices count]; i++) {
        
        UITextField *field = [self.pollChoices objectAtIndex:i];
        
        if (i < numSelected) {
            [field setEnabled:YES];
        }
        else {
            [field setEnabled:NO];
        }
    }
}

- (IBAction)submitPoll:(id)sender {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/polls", ServerURL];
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
    
    
    if (err == nil){
        
        self.msgBox.text = @"Poll creation successful.";
        
    }else{
        
        self.msgBox.text = @"Error. No one will ever see your poll now...";
        
    }
    
    
    //Error and test output
    NSLog(@"Error(s): %@", err);
    NSLog(@"RESPONSE: %@", responseData);
    NSLog(@"Form values: %@ %@ %@ %@ %@ %@ %@ %@", self.pollTitle.text, self.pollCreator.text, self.pollQuestion.text, self.pollChoice1.text, self.pollChoice2.text, self.pollChoice3.text, self.pollChoice4.text, self.pollChoice5.text );
    
}

- (NSString*)getChoices{
    
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