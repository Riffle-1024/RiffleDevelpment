//
//  RiffleTabBarController.m
//  MyProject
//
//  Created by liuyalu on 2021/10/13.
//

#import "RiffleTabBarController.h"
#import "NSArray+Addtion.h"

@interface RiffleTabBarController ()

@end

@implementation RiffleTabBarController

@synthesize viewControllers = _viewControllers;
@synthesize selectedViewController = _selectedViewController;
@synthesize selectedIndex = _selectedIndex;
@synthesize switchAnimated;
@synthesize delegate = _delegate;
@synthesize tabBarHeight;
@synthesize tabBarImages;
@synthesize tabBarTitles;
@synthesize tabBarBackgroundImage;



- (void)selectTabButton:(UIButton *)button
{
    button.selected = YES;
}

- (void)deselectTabButton:(UIButton *)button
{
    button.selected = NO;
}

- (void)removeTabButtons
{
    NSArray *buttons = [tabButtonsContainerView subviews];
    for (UIButton *button in buttons)
    {
        [button removeFromSuperview];
    }
}

- (void)addTabButtons
{
    NSInteger index = 0;
    for (UIViewController *viewController in self.viewControllers)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = TAG_OFFSET + index;
//        [button setTitle:viewController.title forState:UIControlStateNormal];
        [button setImage:[tabBarImages objectAtIndexCheck:2*index] forState:UIControlStateNormal];
        [button setImage:[tabBarImages objectAtIndexCheck:2*index+1] forState:UIControlStateHighlighted];
        [button setImage:[tabBarImages objectAtIndexCheck:2*index+1] forState:UIControlStateSelected];
        [button setImage:[tabBarImages objectAtIndexCheck:2*index+1] forState:UIControlStateHighlighted | UIControlStateSelected];
        [button setTitle:[tabBarTitles objectAtIndexCheck:index] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchDown];
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//        button.titleLabel.shadowOffset = CGSizeMake(0, 1);
        [self deselectTabButton:button];
        [tabButtonsContainerView addSubview:button];
        
        ++index;
    }
}

- (void)reloadTabButtons
{
    [self removeTabButtons];
    [self addTabButtons];
    
    // Force redraw of the previously active tab.
    NSInteger lastIndex = _selectedIndex;
    _selectedIndex = NSNotFound;
    self.selectedIndex = lastIndex;
}

- (void)layoutTabButtons
{
    NSInteger index = 0;
    NSInteger count = [self.viewControllers count];
    
    CGRect rect = CGRectMake(0, 0, floorf(self.view.bounds.size.width / count), tabBarHeight);
    
    NSArray *buttons = [tabButtonsContainerView subviews];
    for (int i = 0; i < buttons.count; i++){
        UIButton *button = [buttons objectAtIndex:i];
        if (index == count - 1)
            rect.size.width = self.view.bounds.size.width - rect.origin.x;
        
        button.frame = rect;
        rect.origin.x += rect.size.width;
        
        if (tabBarTitles != nil && tabBarTitles.count > index) {
            NSString *title = [tabBarTitles objectAtIndex:i];
            CGSize textSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10], NSFontAttributeName, nil]];
            if (textSize.width > ScreenWidth / buttons.count) {
                textSize.width = ScreenWidth / buttons.count;
            }
            //计算移动距离
            if (DEVICE_IS_IPHONE_X) {
                [button setContentHorizontalAlignment: UIControlContentHorizontalAlignmentLeft];
                [button setContentVerticalAlignment: UIControlContentVerticalAlignmentTop];
                [button setImageEdgeInsets: UIEdgeInsetsMake(5, (button.bounds.size.width-button.imageView.bounds.size.width)*0.5, 0, 0)];
                [button setTitleEdgeInsets: UIEdgeInsetsMake(button.imageView.bounds.size.height+5, (button.bounds.size.width-button.titleLabel.bounds.size.width)*0.5-button.imageView.bounds.size.width, 0, 0)];
            } else {
                [button setImageEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, -textSize.width)];
                [button setTitleEdgeInsets:UIEdgeInsetsMake(35, -button.imageView.frame.size.width, 0, 0)];
            }


        }
        ++index;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (tabBarHeight <= 0) {
        tabBarHeight = TAB_BAR_HEIGHT;
    }

    tabButtonsContainerView = [[UIView alloc] init];
    if (tabBarBackgroundImage != nil) {
        [tabButtonsContainerView setBackgroundColor:[UIColor colorWithPatternImage:tabBarBackgroundImage]];
    }
    [self.view addSubview:tabButtonsContainerView];
    
    // 添加约束条件
    tabButtonsContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *bottomCos = [NSLayoutConstraint constraintWithItem:tabButtonsContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *leftCos = [NSLayoutConstraint constraintWithItem:tabButtonsContainerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *rightCos = [NSLayoutConstraint constraintWithItem:tabButtonsContainerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:tabButtonsContainerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:TAB_BAR_HEIGHT];
    [self.view addConstraints:@[bottomCos, leftCos, rightCos, heightCos]];
    
    // 内容View
    contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-TAB_BAR_HEIGHT)];
    contentContainerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentContainerView];

    contentContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *bottomCos2 = [NSLayoutConstraint constraintWithItem:contentContainerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:tabButtonsContainerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *leftCos2 = [NSLayoutConstraint constraintWithItem:contentContainerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *rightCos2 = [NSLayoutConstraint constraintWithItem:contentContainerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *topCos2 = [NSLayoutConstraint constraintWithItem:contentContainerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.view addConstraints:@[bottomCos2, leftCos2, rightCos2, topCos2]];
    
    [self reloadTabButtons];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)dealloc
{

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    tabButtonsContainerView = nil;
    contentContainerView = nil;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self layoutTabButtons];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Only rotate if all child view controllers agree on the new orientation.
    for (UIViewController *viewController in self.viewControllers)
    {
        if (![viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation])
        {
            return NO;
        }
    }
    return YES;
}

- (void)setViewControllers:(NSArray *)newViewControllers
{
    NSAssert([newViewControllers count] >= 2, @"MCTabBarController requires at least two view controllers");
    
    UIViewController *oldSelectedViewController = self.selectedViewController;
    
    // Remove the old child view controllers.
    for (UIViewController *viewController in _viewControllers)
    {
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
    }
    
    _viewControllers = [newViewControllers copy];
    
    // This follows the same rules as UITabBarController for trying to
    // re-select the previously selected view controller.
    NSInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
    if (newIndex != NSNotFound)
    {
        _selectedIndex = newIndex;
    }
    else if (newIndex < [_viewControllers count])
    {
        _selectedIndex = newIndex;
    }
    else
    {
        _selectedIndex = 0;
    }
    
    // Add the new child view controllers.
    for (UIViewController *viewController in _viewControllers)
    {
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
    
    if ([self isViewLoaded])
        [self reloadTabButtons];
}

- (void)setSelectedIndex:(NSInteger)newSelectedIndex
{
    [self setSelectedIndex:newSelectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSInteger)newSelectedIndex animated:(BOOL)animated
{
    if ( (newSelectedIndex < 0) || (newSelectedIndex >= [self.viewControllers count]) ) {
        NSLog(@"MCTabBarController View controller index out of bounds");
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(mcTabBarController:shouldSelectViewController:atIndex:)])
    {
        UIViewController *toViewController = [self.viewControllers objectAtIndexCheck:newSelectedIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(mcTabBarController:shouldSelectViewController:atIndex:)])
        {
            if (![self.delegate mcTabBarController:self shouldSelectViewController:toViewController atIndex:newSelectedIndex])
            {
                return;
            }
        }
    }
    
    if (![self isViewLoaded])
    {
        _selectedIndex = newSelectedIndex;
    }
    else if (_selectedIndex != newSelectedIndex)
    {
        UIViewController *fromViewController = nil;
        UIViewController *toViewController = nil;
        
        if (_selectedIndex != NSNotFound)
        {
            UIButton *fromButton = (UIButton *)[tabButtonsContainerView viewWithTag:TAG_OFFSET + _selectedIndex];
            [self deselectTabButton:fromButton];
            fromViewController = self.selectedViewController;
        }
        
        NSInteger oldSelectedIndex = _selectedIndex;
        _selectedIndex = newSelectedIndex;
        
        UIButton *toButton;
        if (_selectedIndex != NSNotFound)
        {
            toButton = (UIButton *)[tabButtonsContainerView viewWithTag:TAG_OFFSET + _selectedIndex];
            [self selectTabButton:toButton];
            toViewController = self.selectedViewController;
        }
        
        if (toViewController == nil)  // don't animate
        {
            [fromViewController.view removeFromSuperview];
        }
        else if (fromViewController == nil)  // don't animate
        {
            toViewController.view.frame = contentContainerView.bounds;
            [contentContainerView addSubview:toViewController.view];
            
            //
            toViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:toViewController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentContainerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
            NSLayoutConstraint *leftCons = [NSLayoutConstraint constraintWithItem:toViewController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:contentContainerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
            NSLayoutConstraint *rightCons = [NSLayoutConstraint constraintWithItem:toViewController.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:contentContainerView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
            NSLayoutConstraint *bottomCons = [NSLayoutConstraint constraintWithItem:toViewController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentContainerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            [contentContainerView addConstraints:@[topCons, leftCons, rightCons, bottomCons]];
            if (self.delegate && [self.delegate respondsToSelector:@selector(mcTabBarController:didSelectViewController:atIndex:)])
                [self.delegate mcTabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
        }
        else if (animated)
        {
            CGRect rect = contentContainerView.bounds;
            if (oldSelectedIndex < newSelectedIndex)
                rect.origin.x = rect.size.width;
            else
                rect.origin.x = -rect.size.width;
            
            toViewController.view.frame = rect;
            tabButtonsContainerView.userInteractionEnabled = NO;
            
            [self transitionFromViewController:fromViewController
                              toViewController:toViewController
                                      duration:0.3
                                       options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                                    animations:^
             {
                 CGRect rect = fromViewController.view.frame;
                 if (oldSelectedIndex < newSelectedIndex)
                 {
                     rect.origin.x = -rect.size.width;
                 }
                 else
                 {
                     rect.origin.x = rect.size.width;
                 }
                 
                 fromViewController.view.frame = rect;
                 toViewController.view.frame = contentContainerView.bounds;
             }
                                    completion:^(BOOL finished)
             {
                 tabButtonsContainerView.userInteractionEnabled = YES;
                 
                 if (self.delegate && [self.delegate respondsToSelector:@selector(mcTabBarController:didSelectViewController:atIndex:)])
                 {
                     [self.delegate mcTabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
                 }
             }];
        }
        else  // not animated
        {
            [fromViewController.view removeFromSuperview];
            
            toViewController.view.frame = contentContainerView.bounds;
            [contentContainerView addSubview:toViewController.view];
            
            toViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:toViewController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentContainerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
            NSLayoutConstraint *leftCons = [NSLayoutConstraint constraintWithItem:toViewController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:contentContainerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
            NSLayoutConstraint *rightCons = [NSLayoutConstraint constraintWithItem:toViewController.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:contentContainerView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
            NSLayoutConstraint *bottomCons = [NSLayoutConstraint constraintWithItem:toViewController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentContainerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            [contentContainerView addConstraints:@[topCons, leftCons, rightCons, bottomCons]];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(mcTabBarController:didSelectViewController:atIndex:)])
            {
                [self.delegate mcTabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
            }
        }
    }
}

- (UIViewController *)selectedViewController
{
    if (self.selectedIndex != NSNotFound)
    {
        return [self.viewControllers objectAtIndexCheck:self.selectedIndex];
    }
    
    return nil;
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
    [self setSelectedViewController:newSelectedViewController animated:NO];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated;
{
    NSInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
    if (index != NSNotFound)
    {
        [self setSelectedIndex:index animated:animated];
    }
}

- (void)tabButtonPressed:(UIButton *)sender
{
    [self setSelectedIndex:sender.tag - TAG_OFFSET animated:switchAnimated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
