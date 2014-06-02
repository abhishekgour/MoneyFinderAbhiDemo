//
//  MainScreen.h
//  MoneyFinderDemo
//
//  Created by Abhishek Gour on 31/05/14.
//  Copyright (c) 2014 Abhishek Gour. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainScreen : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIView *scrollView;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollMain;
@property (strong, nonatomic) IBOutlet UIView *viewMagnifier;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIImageView *imageMoney;



@end
