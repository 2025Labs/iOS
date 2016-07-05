//
//  ArticleViewing.m
//  Magazine
//
//  Created by MBPro on 6/27/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "ArticleViewing.h"

@implementation ArticleViewing

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    
    self.scrollView.pagingEnabled = YES;
    
    [self.scrollView setAlwaysBounceVertical:NO];
    //setup internal views
    NSInteger numberOfViews = self.numPages;
    NSLog(@"This is the number: %d", self.numPages);
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:
                                           @"%@%d.jpg",self.fileName, i+1]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:image];
        NSLog(@"This is my filename: %@", self.fileName);
    }
    //set the scroll view content size
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width *
                                             numberOfViews,
                                             self.view.frame.size.height);
    //add the scrollview to this view
    [self.view addSubview:self.scrollView];
    
}


@end
