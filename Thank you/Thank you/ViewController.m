//
//  ViewController.m
//  Thank you
//
//  Created by Andrew Morgan on 4/22/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    AVAudioPlayer *player;
}

@end

@implementation ViewController
@synthesize soundRecorder;
@synthesize SoundPath;
@synthesize chin;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //AVAUdioRecorder Setup:
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir =[paths objectAtIndex:0];
    NSString *soundFilePath =[documentsDir stringByAppendingPathComponent:@"mysound.caf"];
    NSURL *newURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    self.SoundPath=newURL;
    recording = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This is when you would call the mouth up and down movements
- (IBAction)facePressed:(id)sender {
    //Rate is most likely temporary... It's hardly pitch.
    
    [self mouthMove];
    
    [self initializeAVAudioPlayer:@"mysound" fileExtension:@".caf" Volume:1.0f Rate:1.5f];
    [player play];
    
}

- (void)mouthMove{
    // Make the mouth move up and down. Doesn't have to match the voice...
    
    //while(true){
        //[self mouthMoveDown];
        [self performSelector:@selector(mouthMoveDown) withObject:nil afterDelay:1.0 ];
        //[self mouthMoveUp];
        [self performSelector:@selector(mouthMoveUp) withObject:nil afterDelay:1.0 ];
    //}
}

- (void)mouthMoveDown{
    
    CGRect chinFrame = self.chin.frame;
    chinFrame.origin.y = 360;
    NSLog(@"Move mouth down!");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.chin.frame = chinFrame;
    
    [UIView commitAnimations];
     /*
    [UIView animateWithDuration:1
                     animations:^{
                         CGRect chinFrame = self.chin.frame;
                         chinFrame.origin.y = 360;
                         NSLog(@"Move mouth down!");
                         [UIView beginAnimations:nil context:nil];
                         [UIView setAnimationDuration:0.5];
                         //[UIView setAnimationDelay:.5];
                         [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                         
                         self.chin.frame = chinFrame;
                         
                         [UIView commitAnimations];}
                     completion:^(BOOL finished){
                         
                         NSLog(@"Finished!");
                     }
     ];*/
}

- (void)mouthMoveUp{
    CGRect chinFrame = self.chin.frame;
    chinFrame.origin.y = 320;
    NSLog(@"Move mouth up!");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.chin.frame = chinFrame;
    
    [UIView commitAnimations];
}

- (void)mouthStop{
    // Make the Mouth return to the original position, ok if its not animated.
}

// Also need to initialize an AVAudioPlayer, like so:
// AVAudioPlayer *player;

// After initialization, the [player play] needs to run, where player is the AVAudioPlayer variable.

// You also need to make your interface in .h look like: @interface GirlAndBunnyViewController : UIViewController<AVAudioPlayerDelegate>

// Call initializeAVAudioPlayer with something similar to:

/*
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *dir = [paths objectAtIndex:0];
 dir = [dir stringByAppendingPathComponent:@"AppDir"];
 dir = [dir stringByAppendingPathComponent:[self getSongName]];
 dir = [dir stringByAppendingPathExtension:@"caf"];
 player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:dir]
 [player.delegate = self];
 [player play];
 */


- (void)initializeAVAudioPlayer:(NSString*) name fileExtension:(NSString*)fileExtension Volume:(float) volume Rate:(float) rate {
    //NSString *stringPath = [[NSBundle mainBundle]pathForResource:name ofType:fileExtension];
    //NSURL *url = [NSURL fileURLWithPath:stringPath];
    
    NSString* temp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* documentsPath = [temp stringByAppendingPathComponent:@"mysound.caf"];
    NSURL *url = [NSURL fileURLWithPath:documentsPath];
    
    NSError *error;
    
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [player setDelegate:(id)self];
    player.delegate = self;
    
    [player setVolume:volume];
    if(rate != 1.0f){
        player.enableRate = YES;
        player.rate = rate;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)data successfully:(BOOL)flag{
    NSLog(@"It finished playing!");
    [self mouthStop];
}

- (IBAction) recordOrStop: (id) sender {
    if (recording) {
        [soundRecorder stop];
        recording = NO;
        self.soundRecorder = nil;
        [recordOrStopButton setTitle: @"Record" forState:UIControlStateNormal];
        [recordOrStopButton setTitle: @"Record" forState:UIControlStateHighlighted];
        [[AVAudioSession sharedInstance] setActive: NO error: nil];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
    } else {
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryRecord error: nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        NSDictionary *recordSettings =[[NSDictionary alloc] initWithObjectsAndKeys:
                                       [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                                       [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                       [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                       [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey, nil];
        AVAudioRecorder *newRecorder =[[AVAudioRecorder alloc] initWithURL: SoundPath
                                                                  settings: recordSettings error: nil];
        soundRecorder = newRecorder;
        soundRecorder.delegate = self;
        [soundRecorder prepareToRecord];
        [soundRecorder record];
        [recordOrStopButton setTitle: @"Stop" forState: UIControlStateNormal];
        [recordOrStopButton setTitle: @"Stop" forState: UIControlStateHighlighted];
        recording = YES;
    }
}






@end
