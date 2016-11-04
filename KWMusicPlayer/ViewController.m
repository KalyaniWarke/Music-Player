//
//  ViewController.m
//  KWMusicPlayer
//
//  Created by Student P_03 on 04/11/16.
//  Copyright © 2016 kalyaniWarke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    isPlaying = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)initialzeAudioplayer{
    BOOL status =false;
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"myMusic" withExtension:@"mp3"];
    if (musicURL !=nil) {
        NSError *error;
        myAudioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
        if (error!=nil) {
            NSLog(@"%@",error.localizedDescription);
        }
        else{
            status = true;
        }
        
    }
    AVURLAsset *asset =[AVURLAsset URLAssetWithURL:musicURL options:nil];
    NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
    
    NSArray *artists =[AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon];
    NSArray *albumNames = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyAlbumName keySpace:AVMetadataKeySpaceCommon];
    AVMetadataItem *title =[titles objectAtIndex:0];
    AVMetadataItem *artist = [artists objectAtIndex:0];
    AVMetadataItem *albumName =[albumNames objectAtIndex:0];
    
    NSArray *key= [NSArray arrayWithObjects:@"commonMetaData", nil];
    [asset loadValuesAsynchronouslyForKeys:key completionHandler:^{
      
        NSArray *artWorks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtwork keySpace:AVMetadataKeySpaceCommon];
        for (AVMetadataItem *item in artWorks){
            if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
               
                NSData *data =[item.value copyWithZone:nil];
                UIImage *image = [UIImage imageWithData:data];
                self.imageView.image=image;
            }
            else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]){
                self.imageView.image=[UIImage imageWithData:[item.value copyWithZone:nil]];
            }
        }
    }];
    return status;
}

- (IBAction)playPauseAction:(id)sender {
    UIButton *button = sender;
    if ([button.currentImage isEqual:[UIImage imageNamed:@"play.jpeg"]]) {
        if(isPlaying ){
            [myAudioPlayer play];
        }
        else {
            if ([self initialzeAudioplayer]) {
                [myAudioPlayer play];
                isPlaying=true;
            }
            else{
                NSLog(@"something wents to wrong while initialzing audio player");

                }
            }
        [button setImage:[UIImage imageNamed:@"pause.jpeg"] forState:UIControlStateNormal];
        }
    else if ([button.currentImage isEqual:[UIImage imageNamed:@"pause.jpeg"]]){
        
        [myAudioPlayer pause];
        [button setImage:[UIImage imageNamed:@"play.jpeg"] forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)stopAction:(id)sender {
    
    [myAudioPlayer stop];
    isPlaying = false;
    [self.playButton setTitle:@"play" forState:UIControlStateNormal];
}
@end
