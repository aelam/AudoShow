//
//  RWAnimationTabBarController.m
//  AutoShow
//
//  Created by Ryan Wang on 13-4-14.
//  Copyright (c) 2013年 Ryan Wang. All rights reserved.
//

#import "RWAnimationTabBarController.h"
#import <QuartzCore/QuartzCore.h>

@interface RWAnimationTabBarController ()

@end

@implementation RWAnimationTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    
//    CATransition *animation = [CATransition animation];
//    [animation setType:kCATransitionFade];
//    [animation setDuration:0.25];
////    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
////                                  kCAMediaTimingFunctionEaseIn]];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
//                                  kCAMediaTimingFunctionLinear]];
////    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
////                                  kCAMediaTimingFunctionEaseIn]];
////    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
////                                  kCAMediaTimingFunctionEaseIn]];
//    [self.view.window.layer addAnimation:animation forKey:@"fadeTransition"];
////}
//    return;
    
    
    NSInteger oldIndex = self.selectedIndex;
    
    if (oldIndex == selectedIndex) {
        return;
    }
   
    
    UIView * fromView = self.selectedViewController.view;
    UIView * toView = [[self.viewControllers objectAtIndex:selectedIndex] view];
#if 0
    // Transition using a page curl.
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.5
                       options:(selectedIndex > oldIndex ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight)
                    completion:^(BOOL finished) {
                        if (finished) {
                            [super setSelectedIndex:selectedIndex];
                        }
                    }];
    

    
    
#else
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    // Get the size of the view area.
    CGRect viewSize = fromView.frame;
    BOOL scrollRight = selectedIndex > oldIndex;
    
    // Add the to view to the tab bar view.
    [fromView.superview addSubview:toView];
    
    // Position it off screen.
    toView.frame = CGRectMake((scrollRight ? width : -width), viewSize.origin.y, width, viewSize.size.height);
    
    [UIView animateWithDuration:0.3
                     animations: ^{
                         
                         // Animate the views on and off the screen. This will appear to slide.
                         fromView.frame =CGRectMake((scrollRight ? -width : width), viewSize.origin.y, width, viewSize.size.height);
                         toView.frame =CGRectMake(0, viewSize.origin.y, width, viewSize.size.height);
                     }
     
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             // Remove the old view from the tabbar view.
                             [fromView removeFromSuperview];
                             [super setSelectedIndex:selectedIndex];
                         }
                     }];
#endif
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    NSArray *tabViewControllers = tabBarController.viewControllers;
    UIView * fromView = tabBarController.selectedViewController.view;
    UIView * toView = viewController.view;
    if (fromView == toView)
        return NO;
    NSUInteger fromIndex = [tabViewControllers indexOfObject:tabBarController.selectedViewController];
    NSUInteger toIndex = [tabViewControllers indexOfObject:viewController];
    
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.3
                       options: toIndex > fromIndex ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL finished) {
                        if (finished) {
                            tabBarController.selectedIndex = toIndex;
                        }
                    }];
    return true;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
