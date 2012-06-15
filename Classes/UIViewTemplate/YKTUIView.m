//
//  YKTUIView.m
//  YelpKit
//
//  Created by Gabriel Handford on 5/13/12.
//  Copyright (c) 2012 Yelp. All rights reserved.
//

#import "YKTUIView.h"
#import "YKTUIViewController.h"

@implementation YKTUIView

@synthesize viewController=_viewController, navigationBar=_navigationBar, visible=_visible, needsRefresh=_needsRefresh;

- (void)sharedInit {
  [super sharedInit];
  self.backgroundColor = [UIColor blackColor];
  self.opaque = YES;
  self.layout = [YKLayout layoutForView:self];  
}

- (id)initWithCoder:(NSCoder *)coder {
  if ((self = [super initWithCoder:coder])) {
    [self sharedInit];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self sharedInit];
  }
  return self;
}

- (void)dealloc {
  [_navigationBar release];
  [super dealloc];
}

- (YKUINavigationBar *)navigationBar {
  if (!_navigationBar) {
    _navigationBar = [[YKUINavigationBar alloc] init];
    [self applyStyleForNavigationBar:_navigationBar];
  }
  return _navigationBar;
}

- (UINavigationController *)navigationController {
  //NSAssert(_viewController, @"No view controller!");
  return _viewController.navigationController;
}

- (YKTUIViewController *)newViewController {
  // Add the nav bar if we are being used in a view controller
  [self addSubview:_navigationBar];

  YKTUIViewController *viewController = [[self createViewControllerForView] retain];
  _viewController = viewController;
  return _viewController;
}

- (YKTUIViewController *)createViewControllerForView {
  YKTUIViewController *viewController = [[YKTUIViewController alloc] init];  
  [viewController setContentView:self];
  return [viewController autorelease];
}

- (YKTUIViewController *)viewController:(BOOL)create {
  if (!create || _viewController) return _viewController;
  return [[self newViewController] autorelease];
}

- (void)swapView:(YKTUIView *)view fromView:(YKTUIView *)fromView transition:(UIViewAnimationTransition)transition duration:(NSTimeInterval)duration {
  YKTUIViewController *viewController = [view viewController:YES];
  UINavigationController *navigationController = self.navigationController;
  
  if (transition != UIViewAnimationTransitionNone) {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:navigationController.view cache:NO];
  }
  
  if (fromView) {
    [navigationController popToViewController:[fromView viewController:NO] animated:NO];
  } else {
    [navigationController popViewControllerAnimated:NO];
  }
  
  [navigationController pushViewController:viewController animated:NO];
  
  
  if (transition != UIViewAnimationTransitionNone) [UIView commitAnimations];
}

- (void)pushView:(YKTUIView *)view animated:(BOOL)animated {
  YKTUIViewController *viewController = [view newViewController];
  [self.navigationController pushViewController:viewController animated:animated];
  [viewController release];
}

- (void)setView:(YKTUIView *)view animated:(BOOL)animated {
  YKTUIViewController *viewController = [view newViewController];
  [self.navigationController setViewControllers:[NSArray arrayWithObject:viewController] animated:animated];
  [viewController release];
}

- (void)popToRootViewAnimated:(BOOL)animated {
  [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)popViewAnimated:(BOOL)animated {
  [self.navigationController popViewControllerAnimated:animated];
}

- (void)popToView:(YKTUIView *)view animated:(BOOL)animated {
  if (view.viewController) {
    [self.navigationController popToViewController:view.viewController animated:animated];
  }
}

- (void)setNavigationTitle:(NSString *)title animated:(BOOL)animated {
  [self.navigationBar setTitle:title animated:animated];
}

- (YKUIButton *)setNavigationButtonWithTitle:(NSString *)title iconImage:(UIImage *)iconImage position:(YKUINavigationPosition)position style:(YKUINavigationButtonStyle)style animated:(BOOL)animated target:(id)target action:(SEL)action {
  YKUIButton *button = [[YKUIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
  button.title = title;
  button.iconImage = iconImage;
  [button setTarget:target action:action];
  [self applyStyleForNavigationButton:button style:style];
  switch (position) {
    case YKUINavigationPositionLeft:
      [self.navigationBar setLeftButton:button style:YKUINavigationButtonStyleDefault animated:animated];
      break;
    case YKUINavigationPositionRight:
      [self.navigationBar setRightButton:button style:YKUINavigationButtonStyleDefault animated:animated];
      break;
  }

  return [button autorelease];
}

- (void)_viewWillAppear:(BOOL)animated { 
  _visible = YES;
  [self viewWillAppear:animated];
}

- (void)_viewDidAppear:(BOOL)animated {
  [self viewDidAppear:animated];
}

- (void)_viewWillDisappear:(BOOL)animated {
  [self viewWillDisappear:animated];
  _visible = NO;
}

- (void)_viewDidDisappear:(BOOL)animated {
  [self _viewDidDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated { }

- (void)viewDidAppear:(BOOL)animated { }

- (void)viewWillDisappear:(BOOL)animated { }

- (void)viewDidDisappear:(BOOL)animated { }

- (void)refresh { }

- (void)setNeedsRefresh {
  _needsRefresh = YES;
  if (_visible) {
    [self refresh];
  }
}

#pragma mark Style

- (void)applyStyleForNavigationButton:(YKUIButton *)button style:(YKUINavigationButtonStyle)style {
  button.titleFont = [UIFont boldSystemFontOfSize:12];
  button.insets = UIEdgeInsetsMake(0, 8, 0, 8);
  button.titleColor = [UIColor whiteColor];
  button.margin = UIEdgeInsetsMake(6, 0, 6, 0);
  button.cornerRadius = 4.0;
  button.borderWidth = 0.5;
  button.titleShadowColor = [UIColor colorWithWhite:0 alpha:0.5];
  button.titleShadowOffset = CGSizeMake(0, -1);
  button.shadingType = YKUIShadingTypeLinear;
  button.color = [UIColor colorWithRed:98.0f/255.0f green:120.0f/255.0f blue:170.0f/255.0f alpha:1.0];
  button.color2 = [UIColor colorWithRed:64.0f/255.0f green:90.0f/255.0f blue:136.0f/255.0f alpha:1.0];
  button.highlightedShadingType = YKUIShadingTypeLinear;
  button.highlightedColor = [UIColor colorWithRed:70.0f/255.0f green:92.0f/255.0f blue:138.0f/255.0f alpha:1.0];
  button.highlightedColor2 = [UIColor colorWithRed:44.0f/255.0f green:70.0f/255.0f blue:126.0f/255.0f alpha:1.0];
  button.borderColor = [UIColor colorWithRed:87.0f/255.0f green:100.0f/255.0f blue:153.0f/255.0f alpha:1.0];
  
  CGSize size = [button sizeThatFitsTitle:CGSizeMake(120, 999) minWidth:55];
  button.frame = CGRectMake(0, 0, size.width, 30 + button.margin.top + button.margin.bottom);
}

- (void)applyStyleForNavigationBar:(YKUINavigationBar *)navigationBar {
  navigationBar.backgroundColor = [UIColor colorWithRed:98.0f/255.0f green:120.0f/255.0f blue:170.0f/255.0f alpha:1.0];
  navigationBar.topBorderColor = [UIColor colorWithRed:87.0f/255.0f green:100.0f/255.0f blue:153.0f/255.0f alpha:1.0];
  navigationBar.bottomBorderColor = [UIColor colorWithRed:87.0f/255.0f green:100.0f/255.0f blue:153.0f/255.0f alpha:1.0];
}

@end
