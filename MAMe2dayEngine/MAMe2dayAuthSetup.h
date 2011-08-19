//
//  MAMe2dayAuthSetup.h
//  me2dium
//
//  Created by humbroll on 11. 7. 20..
//  Copyright 2011 humbroll corp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	MAMe2dayFetchAuthURL = 0,
	MAMe2dayAcceptAuthFromUser, 
	MAMe2dayFetchUserApiKey
}MAMe2dayAuthStep;

#define APPLICATION_KEY @"88c4fb750045a78fafa0101f93663ba5"

@protocol MAMe2dayAuthSetupDelegate;

@interface MAMe2dayAuthSetup : NSObject {
	id delegate;
}

- (id)initWihtDelegate:(id<MAMe2dayAuthSetupDelegate>)aDelegate;
- (void)fetchAuthUrl;
- (void)fetchAccessToken:(NSString *)aAccessToken;

@end


@protocol MAMe2dayAuthSetupDelegate
-(void)receivedAuthURL:(NSString *)aAuthURL withAccessToken:(NSString *)aAccessToken;
-(void)receivedAuthToken:(NSString *)aAuthToken userId:(NSString *)aUserId;
@end 