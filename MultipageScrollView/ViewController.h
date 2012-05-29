//
//  ViewController.h
//  MultipageScrollView
//
//  Created by martin magalong on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>
{

    
    int aPage;
    UIScrollView    *_scrollView;
    NSMutableArray  *_viewList;
    UIPageControl   *_pageControl;
}
@end
