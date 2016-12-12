//
//  AppDelegate.m
//  Gigya-iOS-Demos
//
//  Created by Jay Reardon & Giovanni Alvarez on 12/22/14.
//  Copyright (c) 2014 Gigya. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GigyaSDK/Gigya.h>


@interface AppDelegate () <GSAccountsDelegate, UIApplicationDelegate>
- (void)alertForView:(UIViewController *)view title:(NSString*)ttl message:(NSString*)msg button:(NSString*)btn;
@end

@implementation AppDelegate

static NSString * const kClientId = @"224059159380-llqo0j946bbl3s4rqu35kkolpmhpl07h.apps.googleusercontent.com";

- (void)alertForView:(UIViewController *)view title:(NSString*)ttl message:(NSString*)msg button:(NSString*)btn {
    __block UIAlertController *alert;
    __block UIAlertAction *alertAction;
    alert = [UIAlertController alertControllerWithTitle:ttl
                                                message:msg
                                         preferredStyle: UIAlertControllerStyleAlert];
    alertAction = [UIAlertAction actionWithTitle:btn
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action) {
                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                         }
                   ];
    [alert addAction:alertAction];
    [view presentViewController:alert animated:YES completion:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Gigya initWithAPIKey:@"3_E-CkgscpWW1NpFm51u5E-dvV52erQFpRuTi0-zsDYkK3qcMqQoZmc52cLUC7BsW8" application:application launchOptions:launchOptions];
    
    [Gigya setAccountsDelegate:self];
    
    return YES;
}

- (void)accountDidLogin:(GSAccount *)account {
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.rootViewController = [[UIViewController alloc] init];
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow makeKeyAndVisible];
    [self alertForView:alertWindow.rootViewController title:@"Gigya Login" message:@"Success!" button:@"OK"];
}

- (void)accountDidLogout {
    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alertWindow.rootViewController = [[UIViewController alloc] init];
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    [alertWindow makeKeyAndVisible];
    [self alertForView:alertWindow.rootViewController title:@"Gigya Logout" message:@"Success!" button:@"OK"];
    }

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    // Logs 'install' and 'app activate' App Events.
    [Gigya handleDidBecomeActive];
    //[FBAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [Gigya handleOpenURL:url application:application sourceApplication:sourceApplication annotation:annotation];
}

@end
