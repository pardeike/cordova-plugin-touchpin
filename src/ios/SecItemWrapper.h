#import <Foundation/Foundation.h>

@interface SecItemWrapper : NSObject {
}

- (instancetype)initWithItemName:(NSString *)name andText:(NSString *)text;
- (void)addSecret:(NSString *)token;
- (NSString *)getSecret;
- (void)deleteSecret;

@property NSString *itemName;
@property NSString *itemText;

@end
