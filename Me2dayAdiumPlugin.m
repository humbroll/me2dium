//
//  Me2dayAdiumPlugin.m
//  me2dium
//
//  Created by humbroll on 11. 1. 30.
//  Copyright 2011 humbroll corp. All rights reserved.
//

#import "Me2dayAdiumPlugin.h"
#import "MAMe2dayService.h"

#import <Adium/AIAdiumProtocol.h>
#import <Adium/AIInterfaceControllerProtocol.h>
#import <Adium/AIMenuControllerProtocol.h>
#import <Adium/AIPreferenceControllerProtocol.h>
#import <Adium/AIListObject.h>
#import <AIUtilities/AIStringUtilities.h>
#import <AIUtilities/AIMenuAdditions.h>
#import <AIUtilities/AIDateFormatterAdditions.h>


@implementation Me2dayAdiumPlugin

- (void)installPlugin
{
	NSLog(@"Me2dium installed!");
	[MAMe2dayService registerService];
}

- (void)uninstallPlugin 
{
	NSLog(@"Me2dium going away! Say goodbye:)");
}

- (NSString *)pluginAuthor
{
	return @"Sangil.Jung (a.k.a humbroll)";
}

- (NSString *)pluginVersion
{
	return @"1.0";
}

- (NSString *)pluginDescription
{
	return @"Me2dium";
}

- (NSString *)pluginURL
{
	return @"http://humbroll.com";
}

@end
