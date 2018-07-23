//
//  AppDelegate.m
//  LK8000i
//
//  Created by Nicola Ferruzzi on 05/03/16.
//  Copyright © 2016 Nicola Ferruzzi. All rights reserved.
//
// libPNG requires: -DPNG_ARM_NEON_OPT=0

#import <Objc/runtime.h>
#import <SDL.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import "AppDelegate.h"
#import "ArchiveUnzip.h"
#import "LKCLHelper.h"

#include "externs.h"
#include "Parser.h"

extern NMEA_INFO GPS_INFO;

@interface SDLUIKitDelegate (LK8000)
@end

// From so
void SwizzleClassMethod(Class c, SEL orig, SEL newSel) {
    Method origMethod = class_getClassMethod(c, orig);
    Method newMethod = class_getClassMethod(c, newSel);
    
    c = object_getClass((id)c);
    
    if (class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, newSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}

@implementation SDLUIKitDelegate (LK8000)

+ (void)load {
    if (self != [SDLUIKitDelegate class]) {
        return;
    }
    
    SwizzleClassMethod([SDLUIKitDelegate class],
                       @selector(getAppDelegateClassName),
                       @selector(getAppDelegateClassNameCustom));
}

+ (NSString *)getAppDelegateClassNameCustom {
    return @"AppDelegate";
}

@end

#pragma mark 

@interface AppDelegate ()
@end

@implementation AppDelegate

- (NSArray *)getGeolocationWithCoreLocation:(CLLocation *)location {
    // 10進数の緯度経度を60進数の緯度経度に変換します。
    CLLocationDegrees latitude = [self convertCLLocationDegreesToNmea:location.coordinate.latitude];
    CLLocationDegrees longitude = [self convertCLLocationDegreesToNmea:location.coordinate.longitude];
    
    // GPGGAレコード
    NSMutableString *nmea0183GPGGA = [[NSMutableString alloc] init];
    NSDateFormatter *nmea0183GPGGATimestampFormatter = [[NSDateFormatter alloc] init];
    [nmea0183GPGGATimestampFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [nmea0183GPGGATimestampFormatter setDateFormat:@"HHmmss.SSS"];
    [nmea0183GPGGA appendString:@"GPGGA,"];
    [nmea0183GPGGA appendFormat:@"%@,", [nmea0183GPGGATimestampFormatter stringFromDate:location.timestamp]]; // 測位時刻
    [nmea0183GPGGA appendFormat:@"%08.4f,", latitude]; // 緯度
    [nmea0183GPGGA appendFormat:@"%@,", (latitude > 0.0 ? @"N" : @"S")]; // 北緯、南緯
    [nmea0183GPGGA appendFormat:@"%08.4f,", longitude]; // 経度
    [nmea0183GPGGA appendFormat:@"%@,", (longitude > 0.0 ? @"E" : @"W")]; // 東経、西経
    [nmea0183GPGGA appendString:@"1,"]; // 位置特定品質: 単独測位
    [nmea0183GPGGA appendString:@"08,"]; // 受信衛星数: 8?
    [nmea0183GPGGA appendString:@"1.0,"]; // 水平精度低下率: 1.0?
    [nmea0183GPGGA appendFormat:@"%1.1f,", location.altitude]; // アンテナの海抜高さ
    [nmea0183GPGGA appendString:@"M,"]; // アンテナの海抜高さ単位: メートル
    [nmea0183GPGGA appendFormat:@"%1.1f,", location.altitude]; // ジオイド高さ
    [nmea0183GPGGA appendString:@"M,"]; // ジオイド高さ: メートル
    [nmea0183GPGGA appendString:@","]; // DGPSデータの寿命: 不使用
    [nmea0183GPGGA appendString:@","]; // 差動基準地点ID: 不使用
    unichar nmea0183GPGGAChecksum = 0;
    for (NSInteger index = 0; index < nmea0183GPGGA.length; index++) {
        nmea0183GPGGAChecksum ^= [nmea0183GPGGA characterAtIndex:index];
    }
    nmea0183GPGGAChecksum &= 0x0ff;
    [nmea0183GPGGA insertString:@"$" atIndex:0];
    [nmea0183GPGGA appendString:@"*"];
    [nmea0183GPGGA appendFormat:@"%02lX\n", (long)nmea0183GPGGAChecksum]; // チェックサム
    
    // GPRMCレコード
    NSMutableString *nmea0183GPRMC = [[NSMutableString alloc] init];
    NSDateFormatter *nmea0183GPRMCTimestampFormatter = [[NSDateFormatter alloc] init];
    [nmea0183GPRMCTimestampFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [nmea0183GPRMCTimestampFormatter setDateFormat:@"HHmmss.SSS"];
    NSDateFormatter *nmea0183GPRMCDateFormatter = [[NSDateFormatter alloc] init];
    [nmea0183GPRMCDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [nmea0183GPRMCDateFormatter setDateFormat:@"ddMMyy"];
    [nmea0183GPRMC appendString:@"GPRMC,"];
    [nmea0183GPRMC appendFormat:@"%@,", [nmea0183GPRMCTimestampFormatter stringFromDate:location.timestamp]]; // 測位時刻
    [nmea0183GPRMC appendString:@"A,"]; // ステータス: 有効
    [nmea0183GPRMC appendFormat:@"%08.4f,", latitude]; // 緯度
    [nmea0183GPRMC appendFormat:@"%@,", (latitude > 0.0 ? @"N" : @"S")]; // 北緯、南緯
    [nmea0183GPRMC appendFormat:@"%08.4f,", longitude]; // 経度
    [nmea0183GPRMC appendFormat:@"%@,", (longitude > 0.0 ? @"E" : @"W")]; // 東経、西経
    [nmea0183GPRMC appendFormat:@"%04.1f,", (location.course > 0.0 ? location.speed * 3600.0 / 1000.0 * 0.54 : 0.0)]; // 移動速度(ノット毎時)
    [nmea0183GPRMC appendFormat:@"%04.1f,", (location.course > 0.0 ? location.course : 0.0)]; // 移動方向
    [nmea0183GPRMC appendFormat:@"%@,", [nmea0183GPRMCDateFormatter stringFromDate:location.timestamp]]; // 測位日付
    [nmea0183GPRMC appendString:@","]; // 地磁気の偏角: 不使用
    [nmea0183GPRMC appendString:@","]; // 地磁気の偏角の方向: 不使用
    [nmea0183GPRMC appendString:@"A"]; // モード: 単独測位
    unichar nmea0183GPRMCChecksum = 0;
    for (NSInteger index = 0; index < nmea0183GPRMC.length; index++) {
        nmea0183GPRMCChecksum ^= [nmea0183GPRMC characterAtIndex:index];
    }
    nmea0183GPRMCChecksum &= 0x0ff;
    [nmea0183GPRMC insertString:@"$" atIndex:0];
    [nmea0183GPRMC appendString:@"*"];
    [nmea0183GPRMC appendFormat:@"%02lX\n", (long)nmea0183GPRMCChecksum]; // チェックサム
    
    // カメラに位置情報を設定します。
    return @[nmea0183GPGGA, nmea0183GPRMC];
}

- (NSString *)nmeaChecksum:(NSString *)sentence {
    unichar nmea0183GPRMCChecksum = 0;
    
    for (NSInteger index = 0; index < sentence.length; index++) {
        nmea0183GPRMCChecksum ^= [sentence characterAtIndex:index];
    }
    nmea0183GPRMCChecksum &= 0x0ff;
    
    NSString *check = [NSString stringWithFormat:@"$%@*%02lX\n", sentence, (long)nmea0183GPRMCChecksum];
    return check;
}

- (double)convertCLLocationDegreesToNmea:(CLLocationDegrees)degrees {
    double degreeSign = ((degrees > 0.0) ? +1 : ((degrees < 0.0) ? -1 : 0));
    double degree = ABS(degrees);
    double degreeDecimal = floor(degree);
    double degreeFraction = degree - degreeDecimal;
    double minutes = degreeFraction * 60.0;
    double nmea = degreeSign * (degreeDecimal * 100.0 + minutes);
    return nmea;
}

- (bool)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class]]];

    static ArchiveUnzip *archive = [ArchiveUnzip new];

    __block BOOL unzip, locupdate, done;
    
    [archive startDecompression:^(NSError *error) {
        // Wait for decompression; LK8000 requires a proper data folders in order
        // to initialize properly; unfortunately SDL-iOS delegate (subclassed by this class)
        // does not provide an hook to call the "SDL main" on demand.
        NSLog(@"Decompression done: %@", error);
        unzip = YES;
        
        if (unzip && locupdate && !done) {
            done = YES;
            [super application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }];
    
    UIScreen *screen = [UIScreen mainScreen];
    self.uiWindow = [[UIWindow alloc]initWithFrame:screen.bounds];
    self.uiWindow.backgroundColor = [UIColor redColor];
    static UIViewController *uv = [[UIViewController alloc] init];
    uv.view.backgroundColor = [UIColor yellowColor];
    
    [self.uiWindow setRootViewController:uv];
    [self.uiWindow makeKeyAndVisible];

    
    [[LKCLHelper sharedInstance] requestLocationIfPossibleWithUI:YES
                                                           block:^bool(LKCLHelperStatus status, CLLocation *location, CMAltitudeData *altitude) {
                                                               NSLog(@"%lu", (unsigned long)status);
                                                               locupdate = YES;
                                                               
                                                               if (unzip && locupdate && !done) {
                                                                   done = YES;
                                                                   [super application:application didFinishLaunchingWithOptions:launchOptions];
                                                                   return true;
                                                               }
                                                               
                                                               if (done) {
                                                                   [self sendLocation:location
                                                                             altitude:altitude];
                                                               }
                                                               return true;
                                                           }];
    return YES;
}

- (void)sendLocation:(CLLocation *)location altitude:(CMAltitudeData *)altitude {
    static char t[1024];
    
    if (location) {
        NSArray *nmeas = [self getGeolocationWithCoreLocation:location];
        for (NSString *nmea in nmeas) {
            NSLog(@"%@", nmea);
            const char *ct = [nmea UTF8String];
            strcpy(t, ct);
            NMEAParser::ParseNMEAString(0, t, &GPS_INFO);
        }
    }
    
    if (altitude) {
        NSString *nmea = [self nmeaChecksum:[NSString stringWithFormat:@"PGRMZ,%.4f,f", [altitude.pressure floatValue]]];
        NSLog(@"%@", nmea);
        const char *ct = [nmea UTF8String];
        strcpy(t, ct);
        NMEAParser::ParseNMEAString(0, t, &GPS_INFO);
    }
}

//#define DEBUG_INTEGRATION

- (void)applicationWillResignActive:(UIApplication *)application {
    // SDL parent class manage this
#ifndef DEBUG_INTEGRATION
    [super applicationWillResignActive:application];
#endif
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // SDL parent class manage this
#ifndef DEBUG_INTEGRATION
    [super applicationDidEnterBackground:application];
#endif
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // SDL parent class manage this
#ifndef DEBUG_INTEGRATION
    [super applicationWillEnterForeground:application];
#endif
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // SDL parent class manage this
#ifndef DEBUG_INTEGRATION
    [super applicationDidBecomeActive:application];
#endif
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // SDL parent class manage this
#ifndef DEBUG_INTEGRATION
    [super applicationWillTerminate:application];
#endif
}

@end

extern "C" {
    int SDL_main(int argc, char *argv[])
    {
        return LK8000_main(argc, argv);
    }
}
