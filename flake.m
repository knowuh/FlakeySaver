/**
 
	flake.m
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

#import "flake.h"

@implementation Flake
	
	
	/*
	*
	*/
	int mySort(const void* a, const void* b) {
		float *avp = (float *)a;
		float *bvp = (float *)b;
		
		if (*avp > *bvp) {
			return 1;
		}
		if (*bvp > *avp) {
			return -1;
		}
		return 0;	
	}



	/*
	*
	*/
	- (id)init {
	   self = [super init];
		if (self) {
			[self initValues];
		}
		return self;
	}
	

	/*
	*
	*/
	- (void) initValues {
		float max_points = [[ScreenSaverDefaults defaultsForModuleWithName:@"flakey-saver"] integerForKey:@"max_verts"];
		float max_max_hole_percent = [[ScreenSaverDefaults defaultsForModuleWithName:@"flakey-saver"]  floatForKey:@"max_hole_percent"];
		float max_size = [[ScreenSaverDefaults defaultsForModuleWithName:@"flakey-saver"]  floatForKey:@"max_size"];
		float max_move = [[ScreenSaverDefaults defaultsForModuleWithName:@"flakey-saver"]  floatForKey:@"max_move"];


		numPoints = (int) double_between(4.0f, max_points);
		float max_hole_percent = double_between(1.0f,max_max_hole_percent);

		maxRadius = double_between(10.0f, max_size);
		minRadius = maxRadius * (max_hole_percent/100.0f);
		// minRadius = minRadius < 0 ? 0 : minRadius;
		
		x = double_between(20.0f,1600.0f);
		y = double_between(20.0f,1600.0f);
		
		float vel = max_move;
		vx = double_between(-1 * vel,vel);
		vy = double_between(-1 * vel,vel);
		
		vrot = double_between(-0.14f,0.14f);
		vscale = double_between(0.94f, 0.999f);
		
		scale = 1.0f;
		angle = 0.0f;
		[self initshape];
		
		if (transform != nil) {
			[transform release];
		}
		
		if (fillColor != nil) {
			[fillColor release];
		}
		
		if (strokeColor != nil) {
			[strokeColor release];
		}
		
		transform = [NSAffineTransform transform];
		
		fillColor = [NSColor  colorWithDeviceRed:0.7f green:0.7f blue:0.8f alpha:0.6];
		strokeColor = [NSColor  colorWithDeviceRed:0.9f green:0.9f blue:1.0f alpha:0.5f];
		blurColor = [NSColor  colorWithDeviceRed:0.8f green:0.8f blue:1.0f alpha:0.019f];
		
		[transform retain];
		[strokeColor retain];
		[fillColor retain];
		[blurColor retain];
			
	}


	/*	
	*	
	*/
	- (void) initshape {
		seed();
		int i = 0;
		int j = 0;
		float r[numPoints];
		float t[numPoints];
		float max_sym = [[ScreenSaverDefaults defaultsForModuleWithName:@"flakey-saver"]  integerForKey:@"max_sym"];
		float symetry = (int) double_between(3.0f,max_sym);
		
		for (i = 0; i < numPoints; i++) {
			r[i] = double_between(minRadius,maxRadius);
			t[i] = double_between(0.0f,pi/2.0f);
		}
		qsort(t, numPoints, sizeof(float), &mySort);
		shapePath = [[NSBezierPath alloc] init];
		[shapePath retain];
		[shapePath setWindingRule:NSEvenOddWindingRule];
		[shapePath moveToPoint:[self polar2cart:t[0] radius:r[0]]];
		
		// symetrical sections
		for (j = 0; j < symetry; j++) {
			for (i = 0; i < numPoints; i++) {
				[shapePath lineToPoint:[self polar2cart:t[i]+(pi * 2.0f * (j/symetry)) radius:r[i]]];
			}
		}
		[shapePath lineToPoint:[self polar2cart:t[0]+(pi * 2.0f * (j/symetry)) radius:r[0]]];
		
		// now do the middle bit..
		for (i = 0; i < numPoints; i++) {
			r[i] = double_between(0.0f,minRadius);
			t[i] = double_between(0.0f,pi/2.0f);
		}
		qsort(t, numPoints, sizeof(float), &mySort);
		
		[shapePath moveToPoint:[self polar2cart:t[0] radius:r[0]]];
	
		for (j = 0; j < symetry; j++) {
			for (i = 0; i < numPoints; i++) {
				[shapePath lineToPoint:[self polar2cart:t[i]+(pi * 2.0f * (j/symetry)) radius:r[i]]];
			}
		}
		[shapePath lineToPoint:[self polar2cart:t[0]+(pi * 2.0f * (j/symetry)) radius:r[0]]];
		
	
	}

	- (NSBezierPath*) getShape {
		return shapePath;
	}
	
	
	/*
	*
	*/
	- (void) draw {
	
		[self updateVeloc];
		[self updateTrans];
		[transform set];
		
		[fillColor set];
		[shapePath fill];
		
		[strokeColor set];
		[shapePath stroke];
		[shapePath fill];
		
		[blurColor set];
		int i = 0;
		float offsetX=0.0f;
		float offsetY=0.0f;
		[transform scaleBy:1.2f];
		for (i = 0; i < 4; i++) {
			offsetX = double_between(-3.0f,3.0f);
			offsetY = double_between(-3.0f,3.0f);
			[transform rotateByDegrees:double_between(-3.0f,3.0f)];
			[transform scaleBy:1.19f];
			
			[transform translateXBy:offsetX yBy:offsetY];
			
			
			[transform set];		
			[shapePath fill];
			[transform translateXBy:offsetX * -1.0f yBy:offsetY * -1.0f];
			[transform set];
		}
		
		[transform initWithTransform:[NSAffineTransform transform]];
		[transform set];
		
	}
	
	- (void) updateTrans {
		[transform translateXBy:x yBy:y];
		[transform rotateByRadians:angle];
		[transform scaleBy:scale];
	}
	
	
	- (void) updateVeloc {
		[self move:vx dy:vy];
		[self rotate: vrot];
		[self scale: vscale];
	}
	
	
	/*
	*
	*/
	- (void) setScreenSize:(float)width height:(float)height {
		screen_width = width;
		screen_height = height;
	}
	
	
	/*
	*
	*/			
	- (void) move:(float)dx dy:(float)dy {
		x += dx;
		y += dy;
		x = x > screen_width + maxRadius*2 ? 0 : x;
		y = y > screen_height +maxRadius*2 ? 0 : y;
		x = x < 0 - maxRadius*2 ? screen_width : x;
		y = y < 0 - maxRadius*2 ? screen_height : y;
	}
	
	
	/*
	*
	*/
	- (void) scale:(float)amount {
		scale *= amount;
		if (scale < 0.1f) {
			[self initValues];
		}
	}
	
	
	/*
	*
	*/
	- (void) rotate:(float)theta {
		angle +=theta;
	}

	
	
	/*
	*
	*/
	- (NSPoint) polar2cart:(float)theta radius:(float)radius {
		
		float _x = cos(theta) * radius;
		float _y = sin(theta) * radius;
		
		NSPoint p = NSMakePoint(_x,_y);
		return p;
	}
	
	
@end
