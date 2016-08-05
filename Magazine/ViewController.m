//
//  ViewController.m
//  Magazine
//
//  Created by MBPro on 6/22/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

/*
 
 Libraries Used:
 SwiftJSON - Parses JSON files in the map file in Swift
 WebImage - Downloads URL and caches it. Does NOT download if already in cache/storage
 Popover - The popover menu that appears in the map
 
 Libraries Not Currently Being Used:
 IGCMenu - The menu that stylizes a way to change the current topic
 AESCrypt - Encryption/Decryption used in Login.h/Login.m to secure username/password info
 
 */

#import "ViewController.h"
#import "Puzzle.h"
#import "News.h"
#import "IGCMenu.h"
#import "youtubeViewController.h"
#import "PuzzleNavigation.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController
    AVAudioPlayer *_audioPlayer;

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNumber = 0;
    _maxPageNumber = 4;
    _currentTopic = @"computing";
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    [self prepareNavigationMenu];
    [self prepareMenu];
     */
    [self setupScrollview];
    [self setupAudio];
    [self setCurrentActivity];
    _isScrollingEnabled = false;
    UIStoryboard *mainStoryboard = self.storyboard;

    /*In order to maintain the unique functionality found in our objects, we must make each 
     object a "child view controller" of our "parent view controller" (ViewController.m).
     We make it a child to maintain functionality and then add the view of this controller into our
     scrollView so we can actually see the contents of the child view controller 
     */
    
    //First Controller
    ViewController *mapController = [mainStoryboard instantiateViewControllerWithIdentifier:@"mapScene"];
    
    mapController.view.frame = CGRectMake (0,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    
    [self addChildViewController:mapController];
    [mapController didMoveToParentViewController:self];
    [self.scrollView addSubview:mapController.view];
    
    //Second Controller
    Puzzle *puzzleController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PuzzleScene"];
    puzzleController.filename = @"cipher.png";
    puzzleController.currentTopic = @"computing";
    CGRect frame = puzzleController.view.frame;
    frame.origin.x = 0;
    puzzleController.view.frame = CGRectMake (self.view.frame.size.width,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    puzzleController.view.contentMode = UIViewContentModeScaleToFill;
    
    [self addChildViewController:puzzleController];
    [puzzleController didMoveToParentViewController:self];
    puzzleController.view.autoresizesSubviews = YES;
    [self.scrollView addSubview:puzzleController.view];
    
    //Third Controller
    Puzzle *puzzleController2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"PuzzleScene"];
    puzzleController2.filename = @"howfastistheinternet.png";
    puzzleController2.currentTopic = @"computing";
    
    puzzleController2.view.frame = CGRectMake (self.view.frame.size.width*2,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height);
    
    [self addChildViewController:puzzleController2];
    [puzzleController2 didMoveToParentViewController:self];
    [self.scrollView addSubview:puzzleController2.view];

    //Fourth Controller
    youtubeViewController *youtubeController = [mainStoryboard instantiateViewControllerWithIdentifier:@"youtubeScene"];

    youtubeController.view.frame = CGRectMake (self.view.frame.size.width*3, self.view.frame.size.height/10, self.view.frame.size.width, self.view.frame.size.height/2-35);
    
    [self addChildViewController:youtubeController];
    [youtubeController didMoveToParentViewController:self];
    [self.scrollView addSubview:youtubeController.view];
    
    }

//This works with next/prevScreen to change the text of what activity we are looking at
-(void) setCurrentActivity {
    switch (_pageNumber) {
        case 0:
            _currentActivity.text = @"Computing Around the World";
            break;
        case 1:
            _currentActivity.text = @"Cipher Puzzle";
            break;
        case 2:
            _currentActivity.text = @"News: How Fast is the Internet?";
            break;
        case 3:
            _currentActivity.text = @"Computing for Kids";
            break;
        default:
            break;
    }
}

-(void) setupScrollview {
    self.scrollView.scrollEnabled = NO;
     self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];

}

/*
    nextScreen and prevScreen change the position of the scrollView that is currently being displayed
    view.frame.size.width is the width in pixels of one "page". Multiply this by the _pageNumber to 
    obtain the "page"'s x coordinate
 
 */
-(IBAction)nextScreen:(id)sender {
    if(_pageNumber + 1 < _maxPageNumber) {
    [_audioPlayer play];
    _pageNumber += 1;
    CGRect frame = _scrollView.frame;
    frame.origin.x = self.view.frame.size.width * _pageNumber;
    NSLog(@"Now: %f", frame.origin.x);
    [_scrollView setContentOffset:CGPointMake(frame.origin.x, 0) animated:YES];
        NSLog(@"sound");

    [self setCurrentActivity];

    }
}

-(IBAction)prevScreen:(id)sender {
    if(_pageNumber - 1 >= 0) {
        [_audioPlayer play];
    _pageNumber -= 1;
    CGRect frame = _scrollView.frame;
    frame.origin.x = self.view.frame.size.width * _pageNumber;

    [_scrollView setContentOffset:CGPointMake(frame.origin.x, 0) animated:YES];
        [self setCurrentActivity];

    }

}

/*
 
 The library used for this menu is called IGCMenu
 
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
 */


/*
 **

    prepareForSegue is where we pass the topic and filename for which we wish to display
    when we transition into a new scene. The new scene will load up by looking at its
    current topic and/or the filename and display content accordingly
 
 **
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [_audioPlayer play];
    if([segue.identifier isEqualToString:@"showNews"]) {
        News* controller = [segue destinationViewController];
        controller.fileName = @"article";
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 0;
    } else if([segue.identifier isEqualToString:@"showPuzzle"]) {
        PuzzleNavigation* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.fileName = @"wordsearch.png";
    } else if([segue.identifier isEqualToString:@"showWorld"]) {
        News* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
    }  else if([segue.identifier isEqualToString:@"showFirstArticle"]) {
        News* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 0; //figure out how to automate this
    }  else if([segue.identifier isEqualToString:@"showSecondArticle"]) {
        News* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.pageNumber = 9; //figure out how to automate this
    }   else if([segue.identifier isEqualToString:@"showFillInTheBlank"]) {
        PuzzleNavigation* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.fileName = @"fillintheblank.png";
    }   else if([segue.identifier isEqualToString:@"showMaterial"]) {
        PuzzleNavigation* controller = [segue destinationViewController];
        controller.currentTopic = _currentTopic;
        controller.fileName = @"material.png";
    }
}


/*
 This function was still a work in progress. I was trying to send a NSNotification to Puzzle.m
 that says stop being able to draw in the form of _isDrawingEnabled so that in the touchesMoved function
 in Puzzle.m, it would not draw.
 
 The big problem right now with enabling scrolling is that even if you disable drawing using this method
 (which DOES disable drawing), the touches are still being registered in the "child view controller" (search "child view controller to see"). So if we are able to redirect the touches
 from the child view to the "parent view" we would likely be able to enable scrolling. (after setting _scrollview.scrollEnabled = YES)
 */
-(IBAction) enableDisableScrolling:(id) sender {
    NSLog(@"Calling enableDisableScrolling. _isScrollingEnabled = %d", _isScrollingEnabled);
    if(_isScrollingEnabled) {
        //Scrolling is enabled -> Make it disabled
        self.scrollView.scrollEnabled = NO;
        [self notifyWithReason:@"enableDrawing"];
        //Disable Scrolling and send signal to embedded view controller that you cannot draw
        _isScrollingEnabled = false;
    } else {
        self.scrollView.scrollEnabled = YES;
        [self notifyWithReason:@"disableDrawing"];
        NSLog(@"Scrolling is enabled? %d", self.scrollView.scrollEnabled);
        _isScrollingEnabled = true;
    }
}


//We have this here so when you press the back button, it'll revert back to the default info
//Earlier, it would revert back to the default view but the currentActivity would not be default

-(void)viewWillAppear:(BOOL)animated
{
    _pageNumber = 0;
    CGRect frame = _scrollView.frame;
    frame.origin.x = 0;
    [self setCurrentActivity];
}
/*
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

 ** 
    This is where the _currentTopic is changed. By selecting one of the menus,
    currentTopic will change to either computing, energy, or materials. 
    In prepareForSegue, we pass the currentTopic variable to the other objects
    so that they know what topic we are in. In the other objects, they'll reference
    their own property value _currentTopic, which is now equal to whatever it was we 
    selected 
 **
 
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

*/


-(void) notifyWithReason: (NSString*) reason {
    [[NSNotificationCenter defaultCenter]postNotificationName:reason object:nil];
    NSLog(@"Called notification with reason: %@", reason);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 The sound that is currently being played is a mp3 file found in the project. This filename can be
 changed once there is a satisfactory sound found. Alternatively, if you wish to stop sounds for now, find [audioPlayer play] and comment it out.
 */
-(void) setupAudio{
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/drum01.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
}


@end
