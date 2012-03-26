//
//  ModalController.h
//  ICMiPhoneApp
//
//  Created by   on 27/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"

@protocol ModalDelegate <NSObject>
-(void)getdata;
-(void)getError;
@end

@interface ModalController : NSObject {
    
    id <ModalDelegate> delegate;

    NSMutableData *receivedData;
    NSString *stringRx;
    NSData *dataXml;

}
+(void)removeContentForKey:(NSString*)stringKey;
+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str;
+(NSString*)replaceXMLStuffInString:(NSString*)source;
+(id)getContforKey:(NSString*)stringKey;
+(void)saveTheContent:(id)savedEle withKey:(NSString*)string;

+(NSString*)userId;
+(UIImage*)loadImage:(NSString*)imageName;
//+(void)sendLog:(NSString *)string;
//+(NSDate*) convertToSystemTimezone:(NSDate*)sourceDate ;
+(void)FuncAlertMsg:(NSString *)strMsg inController:(UIViewController *)controller;

@property(nonatomic,retain)    NSString *stringRx;
@property(nonatomic,retain)    NSData *dataXml;
@property (retain)	id <ModalDelegate> delegate;
//+(void)parsingDataLarge:(NSString*)stringDataXml extractDataForKey:(NSMutableArray*)arrayKey;
-(void)sendTheRequestWithPostString:(NSString*)string withURLString:(NSString*)URL;
@end
