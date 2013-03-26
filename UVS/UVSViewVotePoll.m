//
//  UVSViewVotePoll.m
//  UVS
//
//  Copyright (c) COMP4350 - Group 3 - UVS. All rights reserved.
//

#import "UVSViewVotePoll.h"
#import "UVSViewPollDetail.h"
#import "defines.h"
#import "connectWithAppServer.h"

@interface UVSViewVotePoll (){
    
    NSMutableData *jsonData;
    NSURLConnection *connection;
    NSMutableArray *array;
    NSMutableArray *pollIDArr;
    
}
@end

@implementation UVSViewVotePoll

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    [[self pollTable] setDelegate:self];
    [[self pollTable] setDataSource:self];
    array = [[NSMutableArray alloc] init];
    pollIDArr = [[NSMutableArray alloc] init];
    
    [self getListOfPolls];
    
}


//calls server and gets a JSON object with all polls
-(void)getListOfPolls{
    
    [array removeAllObjects];

    connectWithAppServer *connectToAPI = [connectWithAppServer alloc];

    NSMutableArray *responseArray = [connectToAPI connectWithAppServerAtURL:[NSString stringWithFormat:@"/polls"]
                                                                paramToSend:[NSString stringWithFormat:@""]
                                                                methodToUse:@"GET"];
    
    
    NSData *responseData = [responseArray objectAtIndex:0];
         
    jsonData = [[NSMutableData alloc] init];
    [jsonData setLength:0];
    [jsonData appendData:responseData];

         
    NSError *jsonErr;
    
    //create dictionary from JSON serializaton
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonErr];
    
    //use key "polls" to get the polls object
    NSArray *polls = [allDataDictionary objectForKey:@"polls"];

    
    //iterate through dictionary and add titles to array
    //and add pids to pollIDArr - pids are forwarded by the segue
    //to the ViewPollDetail view controller
    for (NSDictionary *dict in polls) {
        NSString *pollTitle = [dict objectForKey:@"title"];
        NSInteger pollID = [[dict objectForKey:@"id"] intValue];

        [array addObject:pollTitle];
        [pollIDArr addObject: [NSNumber numberWithInteger:pollID]];
    }
     
    [[self pollTable] reloadData];
     
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PollCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//sends pid to ViewPollDetail view in order for the view controller to load data for that pid
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PollDetailSegue"])
    {
        NSIndexPath *index = [self.pollTable indexPathForSelectedRow];
        UVSViewPollDetail *pollDetailController = segue.destinationViewController;
        NSUInteger currRow = index.row;

        pollDetailController.pollNum = [[pollIDArr objectAtIndex:currRow]integerValue];
        
        pollDetailController.pollName = [array objectAtIndex:currRow];
    }
}

@end


