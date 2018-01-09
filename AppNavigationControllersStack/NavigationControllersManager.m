//
//  NavigationControllersManager.m
//  AppNavigationControllersStack
//
//  Created by Kobe Dai on 07/01/2018.
//  Copyright © 2018 daijing. All rights reserved.
//

#import "NavigationControllersManager.h"
#import "ActionsViewController.h"

@interface NavigationControllersManager ()

@property (nonatomic, strong, readwrite) NSMutableArray<UINavigationController *> *navigationControllers;
@property (nonatomic, strong, readwrite) UIViewController *currentViewController;

@end

@implementation NavigationControllersManager

+ (NavigationControllersManager *)sharedInstance {
    static NavigationControllersManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NavigationControllersManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push) name:@"PushViewControllerNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pop) name:@"PopViewControllerNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(present) name:@"PresentViewControllerNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentWithNavigationController) name:@"PresentViewControllerWithNavigationNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"DismissViewControllerNotification" object:nil];
        
        self.navigationControllers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)push {
    NSLog(@"before vc: %@", [[self currentViewController] description]);
    
    UINavigationController *currentNavigationController = self.navigationControllers.lastObject;
    if (currentNavigationController) {
        ActionsViewController *vc = [[ActionsViewController alloc] init];
        [currentNavigationController pushViewController:vc animated:YES];
    } else {
        NSLog(@"没有UINavigationController，不支持Push，请点击Present With Navigation");
    }
    
    NSLog(@"after vc: %@", [[self currentViewController] description]);
}

- (void)pop {
    NSLog(@"before vc: %@", [[self currentViewController] description]);
    
    UINavigationController *currentNavigationController = self.navigationControllers.lastObject;
    [currentNavigationController popViewControllerAnimated:YES];
    
    NSLog(@"after vc: %@", [[self currentViewController] description]);
}

- (void)present {
    NSLog(@"before vc: %@", [[self currentViewController] description]);
    
    ActionsViewController *vc = [[ActionsViewController alloc] init];
    UIViewController *currentViewController = [self currentViewController];
    [currentViewController presentViewController:vc animated:YES completion:nil];
    
    NSLog(@"after vc: %@", [[self currentViewController] description]);
}

- (void)presentWithNavigationController {
    NSLog(@"before vc: %@", [[self currentViewController] description]);
    
    ActionsViewController *vc = [[ActionsViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    if (navigationController) {
        UIViewController *currentViewController = [self currentViewController];
        [currentViewController presentViewController:navigationController animated:YES completion:nil];
        [self.navigationControllers addObject:navigationController];
    }
    
    NSLog(@"after vc: %@", [[self currentViewController] description]);
}

- (void)dismiss {
    NSLog(@"before vc: %@", [[self currentViewController] description]);
    
    UIViewController *currentViewController = [self currentViewController];
    if (currentViewController.navigationController && [self.navigationControllers containsObject:currentViewController.navigationController]) {
        [self.navigationControllers removeObject:currentViewController.navigationController];
    }
    [currentViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];  // could be UINavigationController
    
    NSLog(@"after vc: %@", [[self currentViewController] description]);
}

#pragma mark - <Private Methods>

- (UIViewController *)currentViewController {
    UINavigationController *currentNavigationController = self.navigationControllers.lastObject;
    UIViewController *currentViewController = currentNavigationController.viewControllers.lastObject;
    while (currentViewController.presentedViewController) {
        if (!currentViewController.presentedViewController.isBeingDismissed) {
            currentViewController = currentViewController.presentedViewController;
        } else {
            break;
        }
    }
    return currentViewController;
}

@end
