//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Jun  3 2014 10:55:11).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "CALayer.h"

#import "NSCopying.h"

@class ECStatusLabelDescription;

@interface ECStatusLabelLayer : CALayer <NSCopying>
{
    ECStatusLabelDescription *_labelDescription;
    struct CGRect _normalizedFrame;
    struct CGRect _lastLayoutFrame;
    double _size;
    float _scaleFactor;
    _Bool _hidden;
    CALayer *_imageLayer;
}

+ (void)initialize;
@property(nonatomic) float scaleFactor; // @synthesize scaleFactor=_scaleFactor;
@property(retain, nonatomic) ECStatusLabelDescription *labelDescription; // @synthesize labelDescription=_labelDescription;
- (void).cxx_destruct;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (void)_renderBadgeImage;
- (void)_createLayers;
- (void)layoutForFrame:(struct CGRect)arg1;
- (id)initWithMaxSize:(double)arg1 scaleFactor:(float)arg2;

@end
