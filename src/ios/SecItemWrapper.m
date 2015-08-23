#import "SecItemWrapper.h"

@implementation SecItemWrapper

@synthesize serviceName;

- (instancetype)initWithServiceName:(NSString *)name {
	self = [super init];
	if (self) {
		serviceName = name;
	}
	return self;
}

- (void)addSecret:(NSString *)token {
	CFErrorRef error = NULL;
	
	SecAccessControlRef sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
																						 kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
																						 kSecAccessControlTouchIDCurrentSet, &error);
	if (sacObject == NULL || error != NULL) {
		NSString *errorString = [NSString stringWithFormat:@"SecItemAdd can't create sacObject: %@", error];
		NSLog(@"%@", errorString);
		return;
	}
	
	/*
	 We want the operation to fail if there is an item which needs authentication so we will use
	 `kSecUseNoAuthenticationUI`.
	 */
	NSData *secretPasswordTextData = [token dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *attributes = @{
										  (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
										  (__bridge id)kSecAttrService: serviceName,
										  (__bridge id)kSecValueData: secretPasswordTextData,
										  (__bridge id)kSecAttrAccessControl: (__bridge_transfer id)sacObject
										  };
	
	OSStatus status =  SecItemAdd((__bridge CFDictionaryRef)attributes, nil);
	NSLog(@"SecItemAdd status: %@", [self keychainErrorToString:status]);
}

- (NSString *)getSecret {
	NSDictionary *query = @{
									(__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
									(__bridge id)kSecAttrService: serviceName,
									(__bridge id)kSecReturnData: @YES,
									(__bridge id)kSecUseOperationPrompt: @"Authenticate to access service password",
									};
	
	CFTypeRef dataTypeRef = NULL;
	
	OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)(query), &dataTypeRef);
	if (status == errSecSuccess) {
		NSData *resultData = (__bridge_transfer NSData *)dataTypeRef;
		
		NSString *result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
		NSLog(@"SecItemCopyMatching got: %@", result);
		return result;
	}
	else {
		NSLog(@"SecItemCopyMatching status: %@", [self keychainErrorToString:status]);
		return NULL;
	}
}

- (void)deleteSecret {
	NSDictionary *query = @{
									(__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
									(__bridge id)kSecAttrService: serviceName
									};
	
	OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
	
	NSString *errorString = [self keychainErrorToString:status];
	NSLog(@"SecItemDelete status: %@", errorString);
}

- (NSString *)keychainErrorToString:(OSStatus)error {
	NSString *message = [NSString stringWithFormat:@"%ld", (long)error];
	
	switch (error) {
		case errSecSuccess:
			message = @"success";
			break;
			
		case errSecDuplicateItem:
			message = @"error item already exists";
			break;
			
		case errSecItemNotFound :
			message = @"error item not found";
			break;
			
		case errSecAuthFailed:
			message = @"error item authentication failed";
			break;
			
		default:
			break;
	}
	
	return message;
}

@end