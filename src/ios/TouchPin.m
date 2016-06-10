#import "TouchPin.h"
#import "SecItemWrapper.h"

@implementation TouchPin

- (void)retrievePin:(CDVInvokedUrlCommand*)command {
	NSString* callbackId  = command.callbackId;
	NSString* forKey      = [command.arguments objectAtIndex:0];
	NSString* andText     = [command.arguments objectAtIndex:1];

	SecItemWrapper *wrapper = [SecItemWrapper.alloc initWithItemName:forKey andText:andText];
	NSString *pin = [wrapper getSecret];

	CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:pin];
	[self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)storePin:(CDVInvokedUrlCommand*)command {

	NSString* callbackId = command.callbackId;
	NSString* forKey     = [command.arguments objectAtIndex:0];
	NSString* token      = [command.arguments objectAtIndex:1];

	SecItemWrapper *wrapper = [SecItemWrapper.alloc initWithItemName:forKey andText:@""];
	[wrapper deleteSecret];
	if([token isKindOfClass:NSString.class] && token.length > 0) {
		#ifdef DEBUG
		NSLog(@"Saving token %@ to store", token);
		#endif
		[wrapper addSecret:token];
	} else {
		#ifdef DEBUG
		NSLog(@"Clearing token from store");
		#endif
		[wrapper deleteSecret];
	}

	CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
	[self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

@end
