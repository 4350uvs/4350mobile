//
//  UVSViewVotePoll.m
//  UVS
//

#import "UVSViewVotePoll.h"
#import "UVSViewPollDetail.h"

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
    
    
    [[self pollTable]setDelegate:self];
    [[self pollTable]setDataSource:self];
    array = [[NSMutableArray alloc] init];
    pollIDArr = [[NSMutableArray alloc] init];
    
    [self loadTable];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [jsonData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jsonData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Communication with the app server failed. Please check your Internet connection.");
    //TODO notice to user
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSArray *polls = [allDataDictionary objectForKey:@"polls"];
    
    for (NSDictionary *dict in polls) {
        NSString *pollTitle = [dict objectForKey:@"title"];
        NSInteger pollID = [[dict objectForKey:@"id"] intValue];
        
        [array addObject:pollTitle];
        [pollIDArr addObject: [NSNumber numberWithInteger:pollID]];
    }
    [[self pollTable]reloadData];
}

-(void)loadTable{
    
    [array removeAllObjects];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://ec2-54-235-121-23.compute-1.amazonaws.com:8274/polls"];
    NSURL *url = [NSURL URLWithString:urlStr];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection)
    {
        jsonData = [[NSMutableData alloc]init];
    }
    
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PollDetailSegue"])
    {
        NSIndexPath *index = [self.pollTable indexPathForSelectedRow];
        UVSViewPollDetail *pollDetailController = segue.destinationViewController;
        NSUInteger currRow = index.row;

        pollDetailController.pollNum = [[pollIDArr objectAtIndex:currRow]integerValue];

        NSLog(@"pid: %d", [[pollIDArr objectAtIndex:currRow] integerValue]);
        
        pollDetailController.pollName = [array objectAtIndex:currRow];
    }
}

@end


