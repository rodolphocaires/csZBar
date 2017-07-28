//
//  AlmaZBarReaderViewController.h
//  BarCodeMix
//
//  Created by eCompliance on 23/01/15.
//
//

#import "ZBarReaderViewController.h"

@interface AlmaZBarReaderViewController : ZBarReaderViewController

@property (nonatomic) BOOL drawSight;
@property (nonatomic) NSString* preferredOrientation;
@property (nonatomic) UIColor* headerColor;

@end
