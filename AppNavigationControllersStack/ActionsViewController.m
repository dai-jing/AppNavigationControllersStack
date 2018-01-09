//
//  ActionsViewController.m
//  AppNavigationControllersStack
//
//  Created by Kobe Dai on 03/01/2018.
//  Copyright © 2018 daijing. All rights reserved.
//

#import "ActionsViewController.h"
#import "NavigationControllersManager.h"

@interface ActionsViewController ()

@end

@implementation ActionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *pushButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 30)];
    [pushButton setTitle:@"Push" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushButton.titleLabel setFont:[UIFont systemFontOfSize:12.f weight:UIFontWeightRegular]];
    [pushButton addTarget:self action:@selector(pushButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
    UIButton *presentButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 150, 30)];
    [presentButton setTitle:@"Present" forState:UIControlStateNormal];
    [presentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [presentButton.titleLabel setFont:[UIFont systemFontOfSize:12.f weight:UIFontWeightRegular]];
    [presentButton addTarget:self action:@selector(presentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];
    
    UIButton *presentNaviButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 150, 30)];
    [presentNaviButton setTitle:@"Present With Navigation" forState:UIControlStateNormal];
    [presentNaviButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [presentNaviButton.titleLabel setFont:[UIFont systemFontOfSize:12.f weight:UIFontWeightRegular]];
    [presentNaviButton addTarget:self action:@selector(presentNaviButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentNaviButton];
    
    UIButton *dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 150, 30)];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dismissButton.titleLabel setFont:[UIFont systemFontOfSize:12.f weight:UIFontWeightRegular]];
    [dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    UILabel *vcLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 300, 300, 30)];
    vcLabel.text = [NSString stringWithFormat:@"vc: %@", [self description]];
    vcLabel.textColor = [UIColor blackColor];
    vcLabel.font = [UIFont systemFontOfSize:12.f weight:UIFontWeightRegular];
    vcLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:vcLabel];
    
    if ([self.navigationController.viewControllers count] > 1) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked)];
        self.navigationItem.leftBarButtonItem = backButton;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)pushButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushViewControllerNotification" object:nil];
}

- (void)backButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PopViewControllerNotification" object:nil];
}

- (void)presentButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PresentViewControllerNotification" object:nil];
}

- (void)presentNaviButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PresentViewControllerWithNavigationNotification" object:nil];
}

- (void)dismissButtonClicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DismissViewControllerNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
