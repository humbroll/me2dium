//
//  MAMe2dayAccount.m
//  me2dium
//
//  Created by humbroll on 11. 1. 30..
//  Copyright 2011 humbroll corp. All rights reserved.
//

#import "MAMe2dayAccount.h"
#import <Adium/AIListBookmark.h>
#import <Adium/AIPlugin.h>
#import <Adium/AIContactControllerProtocol.h>
#import <Adium/AIContactObserverManager.h>
#import <AIUtilities/AIAttributedStringAdditions.h>

@implementation MAMe2dayAccount

- (void)initAccount 
{
	[super initAccount];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(chatDidOpen:)
												 name:Chat_DidOpen 
											   object:nil];
}
#pragma mark AIAccount methods
- (void)connect
{
	[super connect];
}

- (void)didConnectReady
{
	// like twitter plugin's "- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)identifier" method 	
	[[AIContactObserverManager sharedManager] delayListObjectNotifications];	
	
	
	NSString *me2dayInfoUID = @"me2daybot";
	
	AIListContact *listContact = [self contactWithUID:me2dayInfoUID];
	
	// If the user isn't in a group, set them in the Twitter group.
	if (listContact.countOfRemoteGroupNames == 0) {
		[listContact addRemoteGroupName:self.timelineGroupName];
	}
	

	[listContact setServersideAlias:@"me2daybot"
							   silently:silentAndDelayed];
	
	// Grab the user icon and set it as their serverside icon.
	//	[self updateUserIcon:[user objectForKey:TWITTER_INFO_ICON] forContact:listContact];
	
	// Set the user as available.
	[listContact setStatusWithName:nil
						statusType:AIAvailableStatusType
							notify:NotifyLater];
	
	// Set the user's status message to their current me2day status text
	NSString *statusText = @"me2jijija";
	[listContact setStatusMessage:[NSAttributedString stringWithString:statusText] notify:NotifyLater];
	
	// Set the user as online.
	[listContact setOnline:YES notify:NotifyLater silently:silentAndDelayed];
	
	[listContact notifyOfChangedPropertiesSilently:silentAndDelayed];
	
	[[AIContactObserverManager sharedManager] endListObjectNotificationsDelay];
	
	
	[self didConnect];
}

- (void)didConnect
{
	[super didConnect];
	

	
	// -- dummy data
	
	// Creating the timeline chat's bookmark.
	AIListBookmark *timelineBookmark = [adium.contactController existingBookmarkForChatName:self.timelineChatName 
																				  onAccount:self
																		   chatCreationInfo:nil];
	
	if (timelineBookmark) {
		[timelineBookmark restoreGrouping];
		
	} else {
		AIChat *newTimelineChat = [adium.chatController chatWithName:self.timelineChatName 
														  identifier:nil
														   onAccount:self 
													chatCreationInfo:nil];
		
		[newTimelineChat setDisplayName:self.timelineChatName];
		
		timelineBookmark = [adium.contactController bookmarkForChat:newTimelineChat
															inGroup:[adium.contactController groupWithUID:self.timelineGroupName]];
		
		
		if(!timelineBookmark) {
			NSLog(@"%@ Timeline bookmark is nil! Tried checking for existing bookmark for chat name %@, and creating a bookmark for chat %@ in group %@",
				  self.timelineChatName, newTimelineChat,
				  [adium.contactController groupWithUID:self.timelineGroupName]);
		}
	}
	
	NSTimeInterval updateInterval = [[self preferenceForKey:@"Update Interval In Minutes" group:@"Me2day Preferences"] integerValue] * 60;
	
	if(updateInterval > 0) {
		[updateTimer invalidate];
		updateTimer = [NSTimer scheduledTimerWithTimeInterval:updateInterval
													   target:self
													 selector:@selector(periodicUpdate)
													 userInfo:nil
													  repeats:YES];
		
		//[self periodicUpdate];
	}
}
- (void)disconnect
{
	[super disconnect];
	
	[updateTimer invalidate]; updateTimer = nil;
	
	[self didDisconnect];
}

- (void)willBeDeleted
{
	[updateTimer invalidate]; updateTimer = nil;
	
	[super willBeDeleted];
}

- (void)didDisconnect
{
	[updateTimer invalidate]; updateTimer = nil;
	
	[super didDisconnect];
}

- (void)chatDidOpen:(NSNotification *)notification
{
	AIChat *chat = [notification object];
	
	if(chat.isGroupChat && chat.account == self) {
//		[self updateTimelineChat:chat];
	}	
}

#pragma mark periodic update scheduler
- (void)periodicUpdate
{	
	
}


- (NSString *)timelineChatName
{
	return [NSString stringWithFormat:ME2DAY_TIMELINE_NAME, self.UID];
}

- (NSString *)timelineGroupName
{
	return ME2DAY_REMOTE_GROUP_NAME;
}
@end
