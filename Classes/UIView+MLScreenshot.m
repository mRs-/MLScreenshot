//
//  UIView+MLScreenshot.m
//
//  Created by Marius Landwehr on 21.01.13.
//  The MIT License (MIT)
//  Copyright (c) 2012 Marius Landwehr marius.landwehr@gmail.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


#import "UIView+MLScreenshot.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (MLScreenshot)

- (UIImage *)screenshot
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIImage *screenshot;
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, scale);
    {
        if(UIGraphicsGetCurrentContext() == nil)
        {
            NSLog(@"UIGraphicsGetCurrentContext is nil. You may have a UIView (%@) with no really frame (%@)", [self class], NSStringFromCGRect(self.frame));
        }
        else
        {
            [self.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            screenshot = UIGraphicsGetImageFromCurrentImageContext();
        }
    }
    UIGraphicsEndImageContext();
    
    return screenshot;
}

- (BOOL)isMapViewInSubviews:(NSArray *)subviews
{
    for(id view in subviews)
    {
        if([view isKindOfClass:NSClassFromString(@"MKMapView")])
        {
            return YES;
        }
        else
        {
            UIView *subView = view;
            [self isMapViewInSubviews:subView.subviews];
        }
    }
    
    return NO;
}

@end
