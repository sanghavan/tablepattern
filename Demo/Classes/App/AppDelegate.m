//
//  AppDelegate.m
//  ObjCDemo
//
//  Created by materik on 10/02/16.
//
//

#import "AppDelegate.h"

#import "FeedViewController.h"
#import <TablePattern/TablePattern.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setWindow:[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]];
    [self.window setRootViewController:[[UINavigationController alloc]
                                           initWithRootViewController:[FeedViewController sharedInstance]]];
    [self.window makeKeyAndVisible];

    [TableViewDataSource setLoadingIndicatorColor:[UIColor yellowColor]];
    [TableViewDataSource setLoadingIndicatorPadding:15.0f];
    [TableViewDataSource setLoadingIndicatorSize:0.8f];

    return YES;
}

@end
