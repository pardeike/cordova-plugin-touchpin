#import <Cordova/CDV.h>

@interface TouchPin : CDVPlugin

- (void)retrievePin:(CDVInvokedUrlCommand*)command;
- (void)storePin:(CDVInvokedUrlCommand*)command;

@end