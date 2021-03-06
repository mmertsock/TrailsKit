//
//  TKShapeStyle.h
//  GPXTest
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <MapKit/MapKit.h>

@class UIColor;

@interface TKShapeStyle : NSObject

@property (copy, nonatomic) UIColor* strokeColor;
@property (nonatomic) CGFloat lineWidth;
@property (copy, nonatomic) UIColor* fillColor;
@property (nonatomic) MKOverlayLevel overlayLevel;
@property (copy, nonatomic) NSArray *lineDashPattern;
@property (nonatomic) CGFloat lineDashPhase;

- (id)initWithStrokeColor:(UIColor *)strokeColor
                lineWidth:(CGFloat)lineWidth
                fillColor:(UIColor *)fillColor
             overlayLevel:(MKOverlayLevel)overlayLevel
          lineDashPattern:(NSArray *)lineDashPattern
            lineDashPhase:(CGFloat)lineDashPhase;

@end
