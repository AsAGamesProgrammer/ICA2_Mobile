//
//  audioManager.h
//  ICA2KristinaBlinova
//
//  Created by BLINOVA, KRISTINA on 09/12/2017.
//  Copyright © 2017 BLINOVA, KRISTINA. All rights reserved.
//

//--------------------------------------------------------------------
//                          OVERVIEW
// This is an audio player class which holds and plays sounds
//--------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface audioManager : NSObject

-(void) initializePlayer;

//General
-(void) playClick;

//Lobby
-(void) playPlaceWeaponAudio;
-(void) playPlaceHeroAudio;

//Result
-(void) playGetHero;

//Fight
-(void) playVictory;
-(void) playDefeat;
-(void) playSwipe;

@end
