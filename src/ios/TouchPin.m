#import "TouchPin.h"

@implementation TouchPin

- (void) store:(CDVInvokedUrlCommand*)command {

	NSString* callbackId = [command callbackId];
	NSString* domain     = [[command arguments] objectAtIndex:0];
	NSString* key        = [[command arguments] objectAtIndex:1];
	NSString* value      = [[command arguments] objectAtIndex:2];

	CDVPluginResult* result = [CDVPluginResult
											resultWithStatus:CDVCommandStatus_OK
											messageAsString:@"result"];

	[self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

@end