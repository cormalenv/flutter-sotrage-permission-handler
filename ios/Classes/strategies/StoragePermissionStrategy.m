//
//  StoragePermissionStrategy.m
//  storage_permissions
//
//  Created by Frank Gregor on 06.11.19.
//

#import "StoragePermissionStrategy.h"

@implementation StoragePermissionStrategy

- (PermissionStatus)checkPermissionStatus:(PermissionGroup)permission {
    return [StoragePermissionStrategy permissionStatus];
}

- (ServiceStatus)checkServiceStatus:(PermissionGroup)permission {
    return ServiceStatusNotApplicable;
}

- (void)requestPermission:(PermissionGroup)permission completionHandler:(PermissionStatusHandler)completionHandler {
    completionHandler([StoragePermissionStrategy permissionStatus]);
}

+ (PermissionStatus)permissionStatus {
    return PermissionStatusGranted;
}

@end
