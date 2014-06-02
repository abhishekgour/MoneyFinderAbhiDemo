//
//  MainScreen.m
//  MoneyFinderDemo
//
//  Created by Abhishek Gour on 31/05/14.
//  Copyright (c) 2014 Abhishek Gour. All rights reserved.
//

#import "MainScreen.h"
#import "AppDelegate.h"


@interface MainScreen ()
{

    NSTimer *timer;
    UIAlertView *alert;
    BOOL alertshowing;
}
@property (nonatomic, retain) NSTimer *touchTimer;
- (void)addMagnifyingGlassAtPoint:(CGPoint)point;
- (void)removeMagnifyingGlass;
- (void)updateMagnifyingGlassAtPoint:(CGPoint)point;

@end

@implementation MainScreen



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
  //
    
//    
    // Do any additional setup after loading the view from its nib.
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
   
}
-(void)viewWillAppear:(BOOL)animated
{
    alertshowing=NO;
    [self.scrollMain setContentSize:CGSizeMake(0, self.scrollView.frame.size.height+600)];
       //[[AppDelegate appDelegate].window addSubview:self.viewMagnifier];
    [self.view addSubview:self.viewMagnifier];
    
    
    [self.viewMagnifier setFrame:CGRectMake(320-150-20, 568-20-100, 150, 100)];
    
	UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(viewDragged:)];
	[self.viewMagnifier addGestureRecognizer:gesture];
	
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0)
                                             target:self
                                           selector:@selector(onTimer)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)onTimer {
    int x_coord = arc4random() % 321; //Random number from 0-320
    int y_coord = arc4random() % 1150; //Random number from 0-480
    
    CGRect newframe = [self.imageMoney frame];
    newframe.origin.x = x_coord;
    newframe.origin.y = y_coord;
    self.imageMoney.frame = newframe;
    
//    NSLog(@"%@",self.imageMoney);
}

- (void)viewDragged:(UIPanGestureRecognizer *)gesture
{
	UIView *view = (UIView *)gesture.view;
	CGPoint translation = [gesture translationInView:view];
    
	// move label
	view.center = CGPointMake(view.center.x + translation.x,
                               view.center.y + translation.y);
    
	// reset translation
	[gesture setTranslation:CGPointZero inView:view];
    
   
  
  [self.img setImage:[self captureView:self.scrollView]];
    //    self.scrollMain
}



- (UIImage*)captureView:(UIView *)yourView {
//    CGRect rect = self.scrollView.frame;
    UIGraphicsBeginImageContext(CGSizeMake(320, 1150));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [yourView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect clippedRect  = CGRectMake(self.viewMagnifier.frame.origin.x, self.viewMagnifier.frame.origin.y-self.scrollView.frame.origin.y, self.viewMagnifier.frame.size.width, self.viewMagnifier.frame.size.height);
    
    CGPoint p=self.imageMoney.center;
    
    BOOL contains=CGRectContainsPoint(clippedRect, p);
    
    if(contains)
    {
        if(!alertshowing)
        {
        alertshowing=YES;
        alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Yeppy u got the money!!!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        }
    
    }
    else NSLog(@"no");
    //This will print yes because p is inside rect b
    
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
    UIImage *newImage   = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return newImage;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.scrollView setFrame:CGRectMake(0, -self.scrollMain.contentOffset.y, 320, self.scrollView.frame.size.height)];
    [self.img setImage:[self captureView:self.scrollView]];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  [self.scrollView setFrame:CGRectMake(0, -self.scrollMain.contentOffset.y, 320, self.scrollView.frame.size.height)];
  [self.img setImage:[self captureView:self.scrollView]];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  [self.scrollView setFrame:CGRectMake(0, -self.scrollMain.contentOffset.y, 320, self.scrollView.frame.size.height)];
    [self.img setImage:[self captureView:self.scrollView]];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
  [self.scrollView setFrame:CGRectMake(0, -self.scrollMain.contentOffset.y, 320, self.scrollView.frame.size.height)];
    [self.img setImage:[self captureView:self.scrollView]];
}

/*

//jkldhfjkbjdsfjhdjsbfghjbdshvghfdhjfbdfhfbhdbfghbxdsfhbdxhbfhbfhb

#pragma mark - touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:magnifyingGlassShowDelay
													   target:self
													 selector:@selector(addMagnifyingGlassTimer:)
													 userInfo:[NSValue valueWithCGPoint:[touch locationInView:self]]
													  repeats:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	[self updateMagnifyingGlassAtPoint:[touch locationInView:self]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.touchTimer invalidate];
	self.touchTimer = nil;
	[self removeMagnifyingGlass];
}

#pragma mark - private functions

- (void)addMagnifyingGlassTimer:(NSTimer*)timer {
	NSValue *v = timer.userInfo;
	CGPoint point = [v CGPointValue];
	[self addMagnifyingGlassAtPoint:point];
}

#pragma mark - magnifier functions

- (void)addMagnifyingGlassAtPoint:(CGPoint)point {
	
	if (!magnifyingGlass) {
		magnifyingGlass = [[ACMagnifyingGlass alloc] init];
	}
	
	if (!magnifyingGlass.viewToMagnify) {
		magnifyingGlass.viewToMagnify = self;
		
	}
	
	magnifyingGlass.touchPoint = point;
	[[AppDelegate appDelegate].window addSubview:magnifyingGlass];
	[magnifyingGlass setNeedsDisplay];
}

- (void)removeMagnifyingGlass {
	[magnifyingGlass removeFromSuperview];
}

- (void)updateMagnifyingGlassAtPoint:(CGPoint)point {
	magnifyingGlass.touchPoint = point;
	[magnifyingGlass setNeedsDisplay];
}
*/
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    alertshowing=NO;
}
@end
