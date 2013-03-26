//
//  UVSViewCreatePoll.m
//  UVS
//
//  Copyright (c) COMP4350 - Group 3 - UVS. All rights reserved.
//

#import "UVSViewCreatePoll.h"
#import "defines.h"
#import "connectWithAppServer.h"


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


//Selects number of choices that the poll will have
//will disable (some) lower UITextFields if number <5 selected
-(IBAction) choiceSegment:(id)sender{
    
    UISegmentedControl *segControl = sender;
    int selectedIndex = [segControl selectedSegmentIndex];
    
    //disable fields based on segment index

    numSelected = selectedIndex + 2;
    [self disableChoiceFieldsBasedOnUserChoice:numSelected];

}


//disables the lower (5-numSelected) choice fields based on numSelected send from choiceSegment
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


//on clicking the "Submit" button the poll is submitted the server
//a 201 CREATED will indicate that creation was successful
- (IBAction)submitPoll:(id)sender {
    
    connectWithAppServer *connectToAPI = [connectWithAppServer alloc];
    
    NSMutableArray *responseArray = [connectToAPI connectWithAppServerAtURL:[NSString stringWithFormat:@"/polls"]
                                                                paramToSend:[NSString stringWithFormat:@"%@", [self getChoicesAsString]]
                                                                methodToUse:@"POST"];
    
    
    NSURLResponse *response = [responseArray objectAtIndex:1];
    
    //check that response is good (201 CREATED)
    if ( [(NSHTTPURLResponse *)response statusCode] == 201 ){
        
        self.msgBox.text = @"Poll creation successful.";
        
    }else{
        
       self.msgBox.text = @"Error. No one will ever see your poll now...";
        
    }
    
}


//aggregates all choices in the choice fields and returns it as a string
- (NSString*)getChoicesAsString{
    
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