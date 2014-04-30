#import "ViewController.h"

#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <GMSMapViewDelegate, CLLocationManagerDelegate>

@end

@implementation ViewController {
  CLLocationManager *m_locationManager;
  UIViewController *m_mapViewController;
  GMSMapView *m_mapView;
}

- (void)viewDidLoad
{
	NSLog(@"viewDidLoad");
	
	// Setup GMSMapView
	GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.658099222222
                                                          longitude:139.74135441667
                                                               zoom:16];
	CGRect mapRect = CGRectMake(0, 0, self.view.bounds.size.height / 2, self.view.bounds.size.width);
	m_mapView = [GMSMapView mapWithFrame:mapRect camera:camera];
	[self.view addSubview:m_mapView];
	m_mapView.delegate = self;

	// Start updating location
	m_locationManager = [[CLLocationManager alloc] init];
	m_locationManager.delegate = self;
	[m_locationManager startUpdatingLocation];

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
	// Update location
	CLLocationCoordinate2D location = [[locations lastObject] coordinate];
	[m_mapView animateToLocation:location];
	
	NSLog(@"Updated %f %f", location.longitude, location.latitude);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	// Error
	NSLog(@"Error: %@", error);
}

@end
