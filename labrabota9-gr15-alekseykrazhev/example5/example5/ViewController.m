//
//  ViewController.m
//  example5
//
//  Created by Кражевский Алексей И. on 6/6/22.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()
{
    int isCity;
    MKPointAnnotation *annotationFrom;
    MKPointAnnotation *annotationTo;
}
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UITextField *cityFrom;
@property (weak, nonatomic) IBOutlet UITextField *cityTo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.map addGestureRecognizer:longPressGesture];
    
}

- (IBAction)showFlights:(id)sender {
    /*FlightsViewController *flights =[[FlithsViewController
                                     alloc]initWithBothCity:self.textFrom.text :self.textTo.text];
    [self presentViewController:flights animated:YES completion:nil];*/
}


-(void)setAnnotationToMap:(int)type : (NSString *)title : (CLLocationCoordinate2D)coordinate {
if (type == 0) {
[self.map removeAnnotation:annotationFrom];
    annotationFrom = [[MKPointAnnotation alloc] init];
    annotationFrom.title = title; annotationFrom.coordinate = coordinate;
[self.map addAnnotation:annotationFrom];
    self.cityFrom.text = title;
}
}

-(void)textFieldDidBeginEditing:(UITextField * )textField {
    if (textField == self.cityFrom)
        isCity = 0;
    else if (textField == self.cityTo)
        isCity = 1;
    [textField resignFirstResponder];
}


-(void)handleLongPressGesture:(UIGestureRecognizer*)sender { if (sender.state == UIGestureRecognizerStateEnded) {
CGPoint point = [sender locationInView:self.map];
CLGeocoder *geocoder = [[CLGeocoder alloc] init];
CLLocationCoordinate2D coord = [self.map convertPoint:point toCoordinateFromView:self.map];
CLLocation *location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
[geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
if (error) {
NSLog(@"Geocode failed with error: %@", error);
    return;
}
            for (CLPlacemark * placemark in placemarks) {
                [self setAnnotationToMap:self->isCity :placemark.locality:coord];
} }];
}

    
    
}


@end
