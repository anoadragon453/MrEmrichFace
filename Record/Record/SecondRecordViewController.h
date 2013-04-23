//
//  SecondRecordViewController.h
//  Record
//
//  Created by Andrew Morgan on 4/22/13.
//  Copyright (c) 2013 Andrew Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface SecondRecordViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

- (IBAction)recordPressed:(id)sender;
- (IBAction)playPressed:(id)sender;
- (IBAction)stopPressed:(id)sender;

@end
