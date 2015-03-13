//
//  CustomCellTableViewCell.m
//  Restaurants
//
//  Created by MACBOOK-MUM on 31/10/14.
//
//

#import "CustomCellTableViewCell.h"

@implementation CustomCellTableViewCell

@synthesize imgLogo;
@synthesize btnFavourites;

@synthesize lblCategories;
@synthesize lblLocationDetails;
@synthesize lblOffers;
@synthesize lblOutletName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];   
    // Configure the view for the selected state
}



@end
