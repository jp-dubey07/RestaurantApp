//
//  ViewController.m
//  RestaurantApp
//
//  Created by MACBOOK-MUM on 31/10/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize objTableView;
@synthesize taskValues;
@synthesize taskDataValues;
@synthesize flagFavourite;
@synthesize locationManager;

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.taskValues = [[NSDictionary alloc] init];
    self.taskDataValues = [[NSDictionary alloc] init];
    self.flagFavourite = FALSE;
    
    self.navigationItem.title = @"Restaurants";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Filter"] style:UIBarButtonItemStylePlain target:self action:@selector(filterAction:)];
    
    //Read content from file
    NSString* path = [[NSBundle mainBundle] pathForResource:@"task_data" ofType:@"txt"];
    
    NSString* content = [NSString stringWithContentsOfFile:path
                                encoding:NSUTF8StringEncoding error:NULL];
    
    //NSLog(@"content file : %@ ",content);
    NSData* data = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    //Parse the content of file in JSON format
    self.taskValues = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (!error) {
        // NSLog(@"json : %@",[taskValues description]);
        self.taskDataValues = [taskValues objectForKey:@"data"];
        // NSLog(@"json : %@",[self.taskDataValues description]);
    }
    else {
        NSLog(@"NSDictionary error");
    }

    NSMutableArray *urlStrings = [[NSMutableArray alloc] init];
    
    //Fetch image URLs and store in array
    for (int i=0; i<[self.taskDataValues count]; i++) {
        
        [urlStrings addObject:[NSString stringWithFormat:@"%@",[[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%d",i]] valueForKey:@"LogoURL"]]];        
    }
    
   // NSLog(@"urlStrings : %@ ",[urlStrings description]);
    
    int i = 0;
    for (NSString *urlString in urlStrings) { // Store images in local directory
         
    documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
    NSString *imgName = [NSString stringWithFormat:@"%d",i];
    
    fileManager = [NSFileManager defaultManager];
    NSString *writablePath = [documentsDirectoryPath stringByAppendingPathComponent:imgName];
    
    if(![fileManager fileExistsAtPath:writablePath]){ // file doesn't exist
        
        //save Image From URL
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString: urlString]];
        
        NSError *error = nil;
        [data writeToFile:[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imgName]] options:NSAtomicWrite error:&error];
        
        if (error) {
            NSLog(@"Error Writing File : %@",error);
        }else{
            // NSLog(@"Image %@ Saved SuccessFully",imgName);
           // NSLog(@"Location : %@ ",[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imgName]]);
            
            i++;
        }
    }
    else{
        // file exist
        NSLog(@"file exist");
    }
        
    }
    
    
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLHeadingFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
    [locationManager startUpdatingLocation];
    
    //Consider current location as Andheri
    startLocation = [[CLLocation alloc] initWithLatitude:19.1190 longitude:72.8470];
    
}

#pragma mark - filterAction
-(void)filterAction:(UIBarButtonItem *)sender{
    NSLog(@"filterAction invoked");
    //perform filter action
}

#pragma mark - btnFavouriteClicked
-(IBAction)btnFavouriteClicked:(id)sender {
    // NSLog(@"btnFavouriteClicked");
    
    UIButton *btnSender = (id)sender;
    
    if (self.flagFavourite) {
        NSLog(@"Unselect favourite");
        self.flagFavourite = FALSE;
        
        [btnSender setBackgroundImage:[UIImage imageNamed:@"Favourite"] forState:UIControlStateNormal];
    }
    else {
        NSLog(@"Select favourite");
        self.flagFavourite = TRUE;
        
        [btnSender setBackgroundImage:[UIImage imageNamed:@"FavouriteSelected"] forState:UIControlStateNormal];
    }
}

#pragma mark - tableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //Create a custom view with label and image
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    UIButton *btnImage = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, 40, 35)];
    [btnImage setBackgroundImage:[UIImage imageNamed:@"CurrentLocation"] forState:UIControlStateNormal];
        
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 200, 40)];
    label.tag = 0;
    label.textColor = [UIColor redColor];
    label.textColor = [UIColor greenColor];
    label.textColor = [UIColor blueColor];
    label.textColor = [UIColor yellowColor];
    //label.backgroundColor = [UIColor clearColor];
    
    //NSLog(@"Values test : %@ ",[[self.taskDataValues valueForKey:@"0"] valueForKey:@"NeighbourhoodName"]);
    
    label.text = [[self.taskDataValues valueForKey:@"0"] valueForKey:@"NeighbourhoodName"];
    
    [customView addSubview:btnImage];
    [customView addSubview:label];
    
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    
    return customView;
}

#pragma - tableView datasource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Perform row selection operation
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // NSLog(@"numberOfRowsInSection : %lu",(unsigned long)[self.taskDataValues count]);
    return [self.taskDataValues count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // NSLog(@"cellForRowAtIndexPath");
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    //Create a custom cell
    CustomCellTableViewCell *cell = (CustomCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
   // NSLog(@"Record : %@ ",[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%d",[indexPath row]]]);
    
    //Filter dictionary for categories
    NSMutableArray *categoryList = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[[[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%ld",(long)[indexPath row]]] valueForKey:@"Categories"] count];i++) {
        
       // NSLog(@"Categories Name : %@ ",[[[[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%d",[indexPath row]]] valueForKey:@"Categories"] objectAtIndex:i] valueForKey:@"Name"]);
        
        [categoryList addObject:[[[[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%ld",(long)[indexPath row]]] valueForKey:@"Categories"] objectAtIndex:i] valueForKey:@"Name"]];
    }
    
    // NSLog(@"categoryList : %@ ",[categoryList description]);
    
    NSMutableString *categoryValues = [[NSMutableString alloc] init];
    
    for (NSString *value in categoryList) {
        [categoryValues appendString:[NSString stringWithFormat:@"%@%@",@" *",value]];
    }
    
   // NSLog(@"categoryValues : %@ ",categoryValues);
    cell.lblCategories.text = categoryValues;
    
   //Filter dictionary for Brandname
    cell.lblOutletName.text = [[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%ld",(long)[indexPath row]]] valueForKey:@"BrandName"];
    
    cell.lblOffers.text = [NSString stringWithFormat:@"%@%@",[[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%ld",(long)[indexPath row]]] valueForKey:@"NumCoupons"],@"  Offers"];
    
    
    endLocation = [[CLLocation alloc] initWithLatitude:[[[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%ld",(long)[indexPath row]]] valueForKey:@"Latitude"]doubleValue] longitude:[[[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%ld",(long)[indexPath row]]] valueForKey:@"Longitude"]doubleValue]];
    
    //Determine distance from current location to destination
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation]; // aka double
    //NSLog(@"endLocation : %@ distance : %f : %ld",endLocation.description,distance,lroundf(distance/1000));
    
    cell.lblLocationDetails.text = [NSString stringWithFormat:@"%ld%@%@",lroundf(distance),@" meters   ",[[self.taskDataValues valueForKey:[NSString stringWithFormat:@"%ld",(long)[indexPath row]]] valueForKey:@"NeighbourhoodName"]];
    
    //Fetch image from local directory and assign it
    NSString *imgLocation = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.png", (long)[indexPath row]]];
    
    UIImage *imgResize = [UIImage imageNamed:imgLocation];
    
    cell.imgLogo.contentMode = UIViewContentModeScaleAspectFit;
    cell.imgLogo.clipsToBounds = YES;
    [cell.imgLogo setImage:imgResize];
           
    // cell.imgLogo.image = [UIImage imageNamed:@"Test"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
