//
//  UVSTests.m
//  UVSTests
//
//  Copyright (c) COMP4350 - Group 3 - UVS. All rights reserved.
//

#import "UVSTests.h"
#import "connectWithAppServer.h"

@implementation UVSTests


- (void)setUp
{
    [super setUp];
}


- (void)tearDown
{
    [super tearDown];
}


- (void)test_connection_works
{
    
    connectWithAppServer *connectToAPI = [connectWithAppServer alloc];
    
    NSMutableArray *responseArray = [connectToAPI connectWithAppServerAtURL:[NSString stringWithFormat:@""]
                                                                paramToSend:[NSString stringWithFormat:@""]
                                                                methodToUse:@"GET"];
    
    STAssertNotNil(connectToAPI, @"Connection is null");
    
    NSURLResponse *response = [responseArray objectAtIndex:1];
    
    STAssertNotNil(response, @"Response is null");
    
}


@end
