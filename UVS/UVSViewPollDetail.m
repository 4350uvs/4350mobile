//
//  UVSViewPollDetail.m
//  UVS

//

#import "UVSViewPollDetail.h"

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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    choiceArray = [[NSMutableArray alloc] init];
    cidArray = [[NSMutableArray alloc] init];
    countArray = [[NSMutableArray alloc] init];
    
    //pollDetailText.text = [NSString stringWithFormat:@"%d", (int) self.pollNum];
    pollTitleLabel.text = self.pollName;
    
    buttonView = [[UIView alloc] initWithFrame:CGRectMake(89, 157, 600, 600)];
    
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
    
    [choiceArray removeAllObjects];
    [cidArray removeAllObjects];
    [countArray removeAllObjects];
    
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
    
    int size = [choiceArray count];
    
    for (int i = 0; i < size; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(58, 75 * i, 200, 65);
        
        NSString *title = [choiceArray objectAtIndex:i];
        
        [button setTitle:title forState:UIControlStateNormal];
        
        [button setTag:[[cidArray objectAtIndex:i] intValue]];
        
        [button addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview: button];
        
    }
    
    [self.view addSubview:buttonView];

}


- (IBAction) buttonTouchUpInside:(id)sender {
    UIButton *buttonClicked = (UIButton *)sender;
    
    buttonClicked.selected = YES;
    
    [self submitPollVote:self.pollNum cid:buttonClicked.tag];
    
    [self displayPollResults];

    NSLog(@"Pressed - %d", buttonClicked.tag);
    
}


//submit a poll choice to the server
- (void)submitPollVote:(int)pidInt cid:(int)choiceID
{
    NSLog(@"param - submitPollVote: %d  %d", pidInt, choiceID);
    
    //i.e: curl -X PUT -d "cid=94" http://ec2-54-235-121-23.compute-1.amazonaws.com:8274/polls/42/choices
    
    //parameter set to "cid=y" (or whichever choice) sent to "PUT /polls/x/choices"
    NSString *urlStr = [NSString stringWithFormat:@"http://ec2-54-235-121-23.compute-1.amazonaws.com:8274/polls/%d/choices", pidInt];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //:8274/polls/x/choices - x = pid - param is cid=y, y being the choice id
    NSString *dataStr = [NSString stringWithFormat:@"cid=%d", choiceID];
    
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
    
    [self getPollByPid:self.pollNum];
    
    [buttonView setUserInteractionEnabled:NO];
    
    resultsView = [[UIView alloc] initWithFrame:CGRectMake(89, 550, 600, 380)];
    
    int size = [countArray count];
    
        NSLog(@"SIZE: %d", size);
    
    NSNumber *arrTotal = [countArray valueForKeyPath:@"@sum.self"];
    
        NSLog(@"arrTOTAL: %@", arrTotal);
    
    int total = [arrTotal intValue];
    
    if (total > 0) {
    
        for (int i = 0; i < size; i++) {
            
            UIProgressView *progBar = [[UIProgressView alloc] init];
            
                NSLog(@"COUNT: %d", [[countArray objectAtIndex:i] intValue]);
                NSLog(@"TOTAL: %d", total);
            
            progBar.progress = ( ((double) [[countArray objectAtIndex:i] intValue]) /((double) total));
            
                NSLog(@"PROG: %f",  ( ((double) [[countArray objectAtIndex:i] intValue]) /((double) total)) );
            
            progBar.frame = CGRectMake(58, 55 * i, 400, 60);

            [resultsView addSubview:progBar];
            
        }
        
    }else{
        
        UITextView *note = [[UITextView alloc]init];
        note.text = @"There are no results to display";
        [resultsView addSubview:note];
        
    }
    
    [self.view addSubview:resultsView];
    
}


@end
