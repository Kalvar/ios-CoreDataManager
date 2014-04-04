//
//  Songs.m
//  MusicPlayer
//
//  Created by Kalvar on 2014/1/1.
//  Copyright (c) 2014年 Kalvar. All rights reserved.
//

#import "Songs.h"
#import "CoreDataManager.h"

static NSString *_kEntityName = @"Songs";

@implementation Songs (fixCoreData)

+(CoreDataManager *)_getCoreDataManager
{
    return [CoreDataManager sharedManager];
}

+(NSManagedObjectContext *)_getManagedObjectContext
{
    return [self _getCoreDataManager].managedObjectContext;
}

+(NSEntityDescription *)_getEntityWithName:(NSString *)_entityName
{
    return [[self _getCoreDataManager] getEntityWithName:_kEntityName];
}

+(NSDate *)_getCurrentDate
{
    return [NSDate date];
}

@end

@implementation Songs

@dynamic albumId;
@dynamic albumName;
@dynamic songId;
@dynamic songName;
@dynamic playType;

#pragma --mark INSERT
+(BOOL)insertSongId:(NSNumber *)_songId
           songName:(NSString *)_songName
            albumId:(NSNumber *)_albumId
          albumName:(NSString *)_albumName
           playType:(NSString *)_playType
{
    Songs *_songs    = (Songs *)[[self _getCoreDataManager] insertNewObjectForEntityForName:_kEntityName];
    _songs.songId    = _songId;
    _songs.songName  = _songName;
    _songs.albumId   = _albumId;
    _songs.albumName = _albumName;
    _songs.playType  = _playType;
    return [[self _getManagedObjectContext] save:nil];
}

#pragma --mark SELECT
+(NSArray *)selectSongsForPlayType:(NSString *)_playType
{
    NSEntityDescription *_entity  = [self _getEntityWithName:_kEntityName];
    NSFetchRequest *_fetchRequest = [[NSFetchRequest alloc] init];
    [_fetchRequest setEntity:_entity];
    if( _playType )
    {
        if( [_playType length] > 0 )
        {
            NSPredicate *_selectPredicate = [NSPredicate predicateWithFormat:@"playType == %@", _playType];
            [_fetchRequest setPredicate:_selectPredicate];
        }
    }
    //Sort ASC with songName
    NSSortDescriptor *_sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"songName" ascending:YES];
	NSArray *_sortDescriptors         = [[NSArray alloc] initWithObjects:_sortDescriptor, nil];
	[_fetchRequest setSortDescriptors:_sortDescriptors];
    NSError *_error = nil;
    return (NSArray *)[[self _getManagedObjectContext] executeFetchRequest:_fetchRequest error:&_error];
}

+(Songs *)selectOneSongForSongId:(NSNumber *)_songId
{
    if( !_songId )
    {
        return nil;
    }
    NSEntityDescription *_entity  = [self _getEntityWithName:_kEntityName];
    NSFetchRequest *_fetchRequest = [[NSFetchRequest alloc] init];
    [_fetchRequest setEntity:_entity];
    if( [_songId longLongValue] != 0.0f )
    {
        NSPredicate *_selectPredicate = [NSPredicate predicateWithFormat:@"songId == %@", _songId];
        [_fetchRequest setPredicate:_selectPredicate];
    }
    NSError *_error   = nil;
    NSArray *_results = [[self _getManagedObjectContext] executeFetchRequest:_fetchRequest error:&_error];
    if( [_results count] > 0 )
    {
        return (Songs *)[_results firstObject];
    }
    return nil;
}

#pragma --mark DELETE
+(void)deleteOneSongForSongId:(NSNumber *)_songId
{
    Songs *_songs = [self selectOneSongForSongId:_songId];
    if( !_songs )
    {
        return;
    }
    [[self _getCoreDataManager] deleteOneObject:_songs];
}

#pragma --mark Update
+(void)updateOneSongForSongId:(NSNumber *)_songId withSongName:(NSString *)_songName
{
    NSManagedObjectContext *_managedObjectContext = [self _getManagedObjectContext];
    Songs *_songs   = [self selectOneSongForSongId:_songId];
    _songs.songName = _songName;
    [_managedObjectContext save:nil];
}


@end
