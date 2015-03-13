//
//  CustomCellTableViewCell.h
//  Restaurants
//
//  Created by MACBOOK-MUM on 31/10/14.
//
//

#import <UIKit/UIKit.h>

@interface CustomCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UIButton *btnFavourites;

@property (strong, nonatomic) IBOutlet UILabel *lblOutletName;
@property (strong, nonatomic) IBOutlet UILabel *lblCategories;
@property (strong, nonatomic) IBOutlet UILabel *lblOffers;
@property (strong, nonatomic) IBOutlet UILabel *lblLocationDetails;

@end
