//
//  AppDelegate.h
//  MoneyFinderDemo
//
//  Created by Abhishek Gour on 31/05/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>
+(AppDelegate *)appDelegate;
@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UINavigationController *nvcontroller;

@end
