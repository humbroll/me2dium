//
//  MAMe2dayAccount.h
//  me2dium
//
//  Created by humbroll on 11. 1. 30..
//  Copyright 2011 humbroll corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Adium/AIAccount.h>

#define ME2DAY_PREFERENCE_GROUP				@"ME2DAY_PREFERENCE_GROUP"

#define ME2DAY_UPDATE_INTERVAL_KEY			@"ME2DAY_UPDATE_INTERVAL_KEY"
#define ME2DAY_UPDATE_AFTER_SEND_FLAG_KEY	@"ME2DAY_UPDATE_AFTER_SEND_FLAG_KEY"

#define ME2DAY_UPDATE_INTERVAL			1
#define ME2DAY_UPDATE_AFTER_SEND_FLAG	YES

#define ME2DAY_REMOTE_GROUP_NAME			@"me2day"
#define ME2DAY_TIMELINE_NAME				@"me2day timeline"

@interface MAMe2dayAccount : AIAccount {
	NSTimer *updateTimer;
}
@property (readonly, nonatomic) NSString *timelineChatName;
@property (readonly, nonatomic) NSString *timelineGroupName;

- (void)didConnectReady;
@end
