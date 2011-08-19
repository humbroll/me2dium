//
//  MAMe2dayAuthSetup.m
//  me2dium
//
//  Created by humbroll on 11. 7. 20..
//  Copyright 2011 humbroll corp. All rights reserved.
//

#import "MAMe2dayAuthSetup.h"
#import "SBJson.h"

@implementation MAMe2dayAuthSetup

#pragma mark Me2day auth step methods
- (void)fetchAuthUrl
{	
	NSURL *urlForFetchAuthUrl = [NSURL URLWithString:@"http://me2day.net/api/get_auth_url.json"];
	NSMutableURLRequest *fetchAuthUrlReq = [[[NSMutableURLRequest alloc] initWithURL:urlForFetchAuthUrl] autorelease];
	[fetchAuthUrlReq addValue:APPLICATION_KEY forHTTPHeaderField:@"me2_application_key"];
	[fetchAuthUrlReq setHTTPMethod:@"GET"];
	
	NSURLResponse *fetchAuthResponse = NULL;
	NSData *fetchAuthResponseData = NULL;
	NSError *fetchAuthResponseError = NULL;
	fetchAuthResponseData = [NSURLConnection sendSynchronousRequest:fetchAuthUrlReq returningResponse:&fetchAuthResponse error:&fetchAuthResponseError];
	
	
	if( fetchAuthResponseError != nil){
		// TODO error handling 
		// NSLog([NSString stringWithFormat:@"(%@)[%d]", fetchAuthResponseError.domain , fetchAuthResponseError.code]);
	}else{
		//save auth url in user preferences, and open the browser with this URL 
		SBJsonParser *jsonParser = [[[SBJsonParser alloc] init] autorelease];
		NSString *reponseString = [[[NSString alloc] initWithData:fetchAuthResponseData encoding:NSUTF8StringEncoding] autorelease];
		NSDictionary *responseJson = [jsonParser objectWithString:reponseString];
		NSUserDefaults *prefs =  [NSUserDefaults standardUserDefaults];
		[prefs setObject:[responseJson objectForKey:@"url"] forKey:@"me2day_auth_url"];
		[prefs setObject:[responseJson objectForKey:@"token"] forKey:@"me2day_access_token"];

		[[NSNotificationCenter defaultCenter] postNotificationName:@"fetch_auth_url" object:self];
	}
}

- (void)fetchAccessToken
{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *access_token = [prefs stringForKey:@"me2day_access_token"];
	NSURL *urlForFetchAccessToken = [NSURL URLWithString:[NSString stringWithFormat:@"http://me2day.net/api/get_full_auth_token.json?token=%@",access_token]];
	
	NSMutableURLRequest *fetchAccessTokenUrlReq = [[[NSMutableURLRequest alloc] initWithURL:urlForFetchAccessToken] autorelease];
	[fetchAccessTokenUrlReq addValue:APPLICATION_KEY forHTTPHeaderField:@"me2_application_key"];
	[fetchAccessTokenUrlReq setHTTPMethod:@"GET"];
	
	NSURLResponse *fetchAccessTokenResponse = NULL;
	NSData *fetchAccessTokenResponseData = NULL;
	NSError *fetchAccessTokenResponseError = NULL;
	fetchAccessTokenResponseData = [NSURLConnection sendSynchronousRequest:fetchAccessTokenUrlReq returningResponse:&fetchAccessTokenResponse error:&fetchAccessTokenResponseError];
	
	
	if( fetchAccessTokenResponseError != nil){
		// TODO error handling 
		// NSLog([NSString stringWithFormat:@"(%@)[%d]", fetchAuthResponseError.domain , fetchAuthResponseError.code]);
	}else{
		//save auth url in user preferences, and open the browser with this URL 
		SBJsonParser *jsonParser = [[[SBJsonParser alloc] init] autorelease];
		NSString *reponseString = [[[NSString alloc] initWithData:fetchAccessTokenResponseData encoding:NSUTF8StringEncoding] autorelease];
		NSDictionary *responseJson = [jsonParser objectWithString:reponseString];
		NSUserDefaults *prefs =  [NSUserDefaults standardUserDefaults];
		[prefs setObject:[responseJson objectForKey:@"user_id"] forKey:@"me2day_user_id"];
		[prefs setObject:[responseJson objectForKey:@"auth_token"] forKey:@"me2day_auth_token"];
		
	}
	
}

@end
