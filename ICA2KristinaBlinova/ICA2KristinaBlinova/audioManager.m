//
//  audioManager.m
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 09/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

#import "audioManager.h"
#import <AVFoundation/AVFoundation.h>

//Audio Players
 AVAudioPlayer *audioWeaponPlace;
 AVAudioPlayer *audioHeroPlace;
 AVAudioPlayer *audioClick;
 AVAudioPlayer *audioGetHero;
 AVAudioPlayer *audioSwipe;
 AVAudioPlayer *audioVictory;
 AVAudioPlayer *audioDefeat;

@implementation audioManager

//----------------------------------------
//             Initializer
//----------------------------------------
//This function is to be called right after constructor
-(void) initializePlayer
{
    //Lobby
    audioWeaponPlace = [[AVAudioPlayer alloc] initWithContentsOfURL:[self createSoundURL:@"%@/metalicSound.mp3"] error:nil];
    audioHeroPlace = [[AVAudioPlayer alloc] initWithContentsOfURL:[self createSoundURL:@"%@/placeHero.mp3"] error:nil];
    
    //General
    audioClick = [[AVAudioPlayer alloc] initWithContentsOfURL:[self createSoundURL:@"%@/click.mp3"] error:nil];
    
    //Result
    audioGetHero = [[AVAudioPlayer alloc] initWithContentsOfURL:[self createSoundURL:@"%@/getHero.mp3"] error:nil];
    
    //Fight
    audioSwipe = [[AVAudioPlayer alloc] initWithContentsOfURL:[self createSoundURL:@"%@/swipe.mp3"] error:nil];
    audioVictory = [[AVAudioPlayer alloc] initWithContentsOfURL:[self createSoundURL:@"%@/heroVictory.mp3"] error:nil];
    audioDefeat = [[AVAudioPlayer alloc] initWithContentsOfURL:[self createSoundURL:@"%@/defeat.mp3"] error:nil];
}

//----------------------------------------
//             Helper functions
//----------------------------------------
-(NSURL*)createSoundURL:(NSString*)soundPath
{
    NSString *path = [NSString stringWithFormat:soundPath, [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    return soundUrl;
}


//----------------------------------------
//         Play sound wrappers
//----------------------------------------
-(void) playPlaceWeaponAudio
{
    [audioWeaponPlace play];
}

-(void) playPlaceHeroAudio
{
    [audioHeroPlace play];
}

-(void) playClick
{
    [audioClick play];
}

-(void) playGetHero
{
    [audioGetHero play];
}

-(void) playSwipe
{
    [audioSwipe play];
}

-(void) playDefeat
{
    [audioDefeat play];
}

-(void) playVictory
{
    [audioVictory play];
}

@end
