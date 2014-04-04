//
//  CoreDataManager.h
//  CoreDataSample
//
//  Created by Kalvar on 2014/1/1.
//  Copyright (c) 2014年 Kalvar. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

//Core Data
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readonly) NSManagedObjectContext *backManagedObjectContext;
//Database Info
@property (nonatomic, strong) NSString *databaseName;

+(instancetype)sharedManager;

#pragma --mark Public Methods
-(NSEntityDescription *)getEntityWithName:(NSString *)_entityName;
-(NSDate *)getCurrentDate;
-(void)saveCoreDataContext;

#pragma --mark Insert Metohds
-(id)insertNewObjectForEntityForName:(NSString *)_entityName;

#pragma --mark Delete Methods
-(void)deleteOneObject:(NSManagedObject *)_oneObject;

#pragma --mark Update Metohds
-(void)updateOneObject:(NSManagedObject *)_oneObject;

@end
