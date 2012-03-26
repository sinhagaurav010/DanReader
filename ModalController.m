//
//  ModalController.m
//  ICMiPhoneApp
//
//  Created by   on 27/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//

#import "ModalController.h"


@implementation ModalController
@synthesize stringRx,dataXml,delegate;
-(void)sendTheRequestWithPostString:(NSString*)string withURLString:(NSString*)URL
{
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest 
                                    requestWithURL:[NSURL URLWithString:URL] 
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    timeoutInterval:100];  
    
    if(string != nil)
    {
        NSData *postData = [string dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:postData];
        
        [request setHTTPMethod:@"POST"];
    }
    NSLog(@"request=%@",request);
    receivedData = [[NSMutableData alloc] init];
    
    NSURLConnection *connection = [[NSURLConnection alloc]
                                   initWithRequest:request
                                   delegate:self
                                   startImmediately:YES];
    
    
    [connection release];
}

+(void)saveTheContent:(id)savedEle withKey:(NSString*)stringKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:savedEle forKey:stringKey];
    
    [prefs synchronize];
    
}
+(void)removeContentForKey:(NSString*)stringKey
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:stringKey];
    [prefs synchronize];
    
}

#pragma mark -For decoding of the special character-

+ (NSString*) decodeHtmlUnicodeCharactersToString:(NSString*)str
{
    NSMutableString* string = [[NSMutableString alloc] initWithString:str];  // #&39; replace with '
    NSString* unicodeStr = nil;
    NSString* replaceStr = nil;
    int counter = -1;
    
    for(int i = 0; i < [string length]; ++i)
    {
        unichar char1 = [string characterAtIndex:i];    
        for (int k = i + 1; k < [string length] - 1; ++k)
        {
            unichar char2 = [string characterAtIndex:k];    
            
            if (char1 == '&'  && char2 == '#' ) 
            {   
                ++counter;
                unicodeStr = [string substringWithRange:NSMakeRange(i + 2 , 2)];    
                // read integer value i.e, 39
                replaceStr = [string substringWithRange:NSMakeRange (i, 5)];     //     #&39;
                [string replaceCharactersInRange: [string rangeOfString:replaceStr] withString:[NSString stringWithFormat:@"%c",[unicodeStr intValue]]];
                break;
            }
        }
    }
    [string autorelease];
    
    if (counter > 1)
        return  [self decodeHtmlUnicodeCharactersToString:string]; 
    else
        return string;
}

+(NSString*)replaceXMLStuffInString:(NSString*)source {
    int anInt;
    NSScanner *scanner = [NSScanner scannerWithString:source];
    scanner.charactersToBeSkipped = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    while ([scanner isAtEnd] == NO){
        if ([scanner scanInt:&anInt]){
            if ([source rangeOfString:[NSString stringWithFormat:@"&#%d;",anInt]].location != NSNotFound){
                source = [source stringByReplacingOccurrencesOfString:
                          [NSString stringWithFormat:@"&#%d;",anInt] withString:[NSString stringWithFormat:@"%C",anInt]];
            }
        }
    }
    return source;
}

#pragma mark -NSUserDefaults code-

+(id)getContforKey:(NSString*)stringKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:stringKey];
}
//+(NSString*)userId
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:BIZID];
//}

#pragma mark -Fetch the Image from File manager-
+(UIImage*)loadImage:(NSString*)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg", imageName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
    
}


#pragma mark -AlertMsg-
+(void)FuncAlertMsg:(NSString *)strMsg inController:(UIViewController *)controller
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info"
                                                    message:strMsg 
                                                   delegate:controller
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}


#pragma mark -ConvertToSystemTimeZone-

+(NSDate*) convertToSystemTimezone:(NSDate*)sourceDate {
    NSCalendar * calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSUInteger flags = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit );
    NSDateComponents * dateComponents = [calendar components:flags fromDate:sourceDate];
    
    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate * myDate = [calendar dateFromComponents:dateComponents];
    
    return myDate;
}




#pragma mark -delegate-


#pragma mark -connection-


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[receivedData appendData:data];    
    ////////NSLog(@"Received data is now %d bytes", [receivedData length]); 	  
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    stringRx = @"error";
    [self.delegate getError];
    //[[NSNotificationCenter defaultCenter] postNotificationName:ERROR object:nil];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    dataXml = [[NSData alloc] initWithData:receivedData];
    
    stringRx = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
    //////NSLog(@"GetString-%@",stringRx);
    [self.delegate getdata];
    //[[NSNotificationCenter defaultCenter] postNotificationName:GETXML 
    //                                                  object:nil];
}

//+(UIView*)titleView
//{
//    UILabel *Loco = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 100, 30)];
//    Loco.textColor = [UIColor grayColor];
//    Loco.font = [UIFont systemFontOfSize:25];
//    Loco.backgroundColor = [UIColor clearColor];
//    Loco.text = @"Loco";
//    Loco.textAlignment = UITextAlignmentRight;
//    
//    UILabel *ping = [[UILabel alloc] initWithFrame:CGRectMake(100, 7, 100, 30)];
//    ping.textColor = [UIColor orangeColor];
//    ping.font = [UIFont systemFontOfSize:25];
//    ping.backgroundColor = [UIColor clearColor];
//    ping.text = @"Ping";
//    
//    UIView *locoPingView = [[[UIView alloc] initWithFrame:CGRectMake(60, 0, 260, 44)] autorelease];
//    [locoPingView addSubview:Loco];
//    [locoPingView addSubview:ping];
//    //    [self.navigationItem.titleView addSubview:Loco];
//    //    [self.navigationItem.titleView addSubview:ping];
//    
//    [Loco release];
//    [ping release];
//    
//    return locoPingView;
//}



-(void)dealloc
{ 
    //    [receivedData release];
    //    [stringRx release];
    [super dealloc];
}
@end
