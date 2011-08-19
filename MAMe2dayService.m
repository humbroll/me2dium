//
//  MAMe2dayService.m
//  me2dium
//
//  Created by humbroll on 11. 1. 30..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MAMe2dayService.h"
#import "MAMe2dayAccount.h"
#import "MAMe2dayAccountViewController.h"
#import <AIUtilities/AIImageAdditions.h>
#import <Adium/AIStatusControllerProtocol.h>
#import <Adium/AISharedAdium.h>

@implementation MAMe2dayService

- (Class)accountClass
{
	return [MAMe2dayAccount class];
}

- (AIAccountViewController *)accountViewController
{
	return [MAMe2dayAccountViewController accountViewController];
}

#pragma mark service description 
- (NSString *)serviceCodeUniqueID{
	return @"me2day";
}
- (NSString *)serviceID{
	return @"Me2day";
}
- (NSString *)serviceClass{
	return @"Me2day";
}
- (NSString *)shortDescription{
	return @"Me2day";
}
- (NSString *)longDescription{
	return @"Me2day";
}

#pragma mark service properties 
- (NSCharacterSet *)allowedCharacters{
	return [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_"];
}
- (NSCharacterSet *)ignoredCharacters{
	return [NSCharacterSet characterSetWithCharactersInString:@""];
}
- (NSUInteger)allowedLength{
	return 999;
}
- (BOOL)caseSensitive{
	return NO;
}

- (AIServiceImportance)serviceImportance{
	return AIServiceSecondary;
}
- (BOOL)supportsProxySettings{
	return NO;
}

- (BOOL)requiresPassword
{
	return NO;
}

- (BOOL)isSocialNetworkingService
{
	return YES;
}

- (NSImage *)defaultServiceIconOfType:(AIServiceIconType)iconType
{
	if ((iconType == AIServiceIconSmall) || (iconType == AIServiceIconList)) {
		//return [NSImage imageNamed:@"me2day-small" forClass:[self class] loadLazily:YES];
		return [NSImage imageNamed:@"me2day-small" forClass:[self class]];
	} else {
		//return [NSImage imageNamed:@"me2day" forClass:[self class] loadLazily:YES];
		return [NSImage imageNamed:@"me2day" forClass:[self class]];
	}
}

- (NSString *)pathForDefaultServiceIconOfType:(AIServiceIconType)iconType
{
	if ((iconType == AIServiceIconSmall) || (iconType == AIServiceIconList)) {
		return [[NSBundle bundleForClass:[self class]] pathForImageResource:@"me2day-small"];
	} else {
		return [[NSBundle bundleForClass:[self class]] pathForImageResource:@"me2day"];
	}
}

- (void)registerStatuses{
	[adium.statusController registerStatus:STATUS_NAME_AVAILABLE
						   withDescription:[adium.statusController localizedDescriptionForCoreStatusName:STATUS_NAME_AVAILABLE]
									ofType:AIAvailableStatusType
								forService:self];
}

@end
