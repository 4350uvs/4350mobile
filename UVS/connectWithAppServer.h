//
//  connectWithAppServer.h
//  UVS
//
//  Copyright (c) COMP4350 - Group 3 - UVS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface connectWithAppServer : NSObject

- (NSData *)connectWithAppServerAtURL:(NSString*)uri paramToSend:(NSString *)param methodToUse:(NSString *)method;

@end
