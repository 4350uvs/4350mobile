//
//  UVSCreatePollTest.m
//  UVS
//

#import "UVSCreatePollTest.h"

@implementation UVSCreatePollTest

- (void)setUp {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle: nil];
    
    uvsViewCreatePoll = [storyboard instantiateViewControllerWithIdentifier:@"createPollController"];
    STAssertNotNil(uvsViewCreatePoll, @"view for poll creation is nil.");
    
    [uvsViewCreatePoll performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
}

- (void)testUiElementsInit {
    UISegmentedControl *segmentedControl = uvsViewCreatePoll.choiceSeg;
    STAssertNotNil(segmentedControl, @"the segmented control for poll creation is nil.");
}

- (void)testInitialEnabledChoiceFields {

    UISegmentedControl *segmentedControl = uvsViewCreatePoll.choiceSeg;

    [uvsViewCreatePoll performSelectorOnMainThread:@selector(choiceSegment:) withObject:segmentedControl waitUntilDone:YES];

    NSMutableArray *pollChoices = [[NSMutableArray alloc]initWithObjects: uvsViewCreatePoll.pollChoice1, uvsViewCreatePoll.pollChoice2, uvsViewCreatePoll.pollChoice3, uvsViewCreatePoll.pollChoice4, uvsViewCreatePoll.pollChoice5, nil];

    STAssertTrue([[pollChoices objectAtIndex:0] isEnabled], @"The first choice field should be enabled.");
    STAssertTrue([[pollChoices objectAtIndex:1] isEnabled], @"The second choice field should be enabled.");
}

@end
