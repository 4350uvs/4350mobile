//
//  UVSViewCreatePoll.h
//  UVS
//
//  Created by Richard Bruneau on 2013-03-14.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UVSViewCreatePoll : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *pollTitle;
@property (strong, nonatomic) IBOutlet UITextField *pollCreator;
@property (strong, nonatomic) IBOutlet UITextField *pollQuestion;

- (IBAction)choiceSegment:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *choiceSeg;

@property (strong, nonatomic) IBOutlet UITextField *pollChoice1;

@property (strong, nonatomic) IBOutlet UITextField *pollChoice2;

@property (strong, nonatomic) IBOutlet UITextField *pollChoice3;

@property (strong, nonatomic) IBOutlet UITextField *pollChoice4;

@property (strong, nonatomic) IBOutlet UITextField *pollChoice5;

@property (strong, nonatomic) IBOutlet UIButton *pollSubmit;

@property (strong, nonatomic) IBOutlet UITextView *msgBox;

- (IBAction)submitPoll:(id)sender;

@end
