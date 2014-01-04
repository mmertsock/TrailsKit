//
//  TKMapImage.h
//  TrailsKit
//
//  Created by Mike Mertsock on 1/4/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class UIImage;

// Lazy loading or procedural generation of images, and
// related config info. This is an immutable class cluster.
@interface TKMapImage : NSObject

+ (instancetype)mapImageNamed:(NSString *)imageName;
+ (instancetype)mapImageNamed:(NSString *)imageName
                 centerOffset:(CGPoint)centerOffset;

@property (readonly, nonatomic) UIImage *image;
@property (readonly, nonatomic) CGPoint centerOffset;

@end
