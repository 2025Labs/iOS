//
//  News
//  Magazine
//
//  Created by 2025 Labs on 6/27/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <libpq/libpq-fe.h>

@interface News : UIViewController
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property NSString *fileName;
@property NSInteger numPages;
@property NSString *currentTopic;
@property NSString *note;
@property BOOL setupDone;

@property NSMutableArray *articleArray;
@property const char *connectionString;
@property int pageToJumpTo;
@property PGresult *result;
@property PGconn *connection;

@property int leftArticlePageToJumpTo;
@property int rightArticlePageToJumpTo;
@property int pageNumber;
@property int maxPageNumber;

@property (weak, nonatomic) IBOutlet UIButton *articleButton_1;
@property (weak, nonatomic) IBOutlet UIButton *articleButton_2;
@property (weak, nonatomic) IBOutlet UIButton *articleButton_3;
@property (weak, nonatomic) IBOutlet UIButton *articleButton_4;


@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;

@end
