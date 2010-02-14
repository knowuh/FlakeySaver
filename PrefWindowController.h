/**

	PrefWindwController.h
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
#import <ScreenSaver/ScreenSaver.h>

#define DEF_MAX_MOVEMENT 3.0f
#define DEF_MAX_SIZE 60.0f
#define DEF_MAX_SYM 6
#define DEF_MAX_VERTS 8
#define DEF_MAX_FLAKES 18

@interface PrefWindowController : NSWindowController
{
	NSUserDefaults		*userPrefs;
	
	IBOutlet NSSlider		*slider_max_movement;
	IBOutlet NSSlider		*slider_max_size;
	IBOutlet NSSlider		*slider_max_symetry;
	IBOutlet NSSlider		*slider_max_verticies;
	IBOutlet NSSlider		*slider_num_flakes;
}

- (IBAction) donePressed:(id)sender;

@end
