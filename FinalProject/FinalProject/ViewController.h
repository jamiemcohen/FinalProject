//
//  ViewController.h
//  FinalProject
//
//  Created by Jamie Cohen on 4/27/17.
//  Copyright © 2017 Jamie Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
NSInputStream *inputStream;
NSOutputStream *outputStream;
CLLocationManager *locationManager;


@interface ViewController : UIViewController

//joinView Property definitions
@property (weak, nonatomic) IBOutlet UITextField *inputNameField;
@property (weak, nonatomic) IBOutlet UIView *joinView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)joinChat:(id)sender;


//locationView property definitions
@property (weak, nonatomic) IBOutlet UIView *locatioView;
@property (weak, nonatomic) IBOutlet UILabel *longLabel;
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
- (IBAction)sendAgain:(id)sender;

@end

