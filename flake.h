/**

	flake.h
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

#import <Cocoa/Cocoa.h>
#import "nrand.h"
#import <ScreenSaver/ScreenSaver.h>


@interface Flake : NSObject {
	int				numPoints;
	float			maxRadius;
	float			minRadius;
	float			alpha;
	float			lineWidth;
	
	float			x;
	float			y;
	
	float			vx;
	float			vy;
	float			vrot;
	float			vscale;
	
	float			scale;
	float			angle;
	
	float			screen_width;
	float			screen_height;
	
	NSBezierPath*		shapePath;
	NSAffineTransform*	transform;
	NSColor*			fillColor;
	NSColor*			strokeColor;
	NSColor*			blurColor;
}
- (void) initshape;
- (NSBezierPath*) getShape;

- (void) draw;
- (void) move:(float)dx dy:(float)dy;
- (void) scale:(float)amount;
- (void) rotate:(float)theta;
- (void) updateTrans;
- (void) updateVeloc;
- (void) setScreenSize:(float)width height:(float)height;
- (void) initValues;

- (NSPoint) polar2cart:(float)theta radius:(float)radius;
@end
