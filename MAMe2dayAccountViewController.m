//
//  MAMe2dayAccountViewController.m
//  me2dium
//
//  Created by humbroll on 11. 2. 6.
//  Copyright 2011 humbroll corp. All rights reserved.
//

#import "MAMe2dayAccountViewController.h"

@interface MAMe2dayAccountViewController(PrivateMethods)
- (void)setButtonText:(NSString *)buttonText buttonEnbaled:(BOOL)enabled;
- (void)setTextFieldText:(NSString *)textfieldText;
@end


@implementation MAMe2dayAccountViewController

@synthesize accessToken;
@synthesize authToken;
@synthesize userId;

-(id) init
{
	if ( self = [super init] ){
		maAuthStep = MAMe2dayFetchAuthURL;
	}
	return self;
}

- (void) awakeFromNib
{
// anything to do? :( 
}

- (void) saveConfiguration
{
	[super saveConfiguration];
	
//	[account setPreference:ME2DAY_UPDATE_INTERVAL
//					forKey:ME2DAY_UPDATE_INTERVAL_KEY
//					 group:ME2DAY_PREFERENCE_GROUP];
}

- (NSView *)profileView
{
	return nil;
}

- (NSView *)optionsView
{
	return nil;
}

- (NSView *)privacyView
{
	return nil;
}

- (NSString *)nibName
{
	return @"MAMe2dayAccountView";
}

/*
 * general view event handler - inheritance methods 
 */
- (IBAction)changedPreference:(id)sender
{	
	
	if(sender == button_accessMe2day) {
		if ( maAuthStep == MAMe2dayFetchAuthURL ){
			if (maAuthSetup == nil) {
				maAuthSetup = [[MAMe2dayAuthSetup alloc] initWihtDelegate:self];
			}
			[maAuthSetup fetchAuthUrl];
		} else { // maAuthStep == MAMe2dayAcceptAuthFromUser;
			[maAuthSetup fetchAccessToken:accessToken];
		}
	}

}

#pragma mark MAMe2dayAuthSetupDelegate methods 
-(void)receivedAuthURL:(NSString *)aAuthURL withAccessToken:(NSString *)aAccessToken
{
	AILog(@"in delegate method url : %@, token : %@",aAuthURL, aAccessToken);
	if ( aAuthURL != nil && aAccessToken != nil ){
		accessToken = [[NSString alloc] initWithString:aAccessToken];
		//open default browser with authURL
		[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:aAuthURL]]; 
		[self setButtonText:@"인증을 하셨으면,\nTouch Me.2day one more time." buttonEnbaled:YES];
		
		maAuthStep = MAMe2dayAcceptAuthFromUser;
	}	
	//TODO handlig exceptional response 
}
-(void)receivedAuthToken:(NSString *)aAuthToken userId:(NSString *)aUserId
{
	if ( aAuthToken != nil ){
		authToken = aAuthToken;
		userId = aUserId;
		[self setButtonText:[NSString stringWithFormat:@"Hi, %@.\nWelcome to the Me2dium.", userId] buttonEnbaled:NO];
		MAMe2dayAccount *me2dayAccount = (MAMe2dayAccount *)account;		
		[me2dayAccount didConnectReady];
	}
	//TODO handlig exceptional response
}

#pragma mark private methods 
- (void)setButtonText:(NSString *)buttonText buttonEnbaled:(BOOL)enabled
{
	[button_accessMe2day setTitle:buttonText];
	//TODO set position and size
}

- (void) dealloc
{
	[maAuthSetup release]; maAuthSetup = nil;
	[accessToken release]; accessToken = nil;
	[super dealloc];
}
@end
