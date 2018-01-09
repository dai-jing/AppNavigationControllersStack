//
//  NavigationControllersManager.h
//  AppNavigationControllersStack
//
//  Created by Kobe Dai on 07/01/2018.
//  Copyright © 2018 daijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NavigationControllersManager : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<UINavigationController *> *navigationControllers;
@property (nonatomic, strong, readonly) UIViewController *currentViewController;

+ (NavigationControllersManager *)sharedInstance;

@end
