//
//  AppDelegate.h
//  Restaurants
//
//  Created by MACBOOK-MUM on 30/10/14.
//
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    ViewController *objViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)UINavigationController *objNavigationController;

@end

