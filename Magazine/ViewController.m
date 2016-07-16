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

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.playerView loadWithVideoId:@"lZxJgTiKDis"];
    [self prepareNavigationMenu];
    [self prepareMenu];
    UILabel *label = _article1.titleLabel;
    label.adjustsFontSizeToFitWidth = YES;
    _currentTopic = @"computing";
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
        controller.fileName = @"materialtime";
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showArticle"]) {
        ArticleViewing* controller = [segue destinationViewController];
        controller.fileName = @"article";
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showPuzzle"]) {
        Puzzle* controller = [segue destinationViewController];
        //aroundtheworld not aroundtheworld.jpg because the scrollview appends the filetype in the method
        controller.currentTopic = _currentTopic;
    } else if([segue.identifier isEqualToString:@"showWorld"]) {
        ArticleViewing* controller = [segue destinationViewController];
        //aroundtheworld not aroundtheworld.jpg because the scrollview appends the filetype in the method
        controller.currentTopic = _currentTopic;
    }
}

- (IBAction)menuPressed:(id)sender {
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
            break;
        case 1:
            NSLog(@"Transition to Energy");
            _currentTopic = @"energy";
            [_menu hideCircularMenu];
            _isMenuActive = false;
            [self.menuButton setImage:[UIImage imageNamed:@"circleChevronUp.png"] forState:UIControlStateNormal];

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
