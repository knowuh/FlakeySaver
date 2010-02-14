/**

	flakeysaverView.m
	flakeysaver

	The MIT License

	Copyright (c) 2010 Noah Paessel

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.

**/

#import "flakeysaverView.h"


@implementation flakeysaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
	int i;
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
		NSGraphicsContext* ct = [NSGraphicsContext currentContext];
		[ct setShouldAntialias: TRUE];
		
		numFlakes =  [[ScreenSaverDefaults defaultsForModuleWithName:@"flakey-saver"] integerForKey:@"max_flakes"];
		theFlakes = [[[NSMutableArray alloc] init] retain];
        [self setAnimationTimeInterval:1/30.0];
		
		Flake *flake;
		for (i = 0; i < numFlakes; i++) {
			flake = [[Flake alloc] init];
			[flake setScreenSize:frame.size.width height:frame.size.height];
			[flake move:double_between(-200.0f,200.0f) dy:double_between(-200.0f,200.0f)];
			// [flake updateTrans];
			[theFlakes addObject: flake];
			[flake release];
		}
	}
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}



- (void)drawRect:(NSRect)rect
{
	
    int i;
	[[NSColor colorWithDeviceRed:0.0f green:0.0f blue:0.20f alpha:0.65f] set];
	[NSBezierPath fillRect:rect];

	[[NSColor colorWithDeviceRed:1.0f green:1.0f blue:1.0f alpha:0.0f] set];

	
	for (i = 0 ; i < numFlakes ; i++ ) {
		Flake* myFLake;
		myFLake = [theFlakes objectAtIndex:i];
//		[myFLake move:double_between(-2.0f,2.0f) dy:double_between(-2.0f,2.0f)];
//		[myFLake rotate:double_between(0.001f,0.1f)];
		[myFLake draw];
	}
}

- (void)animateOneFrame
{
	[self drawRect:[self bounds]];
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
	NSWindow *returnWindow;
	if (prefsWindow == nil) {
		prefsWindow = [[PrefWindowController alloc]initWithWindowNibName:@"prefwindow"];
		[prefsWindow retain];
		[prefsWindow loadWindow];
	}
	
	returnWindow = [prefsWindow window];
	return returnWindow;
}


@end
