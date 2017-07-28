//
//  AlmaZBarReaderViewController.m
//  BarCodeMix
//
//  Created by eCompliance on 23/01/15.
//
//

#import "AlmaZBarReaderViewController.h"
#import "CsZbar.h"

@interface AlmaZBarReaderViewController ()

@end

@implementation AlmaZBarReaderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self styleNavBar];
}

- (UIColor *)getUIColorObjectFromHexString:(NSString *)hexStr alpha:(CGFloat)alpha
{
  // Convert hex string to an integer
  unsigned int hexint = [self intFromHexString:hexStr];

  // Create color object, specifying alpha as well
  UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
    blue:((CGFloat) (hexint & 0xFF))/255
    alpha:alpha];

  return color;
}

- (unsigned int)intFromHexString:(NSString *)hexStr
{
  unsigned int hexInt = 0;

  // Create scanner
  NSScanner *scanner = [NSScanner scannerWithString:hexStr];

  // Tell scanner to skip the # character
  [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];

  // Scan hex value
  [scanner scanHexInt:&hexInt];

  return hexInt;
}

- (void)styleNavBar {
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    //Draw Bar
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 64.0)];
    
    // TODO Take color from variable
    // NSDictionary *params = (NSDictionary*) [command argumentAtIndex:0];
    // NSString *headerColor = [params objectForKey:@"header_color"];
    // [newNavBar setBarTintColor:[UIColor getUIColorObjectFromHexString:headerColor alpha:1]];
    [newNavBar setBarTintColor:[UIColor colorWithRed:0.11 green:0.37 blue:0.49 alpha:1.0]];    

    [newNavBar setTranslucent: NO];
    
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:[self title] ];

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(cancel)];
    
    title.rightBarButtonItem = cancelButton;
    [newNavBar setItems:@[title]];
    
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor], NSForegroundColorAttributeName,
                                [UIFont fontWithName:@"TrebuchetMS" size:19.0], NSFontAttributeName,
                                nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes: attributes];
    [newNavBar setTitleTextAttributes: attributes];
    
    [cancelButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                           [UIFont fontWithName:@"TrebuchetMS" size:16.0], NSFontAttributeName,
                                           nil]
                              forState:UIControlStateNormal];
    
    [self.view addSubview:newNavBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    //Draw Sight
    if ([self drawSight])
    {
        CGFloat xDim = screenWidth - 64.0;
        UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake(0, 64.0, screenHeight, xDim)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (xDim / 2), screenHeight, 1)];
        lineView.backgroundColor = [UIColor redColor];
        [polygonView addSubview:lineView];
    
        self.cameraOverlayView = polygonView;
    }

    if (![[self preferredOrientation] isEqualToString:(@"portrait")])
    {
        //Tunning for long bar codes
        self.readerView.showsFPS = false;
        self.readerView.zoom = 1.0;
        self.readerView.scanCrop = CGRectMake(0, 0.3, 1, 0.4);
        self.readerView.tracksSymbols = YES;
    }
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self styleNavBar];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    //Draw Sight
    if ([self drawSight])
    {
        CGFloat xDim = screenHeight - 64.0;
        UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake(0, 64.0, screenWidth, xDim)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (xDim / 2), screenWidth, 1)];
        lineView.backgroundColor = [UIColor redColor];
        [polygonView addSubview:lineView];
    
        self.cameraOverlayView = polygonView;
    }
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)buttonPressed: (UIButton *) button
{
    CsZBar *obj = [[CsZBar alloc] init];
    [obj toggleflash];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if ([[self preferredOrientation] isEqualToString:(@"portrait")])
    {
        return UIInterfaceOrientationPortrait;
    }
    else
    {
        return UIInterfaceOrientationLandscapeRight;
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
