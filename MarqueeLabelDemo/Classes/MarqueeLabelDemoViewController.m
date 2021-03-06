/**
 * Copyright (c) 2012 Charles Powell
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  MarqueeLabelDemoViewController.m
//  MarqueeLabelDemo
//

#import "MarqueeLabelDemoViewController.h"

@implementation MarqueeLabelDemoViewController

@synthesize labelizeSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Continuous Type
    self.demoLabel1.marqueeType = MLContinuous;
    self.demoLabel1.scrollDuration = 15.0;
    self.demoLabel1.animationCurve = UIViewAnimationOptionCurveEaseInOut;
    self.demoLabel1.fadeLength = 10.0f;
    self.demoLabel1.continuousMarqueeExtraBuffer = 10.0f;
    self.demoLabel1.text = @"This is a test of MarqueeLabel - the text is long enough that it needs to scroll to see the whole thing.";
    self.demoLabel1.tag = 101;
    
    
    // Reverse Continuous Type, with attributed string
    self.demoLabel2.marqueeType = MLContinuousReverse;
    self.demoLabel2.scrollDuration = 8.0;
    self.demoLabel2.fadeLength = 15.0f;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"This is a long string, that's also an attributed string, which works just as well!"];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:18.0f] range:NSMakeRange(0, 21)];
    [attributedString addAttribute:NSBackgroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(10,11)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:1.000] range:NSMakeRange(0,attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f] range:NSMakeRange(21, attributedString.length - 21)];
    self.demoLabel2.attributedText = attributedString;
    
    
    // Left/right example, with rate usage
    self.demoLabel3.marqueeType = MLLeftRight;
    self.demoLabel3.rate = 30.0f;
    self.demoLabel3.fadeLength = 10.0f;
    self.demoLabel3.textAlignment = NSTextAlignmentCenter;
    self.demoLabel3.text = @"This is another long label that scrolls at a specific rate, rather than scrolling its length in a specific time window!";
    self.demoLabel3.tag = 102;
     
    
    // Right/left example, with tap to scroll
    self.demoLabel4.marqueeType = MLRightLeft;
    self.demoLabel4.tapToScroll = YES;
    self.demoLabel4.text = @"This label will not scroll until tapped, and then it performs its scroll cycle only once. Tap me!";
    
    
    // Continuous, with tap to pause
    self.demoLabel5.marqueeType = MLContinuous;
    self.demoLabel5.scrollDuration = 10.0f;
    self.demoLabel5.fadeLength = 10.0f;
    self.demoLabel5.text = @"This text is long, and can be paused with a tap - handled via a UIGestureRecognizer!";
    
    self.demoLabel5.userInteractionEnabled = YES; // Don't forget this, otherwise the gesture recognizer will fail (UILabel has this as NO by default)
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.demoLabel5 addGestureRecognizer:tapRecognizer];
}

- (IBAction)changeLabelTexts:(id)sender {
    // Use demoLabel1 tag to store "state"
    if (self.demoLabel1.tag == 101) {
        self.demoLabel1.text = @"This label is not as long.";
        self.demoLabel3.text = @"This is a short, centered label.";
        self.demoLabel1.tag = 102;
    } else {
        self.demoLabel1.text = @"This is a test of MarqueeLabel - the text is long enough that it needs to scroll to see the whole thing.";
        self.demoLabel3.text = @"That also scrolls continuously rather than scrolling back and forth!";
        self.demoLabel1.tag = 101;
    }
}

- (void)pauseTap:(UITapGestureRecognizer *)recognizer {
    MarqueeLabel *continuousLabel2 = (MarqueeLabel *)recognizer.view;
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (!continuousLabel2.isPaused) {
            [continuousLabel2 pauseLabel];
        } else {
            [continuousLabel2 unpauseLabel];
        }
    }
}

- (IBAction)labelizeSwitched:(UISwitch *)sender {
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]) {
            [(MarqueeLabel *)v setLabelize:sender.on];
        }
    }
}

- (IBAction)holdLabelsSwitched:(UISwitch *)sender {
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]) {
            [(MarqueeLabel *)v setHoldScrolling:sender.on];
        }
    }
}

- (IBAction)togglePause:(UISwitch *)sender {
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[MarqueeLabel class]]) {
            if (sender.on) {
                [(MarqueeLabel *)v pauseLabel];
            } else {
                [(MarqueeLabel *)v unpauseLabel];
            }
        }
    }
}

- (IBAction)unwindModalPopoverSegue:(UIStoryboardSegue *)segue {
    // Empty
}
     
// For Autoresizing test
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // If you have trouble with MarqueeLabel instances not automatically scrolling, implement the
    // viewWillAppear bulk method as seen below. This will attempt to restart scrolling on all
    // MarqueeLabels associated (in the view hierarchy) with the calling view controller
    
    [MarqueeLabel controllerViewWillAppear:self];
    
    // Or...
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Or you could use viewDidAppear bulk method - try both to see which works best for you!
    
    // [MarqueeLabel controllerViewDidAppear:self];
}


@end
