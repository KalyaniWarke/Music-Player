//
//  ViewController.h
//  KWMusicPlayer
//
//  Created by Student P_03 on 04/11/16.
//  Copyright © 2016 kalyaniWarke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
{
    AVAudioPlayer *myAudioPlayer;
    BOOL isPlaying;
    MPMediaLibrary *nowPlaying;
    
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)playPauseAction:(id)sender;
- (IBAction)stopAction:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *durationSlider;


@end

