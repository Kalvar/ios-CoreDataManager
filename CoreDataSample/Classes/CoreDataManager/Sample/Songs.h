//
//  Songs.h
//  MusicPlayer
//
//  Created by Kalvar on 2014/1/1.
//  Copyright (c) 2014年 Kalvar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Songs : NSManagedObject

@property (nonatomic, retain) NSNumber * albumId;
@property (nonatomic, retain) NSString * albumName;
@property (nonatomic, retain) NSNumber * songId;
@property (nonatomic, retain) NSString * songName;
@property (nonatomic, retain) NSString * playType;

#pragma --mark INSERT
+(BOOL)insertSongId:(NSNumber *)_songId
           songName:(NSString *)_songName
            albumId:(NSNumber *)_albumId
          albumName:(NSString *)_albumName
           playType:(NSString *)_playType;

#pragma --mark SELECT
+(NSArray *)selectSongsForPlayType:(NSString *)_playType;

+(Songs *)selectOneSongForSongId:(NSNumber *)_songId;

#pragma --mark DELETE
+(void)deleteOneSongForSongId:(NSNumber *)_songId;

#pragma --mark Update
+(void)updateOneSongForSongId:(NSNumber *)_songId withSongName:(NSString *)_songName;

@end
