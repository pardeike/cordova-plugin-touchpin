#import "TouchPin.h"
#import "SecItemWrapper.h"

@implementation TouchPin

- (void)retrievePin:(CDVInvokedUrlCommand*)command {
	NSString* callbackId = [command callbackId];

	SecItemWrapper *wrapper = [[SecItemWrapper alloc] initWithServiceName:@"TestService"];
	NSString *pin = [wrapper getSecret];

	CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:pin];
	[self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)storePin:(CDVInvokedUrlCommand*)command {

	NSString* callbackId = [command callbackId];
	NSString* token      = [[command arguments] objectAtIndex:0];

	SecItemWrapper *wrapper = [[SecItemWrapper alloc] initWithServiceName:@"TestService"];
	[wrapper deleteSecret];
	if(token != NULL && [token length] > 0) {
		[wrapper addSecret:token];
	}

	CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
	[self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

@end