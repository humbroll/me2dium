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

@interface MAMe2dayAuthSetup : NSObject {
}

- (void)fetchAuthUrl;
- (void)fetchAccessToken;

@end
