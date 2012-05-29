//
//  ViewController.m
//  MultipageScrollView
//
//  Created by martin magalong on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "View1.h"
#import "View2.h"
#import "View3.h"


@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor grayColor];
        _viewList = [[NSMutableArray alloc]init];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 10, 300, 400)];
        _scrollView.center = self.view.center;
        _scrollView.contentSize = CGSizeMake(900, 400);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor blueColor];
        _scrollView.userInteractionEnabled = YES;
        _scrollView.pagingEnabled = YES;
        [self.view addSubview:_scrollView];
        [self createViews];
        
        [self loadScrollViewWithPage:0];
        [self autoScroll];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10,110,300,10)];
        [_pageControl setNumberOfPages:3];
        [_pageControl setBackgroundColor:[UIColor lightGrayColor]];
        [_pageControl setUserInteractionEnabled:NO];
        [self.view addSubview:_pageControl];
    }
    return self;
}

- (void)createViews
{
    CGRect rect = CGRectMake(0, 0, 300, 400);
    View1 *view = [[View1 alloc]initWithFrame:rect];
    View2 *view2 = [[View2 alloc]initWithFrame:rect];
    View3 *view3 = [[View3 alloc]initWithFrame:rect];
    
    [_viewList addObject:view];
    [_viewList addObject:view2];
    [_viewList addObject:view3];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,110,300,10)];
    [_pageControl setNumberOfPages:_viewList.count];
    [_pageControl setBackgroundColor:[UIColor lightGrayColor]];
    [_pageControl setUserInteractionEnabled:NO];
    [_scrollView insertSubview:_pageControl atIndex:5];
}

#pragma mark - ScrollView Methods
- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= 3) return;
	
    UIView *controller;
    if ([_viewList count] > 0) {
        controller = [_viewList objectAtIndex:page];
    }
    
    // add the controller's view to the scroll view
    if (controller.superview ==  nil) {
        CGRect frame = _scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.frame = frame;
        [_scrollView addSubview:controller];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(autoScroll)
                                               object:nil];
    int newOffset = scrollView.contentOffset.x;
    int page = (int)(newOffset/(scrollView.frame.size.width));
    int width = page * 300;
    [_scrollView scrollRectToVisible:CGRectMake(width, 0, 300,110) animated:YES];  
    [_pageControl setCurrentPage:page];
    aPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    [self autoScroll];
}

- (void)autoScroll
{
    [_pageControl setCurrentPage:aPage];
    int width = aPage * 300;
    [_scrollView scrollRectToVisible:CGRectMake(width, 0, 300,110) animated:YES];       
    
    aPage = aPage+1;
    if (aPage == 3) {
        aPage = 0;
    }
    [self performSelector:@selector(autoScroll) withObject:nil afterDelay:3];
}

@end
