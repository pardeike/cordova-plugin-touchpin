#import <Foundation/Foundation.h>

@interface SecItemWrapper : NSObject {
}

- (instancetype)initWithServiceName:(NSString *)name;
- (void)addSecret:(NSString *)token;
- (NSString *)getSecret;
- (void)deleteSecret;

@property NSString *serviceName;

@end