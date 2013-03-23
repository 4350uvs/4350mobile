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

@end
