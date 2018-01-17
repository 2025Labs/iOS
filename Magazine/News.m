//
//  News
//  Magazine
//
//  Created by 2025 Labs on 6/27/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import "News.h"
#import <libpq/libpq-fe.h>
#import "PuzzleNavigation.h"
@import WebImage;

@implementation News

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScrollview];
    
    _leftArticlePageToJumpTo = 0;
    _rightArticlePageToJumpTo = 5;
    _articleArray = [[NSMutableArray alloc] init];

    [self getFilepathFromJSON];
    for (int i = 0; i < [_articleArray count]; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(xOrigin, 0,
                                             self.scrollView.frame.size.width,
                                             self.scrollView.frame.size.height)];
        
        /*
         SDWebImageManager is the library that allows us to download an image from its URL if
         we do not already have that image in our storage/cache
         */
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:[_articleArray objectAtIndex:i]]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 NSLog(@"Received: %ld expected: %ld", (long)receivedSize, (long)expectedSize);
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    [imageView setImage:image];
                                    imageView.contentMode = UIViewContentModeScaleToFill;
                                    [self.scrollView addSubview:imageView];
                                    
                                }
                            }];
        
    }
    //set the scroll view content size
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width *
                                             [_articleArray count],
                                             self.scrollView.frame.size.height);
    //add the scrollview to this view
    [self.view addSubview:self.scrollView];
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width*_pageNumber, 0);

}

-(void) getFilepathFromJSON {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"imagesJSON" ofType:@"json"];
    
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSArray *jsonDataArray = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    //To pull item based on topic, add a conditional that says
    //[item objectForKey:@"topic"] isEqual: @"energy"] in addition to the @"notes" key
    for(NSDictionary *item in jsonDataArray) {
        if([[item objectForKey:@"topic"] isEqual: _currentTopic]) {
            if([[item objectForKey:@"notes"] isEqual: _note]) {
               [_articleArray addObject:[item objectForKey:@"filepath"]];
            }
        }
    }
}

-(void) setupScrollview {
    //self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80,self.view.frame.size.width, 760)];
    NSLog(@"width: %f height: %f", self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];
    _setupDone = true;
}


-(IBAction)jumpToPage:(id) sender {
    int pageToJumpTo = (int) [sender tag];
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width*pageToJumpTo, 0);
    
    NSLog(@"page to jump to: %d", pageToJumpTo);
    
}

/*
 **
 
 prepareForSegue is where we pass the topic and filename for which we wish to display
 when we transition into a new scene. The new scene will load up by looking at its
 current topic and/or the filename and display content accordingly
 UPDATE (12/14/17): Added functionality that checks for incoming segue
                    to base images by topic.
 **
 */

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showNews"]) {
        if([_incomingSegue isEqual:@"computing"]){
            [segue.destinationViewController setIncomingSegue:@"computing"];
            News* controller = [segue destinationViewController];
            _currentTopic = @"computing";
            controller.note = @"article";
            controller.currentTopic = _currentTopic;
            controller.pageNumber = 0;
        }  else if([_incomingSegue isEqual:@"energy"]){
            [segue.destinationViewController setIncomingSegue:@"energy"];
            News* controller = [segue destinationViewController];
            _currentTopic = @"energy";
            controller.note = @"article";
            controller.currentTopic = _currentTopic;
            controller.pageNumber = 0;
        }
    } else if([segue.identifier isEqualToString:@"showPuzzle"]) {
        if([_incomingSegue isEqual:@"computing"]) {
            [segue.destinationViewController setIncomingSegue:@"computing"];
            PuzzleNavigation* controller = [segue destinationViewController];
            controller.currentTopic = _currentTopic;
            controller.fileName = @"wordsearch.png";
            NSLog(@"Segue to Puzzle Nav");
        } else if ([_incomingSegue isEqual:@"energy"]) {
            [segue.destinationViewController setIncomingSegue:@"energy"];
            PuzzleNavigation* controller = [segue destinationViewController];
            controller.currentTopic = _currentTopic;
            controller.fileName = @"wordsearchenergy.png";
            NSLog(@"Segue to Puzzle Nav");
        }
    }
}

@end
