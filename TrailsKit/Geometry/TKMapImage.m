//
//  TKMapImage.m
//  TrailsKit
//
//  Created by Mike Mertsock on 1/4/14.
//  Copyright (c) 2014 Esker Apps. All rights reserved.
//

#import "TKMapImage.h"
#import <UIKit/UIKit.h>

@interface TKNamedMapImage : TKMapImage
- (id)initWithImageName:(NSString *)imageName
           centerOffset:(CGPoint)centerOffset;
@property (readonly, nonatomic) NSString *imageName;
@end

@interface TKMapImage ()
- (id)initWithCenterOffset:(CGPoint)centerOffset;
@end

@implementation TKMapImage

+ (instancetype)mapImageNamed:(NSString *)imageName
{
    return [self mapImageNamed:imageName centerOffset:CGPointZero];
}

+ (instancetype)mapImageNamed:(NSString *)imageName
                 centerOffset:(CGPoint)centerOffset
{
    return [[TKNamedMapImage alloc] initWithImageName:imageName
                                         centerOffset:centerOffset];
}

- (id)initWithCenterOffset:(CGPoint)centerOffset
{
    if (self = [super init]) {
        _centerOffset = centerOffset;
    }
    return self;
}

@end

@implementation TKNamedMapImage

- (id)initWithImageName:(NSString *)imageName
           centerOffset:(CGPoint)centerOffset
{
    NSParameterAssert(imageName != nil);
    if (self = [super initWithCenterOffset:centerOffset]) {
        _imageName = [imageName copy];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<TKNamedMapImage: %@, (%f, %f)>",
            self.imageName, self.centerOffset.x, self.centerOffset.y];
}

- (UIImage *)image
{
    return [UIImage imageNamed:self.imageName];
}

@end
