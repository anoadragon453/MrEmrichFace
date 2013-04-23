//
//  ViewController.h
//  Thank you
//
//  Created by Andrew Morgan on 4/22/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayer.h>

@interface ViewController : UIViewController
<AVAudioPlayerDelegate,AVAudioRecorderDelegate> {
    NSURL *SoundPath;
    IBOutlet UIButton *recordOrStopButton;
    bool recording;
    AVAudioRecorder *soundRecorder;
}
- (IBAction)facePressed:(id)sender;


@property(nonatomic,retain) NSURL *SoundPath;
@property(nonatomic,retain) AVAudioRecorder *soundRecorder;
- (IBAction) recordOrStop: (id) sender;
@end
