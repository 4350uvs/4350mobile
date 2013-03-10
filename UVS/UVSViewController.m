//
//  UVSViewController.m
//  UVS
//
//  Created by Richard Bruneau on 2013-03-04.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#define jsonURL [NSURL URLWithString:@"http://ec2-54-235-205-104.compute-1.amazonaws.com:8274/polls/1"]

#import "UVSViewController.h"

@interface UVSViewController ()

@end

@implementation UVSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSData* data = [NSData dataWithContentsOfURL: jsonURL];
        
    [self performSelectorOnMainThread:@selector(fetchedData:)withObject:data waitUntilDone:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


