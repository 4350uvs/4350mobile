//
//  connectWithAppServer.m
//  UVS
//
//  Created by Richard Bruneau on 2013-03-25.
//  Copyright (c) 2013 Richard Bruneau. All rights reserved.
//

#import "connectWithAppServer.h"
#import "defines.h"


@implementation connectWithAppServer

- (NSData *)connectWithAppServerAtURL:(NSString*)uri paramToSend:(NSString *)param methodToUse:(NSString *)method
{
    
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
    
    
    NSLog(@"connectWithAppServer - Response: %@", response);
    NSLog(@"connectWithAppServer - Error: %@", error);
    NSLog(@"connectWithAppServer - Data: %@", responseData);
    
    
    if (response == nil) {
        
        NSLog(@"connectWithAppServer - Response was invalid");
        
        if (error != nil) {
            NSLog(@"connectWithAppServer - Error: %@", error);
        }
        
    }

    return responseData;
    
}

@end
