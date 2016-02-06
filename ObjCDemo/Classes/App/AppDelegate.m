//
//  AppDelegate.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "AppDelegate.h"

#import "FeedViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setWindow:[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]];
    [self.window setRootViewController:[FeedViewController sharedInstance]];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
