//
//  ViewController.h
//  RestaurantApp
//
//  Created by MACBOOK-MUM on 31/10/14.
//
//

#import <UIKit/UIKit.h>
#import "CustomCellTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate> {
    
    NSString* documentsDirectoryPath;
    NSFileManager *fileManager;
    
    CLLocation *startLocation;
    CLLocation *endLocation;
}

@property BOOL flagFavourite;
@property (nonatomic,strong)IBOutlet UITableView *objTableView;

@property (nonatomic,strong) NSDictionary *taskValues;
@property (nonatomic,strong) NSDictionary *taskDataValues;
@property (strong, nonatomic) CLLocationManager *locationManager;

-(IBAction)btnFavouriteClicked:(id)sender;

@end

