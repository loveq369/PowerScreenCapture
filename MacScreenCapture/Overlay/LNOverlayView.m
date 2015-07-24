//
// Copyright (c) 2012, Shun Takebayashi
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//

#import "LNOverlayView.h"

CGFloat LNOverlayViewStandardRadius = 10.0;

@interface LNOverlayView ()

- (void)drawBezel;
- (void)drawLabel;

@end

@implementation LNOverlayView

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        self.bezelRadius = LNOverlayViewStandardRadius;
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [self drawBezel];
    [self drawLabel];
}

- (void)drawBezel {
    [[NSColor colorWithDeviceWhite:0.0 alpha:0.1] set];
    NSBezierPath *bezelPath = [NSBezierPath bezierPathWithRoundedRect:self.bounds
                                                              xRadius:self.bezelRadius
                                                              yRadius:self.bezelRadius];
    [[NSGraphicsContext currentContext] setCompositingOperation:NSCompositeSourceOver];
    [bezelPath fill];
}

- (void)drawLabel {
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSCenterTextAlignment;
    
    NSAttributedString *labelToDraw = [[NSAttributedString alloc] initWithString:self.label
                                                                      attributes:@{NSFontAttributeName: [NSFont systemFontOfSize:30],
                                                                                   NSForegroundColorAttributeName : [NSColor whiteColor],
                                                                                   NSParagraphStyleAttributeName : paragraph}];
    NSRect centeredRect;
    centeredRect.size = labelToDraw.size;
    centeredRect.origin.x = (self.bounds.size.width - centeredRect.size.width) / 2.0;
    centeredRect.origin.y = (self.bounds.size.height - centeredRect.size.height) / 2.0;
    [labelToDraw drawInRect:centeredRect];
}

- (void)centerInSuperview
{
    self.frame = (NSRect){
        self.superview.frame.size.width / 2 - self.frame.size.width / 2,
        self.superview.frame.size.height / 2 - self.frame.size.height / 2,
        self.frame.size.width,
        self.frame.size.height
    };
}

@end