//
//  MainHomepageController.h
//  Magazine
//
//  Created by Melissa Liu on 11/9/17.
//  Copyright © 2017 MBPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHomepageController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property NSString *currentTopic;

@end

