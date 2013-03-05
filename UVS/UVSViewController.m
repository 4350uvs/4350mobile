//
//  UVSViewController.m
//  UVS
//
//  Created by Richard Bruneau on 2013-03-04.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import "UVSViewController.h"

@interface UVSViewController ()

@end

@implementation UVSViewController

- (void)viewDidLoad
{
    
    UIImage *image = [UIImage imageNamed:@"/home/student/umbruner/Desktop/UVS/UVS/UVS/logo-3-PSD-TEXT-TRANS-PNG-SM.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithImage: image];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


