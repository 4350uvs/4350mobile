//
//  connectWithAppServer.m
//  UVS
//
//  Copyright (c) COMP4350 - Group 3 - UVS. All rights reserved.
//

#import "connectWithAppServer.h"
#import "defines.h"


@implementation connectWithAppServer

- (NSMutableArray *)connectWithAppServerAtURL:(NSString*)uri paramToSend:(NSString *)param methodToUse:(NSString *)method
{
    
    NSMutableArray *returnData = [[NSMutableArray alloc] init];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@", ServerURL, uri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	
    NSString *dataStr = param;
    
    NSError *error;
    NSURLResponse *response;
    
    [request setHTTPMethod:[NSString stringWithFormat:@"%@", method] ];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[dataStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
	
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    //TEST
    NSLog(@"connectWithAppServer - Response Data: %@", responseData);
    NSLog(@"connectWithAppServer - Response: %@", response);
    NSLog(@"connectWithAppServer - Error: %@", error);
    //TEST
    
    
    if (response == nil) {
        
        NSLog(@"connectWithAppServer - Response was invalid");
        
        if (error != nil) {
            NSLog(@"connectWithAppServer - Error: %@", error);
        }
        
    }else{
    
        [returnData addObject:responseData];
        [returnData addObject:response];
        
        if ( error == nil ){
            [returnData addObject:[NSNull null]];
        }else{
            [returnData addObject:error];
        }
        
    }

    return returnData;
    
}

@end
