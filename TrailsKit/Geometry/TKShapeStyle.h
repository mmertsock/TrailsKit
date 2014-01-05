//
//  TKShapeStyle.h
//  GPXTest
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class UIColor;

@interface TKShapeStyle : NSObject

@property (readonly, nonatomic) UIColor* strokeColor;
@property (readonly, nonatomic) CGFloat lineWidth;
@property (readonly, nonatomic) UIColor* fillColor;

- (id)initWithStrokeColor:(UIColor *)strokeColor
                lineWidth:(CGFloat)lineWidth
                fillColor:(UIColor *)fillColor;

@end
