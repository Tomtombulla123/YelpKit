//
//  YKUIButtonCell.m
//  YelpKit
//
//  Created by Gabriel Handford on 7/23/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "YKUIButtonCell.h"

@implementation YKUIButtonCell

@synthesize button=_button;

- (id)initWithButton:(YKUIButton *)button {
  if ((self = [super initWithView:button reuseIdentifier:nil])) {
    _button = button;
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
  YKUIButton *button = [[YKUIButton alloc] init];
  button.insets = UIEdgeInsetsMake(10, 10, 10, 10);
  if ((self = [self initWithButton:button])) { }
	return self;
}

- (void)dealloc {
  [_button release];
  [super dealloc];
}

@end