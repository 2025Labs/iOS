//
//  MainViewController.h
//  Magazine
//
//  Created by Melissa Liu on 12/13/17.
//  Copyright © 2017 MBPro. All rights reserved.
//

#ifndef MainViewController_h
#define MainViewController_h


#endif /* MainViewController_h */

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
#import "IGCMenu.h"
#import <libpq/libpq-fe.h>
@import WebImage;

@interface MainViewController : ViewController



@property (weak, nonatomic) IBOutlet UIButton *sender;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@property NSString *currentTopic;

@end


