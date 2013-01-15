//
//  TKShapeStyle.h
//  GPXTest
//
//  Created by Mike Mertsock on 1/6/13.
//  Copyright (c) 2013 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class UIColor;

@interface TKShapeStyle : NSObject

@property (nonatomic) UIColor* strokeColor;
@property (nonatomic) CGFloat lineWidth;

@end
