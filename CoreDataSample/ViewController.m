//
//  ViewController.m
//  CoreDataSample
//
//  Created by Kalvar on 2014/1/1.
//  Copyright (c) 2014年 Kalvar. All rights reserved.
//

#import "ViewController.h"
#import "Songs.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark Database IBActions
-(void)insertSong
{
    //Insert
    [Songs insertSongId:@1
               songName:@"Free your source"
                albumId:@999
              albumName:@"Open source world"
               playType:@"Jazz"];
}

-(void)selectSongs
{
    //Select
    NSLog(@"songs for play type : %@", [Songs selectSongsForPlayType:@"Jazz"]);
    NSLog(@"songs for song id : %@", [Songs selectOneSongForSongId:@1]);
}

-(void)updateSong
{
    //Update
    [Songs updateOneSongForSongId:@1 withSongName:@"Jump up happy"];
}

-(void)deleteSong
{
    //Delete
    [Songs deleteOneSongForSongId:@1];
}

@end
