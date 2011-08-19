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

@interface MAMe2dayAccountViewController : AIAccountViewController {
	IBOutlet	NSButton		*button_accessMe2day;
	
	MAMe2dayAuthSetup *maAuthSetup;
	MAMe2dayAuthStep maAuthStep;
	
}

-(id) init;
@end
