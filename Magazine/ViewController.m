//
//  ViewController.m
//  Magazine
//
//  Created by MBPro on 6/22/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "ViewController.h"
#import "Puzzle.h"
#import "ArticleViewing.h"
#import "IGCMenu.h"
#import "testViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNumber = 0;
    _maxPageNumber = 3;
    _currentTopic = @"computing";
    // Do any additional setup after loading the view, typically from a nib.
    [self.playerView loadWithVideoId:@"lZxJgTiKDis"];
    [self prepareNavigationMenu];
    [self prepareMenu];
    [self prepareHomepage];
    [self setupScrollview];
    
    UIStoryboard *mainStoryboard = self.storyboard;

    ViewController *testController = [mainStoryboard instantiateViewControllerWithIdentifier:@"testView"];
    
    CGRect frame = testController.view.frame;
    frame.origin.x = 0;
    testController.view.frame = CGRectMake (0,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    
    NSLog(@"width: %f height: %f", self.scrollView.frame.size.width, self.scrollView.frame.size.height);

    testController.view.contentMode = UIViewContentModeScaleToFill;
    
    [self addChildViewController:testController];
    [testController didMoveToParentViewController:self];
    testController.view.autoresizesSubviews = YES;
    [self.scrollView addSubview:testController.view];

    

    
    ViewController *mapController = [mainStoryboard instantiateViewControllerWithIdentifier:@"mapScene"];
    
    mapController.view.frame = CGRectMake (self.view.frame.size.width,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    
    [self addChildViewController:mapController];
    [mapController didMoveToParentViewController:self];
    [self.scrollView addSubview:mapController.view];
    
    
    ViewController *puzzleController2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"testView"];
    
    //CGRect puzzleFrame = mapController.view.frame;
    //puzzleFrame.origin.x = self.view.frame.size.width*2;
    //testController.view.frame = CGRectMake (self.view.frame.size.width*2,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);;
    puzzleController2.view.frame = CGRectMake (self.view.frame.size.width*2,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    
    [self addChildViewController:puzzleController2];
    [puzzleController2 didMoveToParentViewController:self];
    [self.scrollView addSubview:puzzleController2.view];

    }

-(void) setupScrollview {
    self.scrollView.scrollEnabled = NO;
     self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];
    
    
}

-(IBAction)nextScreen:(id)sender {
    if(_pageNumber + 1 < _maxPageNumber) {
    _pageNumber += 1;
    CGRect frame = _scrollView.frame;
    frame.origin.x = 768 * _pageNumber;
    NSLog(@"Now: %f", frame.origin.x);
    [_scrollView setContentOffset:CGPointMake(frame.origin.x, 0) animated:YES];
    }
}

-(IBAction)prevScreen:(id)sender {
    if(_pageNumber - 1 >= 0) {
    _pageNumber -= 1;
    CGRect frame = _scrollView.frame;
    frame.origin.x = 768 * _pageNumber;
    NSLog(@"Now: %f", frame.origin.x);

    [_scrollView setContentOffset:CGPointMake(frame.origin.x, 0) animated:YES];
    }

}

-(void) prepareHomepage {
    
    UILabel *label1 = _topArticle.titleLabel;
    label1.adjustsFontSizeToFitWidth = YES;
    UILabel *label2 = _bottomArticle.titleLabel;
    label2.adjustsFontSizeToFitWidth = YES;
    if([_currentTopic isEqualToString:@"computing"]) {
        [_coverPage setTitle:@"Cover Page: Computing" forState:UIControlStateNormal];
        [_bottomArticle setTitle: @"History of the Internet" forState: UIControlStateNormal];
        [_topArticle setTitle: @"Internet of Things" forState: UIControlStateNormal];
        _topArticlePageIndex = 2;
        _bottomArticlePageIndex = 0;
    } else if([_currentTopic isEqualToString:@"energy"]) {
        [_coverPage setTitle: @"Cover Page: Energy" forState:UIControlStateNormal];
        [_bottomArticle setTitle: @"The Grid?" forState: UIControlStateNormal];
        [_topArticle setTitle: @"Solar Power Overload" forState: UIControlStateNormal];
        _topArticlePageIndex = 0;
        _bottomArticlePageIndex = 2;
    }
}

-(void) prepareNavigationMenu {
    self.logoImage.contentMode =UIViewContentModeScaleAspectFit;
    self.puzzleButton.layer.cornerRadius = self.puzzleButton.frame.size.width/2;
    self.gameButton.layer.cornerRadius = self.gameButton.frame.size.width/2;
    self.triviaButton.layer.cornerRadius = self.triviaButton.frame.size.width/2;
    
}
-(void) prepareMenu {
    _menuButton.clipsToBounds = YES;
    _menuButton.layer.cornerRadius = self.menuButton.frame.size.width / 2;
    [_menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
    
    if(_menu == nil) {
        _menu = [[IGCMenu alloc] init];
    }
    _menu.menuButton = self.menuButton;
    _menu.menuSuperView = self.view;
    _menu.disableBackground = YES;
    _menu.numberOfMenuItem = 3;
    _menu.menuRadius = 125; //How far apart the menu displays
    _menu.menuHeight = 90; //Size of the circles
    _menu.menuItemsNameArray = [NSArray arrayWithObjects:@"Computing", @"Energy", @"Materials", nil];
    _isMenuActive = false;
    _menu.delegate = self;

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Hello");
    if([segue.identifier isEqualToString:@"showCipher"]) {
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"cipher";
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showWordSearch"]){
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"wordsearch";
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showFillInTheBlank"]){
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"fillintheblank";
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showMaterialTime"]){
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"material";
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showArticle"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.fileName = @"article";
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showPuzzle"]) {
        Puzzle* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showWorld"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
    }  else if([segue.identifier isEqualToString:@"showProject"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
    }  else if([segue.identifier isEqualToString:@"showTopArticle"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.pageToJumpTo = _topArticlePageIndex;
    }  else if([segue.identifier isEqualToString:@"showBottomArticle"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.pageToJumpTo = _bottomArticlePageIndex;
    }
}

- (IBAction)menuPressed:(id)sender {
    NSLog(@"Menu Pressed");
    if(_isMenuActive) {
        [_menu hideCircularMenu];
        _isMenuActive = false;
        [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
    } else {
        [_menu showCircularMenu];
        _isMenuActive = true;
        [self.menuButton setImage:[UIImage imageNamed:@"circleChevronDown.png"] forState:UIControlStateNormal];

    }
}

- (void)igcMenuSelected:(NSString *)selectedMenuName atIndex:(NSInteger)index{

    switch (index) {
        case 0:
            NSLog(@"Transition to Computing");
            _currentTopic = @"computing";
            [_menu hideCircularMenu];
            _isMenuActive = false;
            [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
            [self prepareHomepage];
            break;
        case 1:
            NSLog(@"Transition to Energy");
            _currentTopic = @"energy";
            [_menu hideCircularMenu];
            _isMenuActive = false;
            [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
            [self prepareHomepage];
            break;
        case 2:
            NSLog(@"Transition to Materials");
            _currentTopic = @"materials";
            [_menu hideCircularMenu];
            _isMenuActive = false;
            [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
