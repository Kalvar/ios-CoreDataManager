//
//  CoreDataManager.m
//  CoreDataSample
//
//  Created by Kalvar on 2014/1/1.
//  Copyright (c) 2014年 Kalvar. All rights reserved.
//

#import "CoreDataManager.h"

static NSString *_kDatabaseName = @"Musics";

@implementation CoreDataManager (fixCoreData)

#pragma --mark Application Documents Directory
-(NSURL *)_getDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

@implementation CoreDataManager

@synthesize managedObjectContext       = _managedObjectContext;
@synthesize managedObjectModel         = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize backManagedObjectContext   = _backManagedObjectContext;
@synthesize databaseName               = _databaseName;

+(instancetype)sharedManager
{
    static dispatch_once_t pred;
    static CoreDataManager *_object = nil;
    dispatch_once(&pred, ^{
        _object = [[CoreDataManager alloc] init];
    });
    return _object;
}

#pragma --mark Public Methods
-(NSEntityDescription *)getEntityWithName:(NSString *)_entityName
{
    return [NSEntityDescription entityForName:_entityName inManagedObjectContext:self.managedObjectContext];
}

-(NSDate *)getCurrentDate
{
    return [NSDate date];
}

-(void)saveCoreDataContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            abort();
        }
    }
}

#pragma --mark Insert Metohds
-(id)insertNewObjectForEntityForName:(NSString *)_entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:_entityName
                                         inManagedObjectContext:self.managedObjectContext];
}

#pragma --mark Delete Methods
-(void)deleteOneObject:(NSManagedObject *)_oneObject
{
    NSManagedObjectContext *_objectContext = self.managedObjectContext;
    [_objectContext deleteObject:_oneObject];
    [_objectContext save:nil];
}

#pragma --mark Update Metohds
-(void)updateOneObject:(NSManagedObject *)_oneObject
{
    NSManagedObjectContext *_objectContext = self.managedObjectContext;
    assert(_oneObject);
    [_objectContext save:nil];
}

#pragma --mark Getters
/*
 * @ 建立 CoreData 模型
 */
-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL     = [[NSBundle mainBundle] URLForResource:self.databaseName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/*
 * @ 建立儲存庫協調者
 *   - 連結 CoreData 與 SQLite
 */
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    //連結儲存資料的 SQLite
    NSURL *storeURL = [[self _getDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", self.databaseName]];
    NSError *error  = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        abort();
    }
    return _persistentStoreCoordinator;
}

/*
 * @ 建立工作區( 內文 )
 */
-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    if (self.persistentStoreCoordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
    }
    return _managedObjectContext;
}

-(NSString *)databaseName
{
    if( !_databaseName )
    {
        _databaseName = _kDatabaseName;
    }
    return _databaseName;
}

#pragma --mark Setters
-(void)setDatabaseName:(NSString *)_theDatabaseName
{
    _databaseName = _theDatabaseName;
}

@end
