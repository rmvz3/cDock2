//
//  cDockTile.m
//

#import "Preferences.h"
#import "ZKSwizzle.h"
@import AppKit;

extern NSInteger orient;
double orig = 999;
double orig2 = 999;

struct FloatRect
{
    float left;
    float top;
    float right;
    float bottom;
};

@interface Tile : NSObject
{
    unsigned int bouncing:1;
    struct CGRect fGlobalBounds;
}
- (void)setSelected:(BOOL)arg1;
- (void)setLabel:(id)arg1 stripAppSuffix:(_Bool)arg2;
@end

ZKSwizzleInterface(_CDTile, Tile, NSObject);
@implementation _CDTile

- (void)updateRect {
    ZKOrig(void);
//    ZKHookIvar(self, struct CGRect, "fGlobalBounds") = CGRectMake(1300, 1000, 50, 50);
//    NSLog(@"%@", NSStringFromRect(ZKHookIvar(self, CGRect, "fGlobalBounds")));
}

- (void)setGlobalFrame:(struct FloatRect)arg1 {
//    NSLog(@"%f", arg1.left);
//    NSLog(@"%f", arg1.right);
//    NSLog(@"%f", arg1.top);
//    NSLog(@"%f", arg1.bottom);
    
//    if (Prefs(currentStyle) == DKTheme3DStyle) {
//        CGFloat height = (CGFloat)labs((NSInteger)arg1.top - (NSInteger)arg1.bottom);
//        arg1.bottom -= height * 0.1;
//        arg1.top -= height * 0.1;
//    }
    
    ZKOrig(void, arg1);
}

//- (void)removeIndicator {
//    ZKOrig(void);
//}

//- (void)addIndicator {
//    ZKOrig(void);
//    
//    NSUInteger count;
//    Ivar *vars = class_copyIvarList([self.superclass class], &count);
//    for (NSUInteger i=0; i<count; i++) {
//        Ivar var = vars[i];
//        NSLog(@"%s %s", ivar_getName(var), ivar_getTypeEncoding(var));
//    }
//    free(vars);
//}

- (void)update {
    ZKOrig(void);
    
    int bounce = ZKHookIvar(self, int, "bouncing");
    int bstop = ZKHookIvar(self, int, "bounceStop");
    
    CALayer *_iconLayer = ZKHookIvar(self, CALayer *, "_layer");
    CALayer *_reflectionLayer = nil;
    
    // Check if our custom layer exists, if it does then reference it
    for (CALayer *item in (NSMutableArray *)_iconLayer.sublayers)
        if ([item.name  isEqual:@"_reflectionLayer"]) {
            _reflectionLayer = item;
            break;
        }
    
    CGRect frm = _reflectionLayer.frame;
    
    if (orig == 999)
    {
        if (orient == 0) {
            orig = _reflectionLayer.frame.origin.y;
            orig2 = _iconLayer.frame.origin.y;
        } else {
            orig = _reflectionLayer.frame.origin.x;
            orig2 = _iconLayer.frame.origin.x;
        }
    }
    
//    NSLog(@"%u", bounce);
//    NSLog(@"%u", bstop);
    
//    if (bounce == 103488 || bounce == 285250112 || bounce == 16814784)
    if (bounce != 0)
    {
        if (orient == 0) {
            frm.origin.y = orig - 2 * (_iconLayer.frame.origin.y - orig2);
        }
        if (orient == 1) {
            frm.origin.x = orig - 2 * (_iconLayer.frame.origin.x - orig2);
        }
        if (orient == 2) {
            frm.origin.x = orig - 2 * (_iconLayer.frame.origin.x - orig2);
        }
        [_reflectionLayer setFrame:frm];
    }
    
    if (bstop == 128 || bstop == 65666) {
        orig = 999;
        orig2 = 999;
        if (orient == 0) {
            frm.origin.y = (-frm.size.height);
        }
        if (orient == 1) {
            frm.origin.x = (-frm.size.width);
        }
        if (orient == 2) {
            frm.origin.x = (frm.size.width);
        }
        [_reflectionLayer setFrame:frm];
    }
}

- (void)labelAttached {
    ZKOrig(void);
    
    if (![[[Preferences sharedInstance2] objectForKey:@"cd_enabled"] boolValue])
        return;
    
    // DO NOT USE
    // 10.9 crash 10.10+ sometimes saves replacement to dock plist
    // either scenario sucks
    //    object_setInstanceVariable(self, "fLabel", @"");
    //    [(Tile*)self setLabel:@"" stripAppSuffix:false];
    
    if ([[[Preferences sharedInstance] objectForKey:@"cd_darkenMouseOver"] boolValue])
        [(Tile*)self setSelected:true];
}

- (void)labelDetached {
    ZKOrig(void);
    
    if (![[[Preferences sharedInstance2] objectForKey:@"cd_enabled"] boolValue])
        return;
    
    if ([[[Preferences sharedInstance] objectForKey:@"cd_darkenMouseOver"] boolValue])
        [(Tile*)self setSelected:false];
}
@end

ZKSwizzleInterface(_CDTileLayer, DOCKTileLayer, CALayer)
@implementation _CDTileLayer

- (void)createShadowAndReflectionLayers {
    return;
    // DO NOTHING
}

- (void)layoutSublayers {
    ZKOrig(void);
    
    if (![[[Preferences sharedInstance2] objectForKey:@"cd_enabled"] boolValue])
        return;
    
//    NSLog(@"%ld", (long)orient);
//    NSLog(@"%ld", (long)self.frame.size.height);
    
    if ([[[Preferences sharedInstance] objectForKey:@"cd_iconShadow"] boolValue]) {
        float red = [[[Preferences sharedInstance] objectForKey:@"cd_iconShadowBGR"] floatValue];
        float green = [[[Preferences sharedInstance] objectForKey:@"cd_iconShadowBGG"] floatValue];
        float blue = [[[Preferences sharedInstance] objectForKey:@"cd_iconShadowBGB"] floatValue];
        float alpha = [[[Preferences sharedInstance] objectForKey:@"cd_iconShadowBGA"] floatValue];
        float size = [[[Preferences sharedInstance] objectForKey:@"cd_iconShadowBGS"] floatValue];
        
        NSSize mySize;
        mySize.width = 0;
        mySize.height = -10;
        
        self.shadowOpacity = alpha / 100.0;
        self.shadowColor = CGColorCreateGenericRGB(red/255.0, green/255.0, blue/255.0, 1.0);
        self.shadowRadius = size;
        self.shadowOffset = mySize;
    } else {
        self.shadowOpacity = 0;
    }
    
    // Icon reflections
    if ([[[Preferences sharedInstance] objectForKey:@"cd_iconReflection"] boolValue]) {
        CALayer *_iconLayer = ZKHookIvar(self, CALayer *, "_imageLayer");
        CALayer *_reflectionLayer = nil;
        
        // Check if our custom layer exists, if it does then reference it
        for (CALayer *item in (NSMutableArray *)self.sublayers)
            if ([item.name  isEqual:@"_reflectionLayer"]) {
                _reflectionLayer = item;
                break;
            }
        
        // This way we only add the flipped tile once
        if (_reflectionLayer == nil)
        {
            NSData *buffer = [NSKeyedArchiver archivedDataWithRootObject: _iconLayer];
            _reflectionLayer = [NSKeyedUnarchiver unarchiveObjectWithData: buffer];
            [ _reflectionLayer setName:(@"_reflectionLayer")];
            [ self addSublayer:_reflectionLayer ];
        }
        
        _reflectionLayer.hidden = NO;
        
        // Transform reflecition layer using CATransform3DMakeRotation
        CGRect frm = _iconLayer.frame ;
        if (orient == 0) {
            frm.origin.y -= frm.size.height;
            _reflectionLayer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        } else if (orient == 1) {
            frm.origin.x -= frm.size.width;
            _reflectionLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        } else {
            frm.origin.x += frm.size.width;
            _reflectionLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
        }
        [ _reflectionLayer setBounds:(frm) ];
        [ _reflectionLayer setFrame:(frm) ];
        _reflectionLayer.opacity = 0.25;
    } else {
        CALayer *_reflectionLayer = nil;
        
        // Check if our custom layer exists, if it does then reference it
        for (CALayer *item in (NSMutableArray *)self.sublayers)
            if ([item.name  isEqual:@"_reflectionLayer"]) {
                _reflectionLayer = item;
                break;
            }
        
        _reflectionLayer.hidden = YES;
    }
}
@end
