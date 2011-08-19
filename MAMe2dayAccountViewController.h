//
//  MAMe2dayAccountViewController.h
//  me2dium
//
//  Created by humbroll on 11. 2. 6..
//  Copyright 2011 humbroll corp. All rights reserved.
//

#import <Adium/AIAccountViewController.h>
#import "MAMe2dayAuthSetup.h"
#import "MAMe2dayAccount.h"

@interface MAMe2dayAccountViewController : AIAccountViewController <MAMe2dayAuthSetupDelegate>{
	IBOutlet	NSButton		*button_accessMe2day;

	MAMe2dayAuthStep maAuthStep;

	MAMe2dayAuthSetup *maAuthSetup;
	NSString *accessToken;
	NSString *authToken;
	NSString *userId;
}

@property (retain, nonatomic) NSString *accessToken;
@property (retain, nonatomic) NSString *authToken;
@property (retain, nonatomic) NSString *userId;

-(id) init;
@end
