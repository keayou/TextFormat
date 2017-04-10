//
//  ZZFormartManager.m
//  TextFormat
//
//  Created by fk on 2017/4/10.
//  Copyright © 2017年 zhouzhou. All rights reserved.
//

#import "ZZFormartManager.h"
#import "ZZFormatEditModel.h"

@implementation ZZFormartManager
+ (ZZFormartManager *)sharedInstance {
    
    static ZZFormartManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZZFormartManager alloc]init];
    });
    return manager;
}


- (void)saveCustomFormartInfo:(ZZFormatEditModel *)editMode {
    
    if (editMode) {
        NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:editMode];
        [[NSUserDefaults standardUserDefaults] setObject:archivedData forKey:@"kFormatEditArchiver"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (ZZFormatEditModel *)fetchCustomFormartInfo {
    
    NSData *archivedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"kFormatEditArchiver"];
    
    ZZFormatEditModel *editMode = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    
    return editMode;
}

@end
