//
//  UVSViewPollDetail.m
//  UVS
//
//  Copyright (c) COMP4350 - Group 3 - UVS. All rights reserved.
//

#import "UVSViewPollDetail.h"
#import "defines.h"

@interface UVSViewPollDetail (){

NSMutableData *jsonData;
    
NSMutableArray *choiceArray;
NSMutableArray *cidArray;
NSMutableArray *countArray;
    
UIView *buttonView;
UIView *resultsView;

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
        //Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //initialize arrays
    choiceArray = [[NSMutableArray alloc] init];
    cidArray = [[NSMutableArray alloc] init];
    countArray = [[NSMutableArray alloc] init];
    
    //set the poll name as sent from the navigation controller via the segue
    pollTitleLabel.text = self.pollName;
    
    //instantiate the UIView for the choice buttons buttonView will be
    //added into the main view once generateVoteButtons is called.
    buttonView = [[UIView alloc] initWithFrame:CGRectMake(89, 157, 600, 600)];
    
    //retrieve the JSON object for the poll, by pid
    [self getPollByPid:self.pollNum];
    
    //once the JSON object is loaded, create the buttons
    [self generateVoteButtons];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//get the poll JSON object by pid
- (void)getPollByPid:(int)pidInt
{
    
    //ensure the all arrays are empty, to prevent duplication
    [choiceArray removeAllObjects];
    [cidArray removeAllObjects];
    [countArray removeAllObjects];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/polls/%d", ServerURL, self.pollNum];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *err;
    NSURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    //instantiate and clear out jsonData
    jsonData = [[NSMutableData alloc]init];
    [jsonData setLength:0];
    [jsonData appendData:responseData];
    
    NSError *jsonErr;
    
    //create NSDictionary with JSON object, then find the array of choices.
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonErr];
    NSDictionary *poll = [allDataDictionary objectForKey:@"poll"];
    NSArray *choices = [poll objectForKey:@"choices"];
    
    //for each choice, add each of the three fields to the appropriate array
    //(choice text, choice id, and number of votes for the choice)
    for (NSDictionary *dict in choices) {

        [choiceArray addObject:[dict objectForKey:@"content"]];
        [cidArray addObject:[dict objectForKey:@"id"]];
        [countArray addObject:[dict objectForKey:@"chosenTimes"]];

    }
    
}


//generates the buttons for each of the choices (created in getPollByPid),
//then displays the view the buttons are created in.
- (void)generateVoteButtons{
    
    int size = [choiceArray count];
    
    for (int i = 0; i < size; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(58, 75 * i, 200, 65);
        
        //set button's title to choice text in choiceArray created in getPollByPid
        NSString *title = [choiceArray objectAtIndex:i];
        [button setTitle:title forState:UIControlStateNormal];
        
        //set button's tag to the cid for that choice
        [button setTag:[[cidArray objectAtIndex:i] intValue]];
        
        //add the event control method to the button
        [button addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        //add button to the view buttonView
        [buttonView addSubview: button];
        
    }
    
    //once all buttons with choices and cids are loaded, display the buttonView inside of view
    [self.view addSubview:buttonView];

}


//receives the button click event from any of the choice buttons
//a button click is registered as a vote
- (IBAction) buttonTouchUpInside:(id)sender {
    UIButton *buttonClicked = (UIButton *)sender;
    
    buttonClicked.selected = YES;
    
    //sends the pid for the poll being voted on, plus the cid which is stored in the button's tag
    [self submitPollVote:self.pollNum cid:buttonClicked.tag];
    
    //once the vote is submitted, display the results
    [self displayPollResults];
    
}


//submit a poll choice to the server
//parameter set to "cid=choiceID" (as an integer identifier for a choice)
//sent to "PUT /polls/x/choices", where x is the pid
- (void)submitPollVote:(int)pidInt cid:(int)choiceID
{

    //build submission URL
    NSString *urlStr = [NSString stringWithFormat:@"%@/polls/%d/choices", ServerURL, pidInt];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //set the parameter
    NSString *dataStr = [NSString stringWithFormat:@"cid=%d", choiceID];
    
    //set HTTP headers in the request
    //all other HTTP values set automatically
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[dataStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    //response 
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    
    if (err == nil){
        
        pollDetailText.text = @"Vote submission successful.";
        
    }else{
        
        pollDetailText.text = @"Error. You have been nullified in the democratic process...";
        
    }
    
    
    //Error and test output
    NSLog(@"Error(s): %@", err);
    NSLog(@"RESPONSE: %@", responseData);
    
}


//display results using progress bars
- (void)displayPollResults{
    
    //retrieves JSON data for poll
    [self getPollByPid:self.pollNum];
    
    //disables the previously-created choice buttons
    [buttonView setUserInteractionEnabled:NO];
    
    //instantiaties the resultsView to add the progess bars to
    //
    resultsView = [[UIView alloc] initWithFrame:CGRectMake(89, 550, 600, 380)];
    
    int size = [countArray count];
    
    //gets the total number of votes for a particular poll
    NSNumber *arrTotal = [countArray valueForKeyPath:@"@sum.self"];
    
    int total = [arrTotal intValue];
    
    //if there aren't any votes, there are no results to display, so skip the for loop
    if (total > 0) {
    
        for (int i = 0; i < size; i++) {
            
            UIProgressView *progBar = [[UIProgressView alloc] init];
            
            //set progress to percentage of votes for choice i in choiceArray, whose counts are in countArray
            progBar.progress = ( ((double) [[countArray objectAtIndex:i] intValue]) /((double) total));
            
            progBar.frame = CGRectMake(58, 65 * i, 400, 70);
            
            //adds the progress bar to resultsView
            [resultsView addSubview:progBar];
            
        }
        
    }else{
        
        //if there is an error and there are no results to display
        //display a note instead.
        UITextView *note = [[UITextView alloc]init];
        note.text = @"Error. There are no results to display.";
        [resultsView addSubview:note];
        
    }
    
    //add resultsView to view
    [self.view addSubview:resultsView];
    
}


@end
