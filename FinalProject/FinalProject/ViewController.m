//
//  ViewController.m
//  FinalProject
//
//  Created by Jamie Cohen on 4/27/17.
//  Copyright © 2017 Jamie Cohen. All rights reserved.
//

#import "ViewController.h"
#define METERS_PER_MILE 1609.344
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize network connection when opening
    [self initNetworkCommunication];

    //initialize mapview
    _mapView.showsUserLocation=YES;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
}


//creates reading and writing streams to connect to a TCP server
- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    //pairs with socket -- listening on port 21
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 21, &readStream, &writeStream);
   
    //creates io streams with socket
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (NSOutputStream *)CFBridgingRelease(writeStream);
    
    //use current class as NSSstream delegate
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    
    //keeps connection open and loops to continually read/write
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    //opens connection
    [inputStream open];
    [outputStream open];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    // sets location to vanderbilt university
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 36.1447;
    zoomLocation.longitude= -86.8027;

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"My Location";
    
    [self.mapView addAnnotation:point];
}

//sends location and name
- (IBAction)joinChat:(id)sender {
    
    //sends name to sever
    NSString *response  = [NSString stringWithFormat:@"iam:%@", _inputNameField.text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
   
    //gets and formats location
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
    NSString *strLat = [NSString stringWithFormat:@"%f", latitude];
    NSString *strLong = [NSString stringWithFormat:@"%f", longitude];
    NSString *currentLat =[NSString stringWithFormat:@"Latitude:%@", strLat];
    NSString *currentLong =[NSString stringWithFormat:@"Longitude:%@", strLong];
    NSString *currentLocation = [NSString stringWithFormat:@"%@,%@", currentLat, currentLong];
    
    //sends location to server
    NSString *responseLocation  = [NSString stringWithFormat:@"loc:%@", currentLocation];
    NSData *location = [[NSData alloc] initWithData:[responseLocation dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[location bytes] maxLength:[location length]];
    
    //sets labels to current location
    self.latLabel.text = strLat;
    self.longLabel.text = strLong;

    
    //switches view to location view
    [self.view bringSubviewToFront:_locatioView];
    

}

    //returns user to initial joinView
- (IBAction)sendAgain:(id)sender {
    
    
    //returns to joinview screen
    [self.view bringSubviewToFront:_joinView];
}
@end
