//
//  ViewController_CoreData.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/25.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_CoreData.h"
#import "MYCoreDataManager.h"
#import "Person.h"

@interface ViewController_CoreData ()

@end

@implementation ViewController_CoreData

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CoreData";
    
    [[MYCoreDataManager defaultManager] deleteAllObjects:@"Person"];
    
    Person *object = (Person *)[[MYCoreDataManager defaultManager] createObjectWithEntity:@"Person"];
    object.name = @"忘忧草止水";
    object.age = [NSNumber numberWithInteger:24];
    [[MYCoreDataManager defaultManager] saveContext];
    
    NSArray *objects = [[MYCoreDataManager defaultManager] fetchObjectsWithEntity:@"Person" predicate:nil sort:nil];
    NSEnumerator *enumerator = [objects objectEnumerator];
    Person *objec;
    while (objec = [enumerator nextObject]) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"来自core data:%@，年龄:%@", objec.name, objec.age] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        //        [[MYCoreDataManager defaultManager] deleteObject:objec];
    }
    //    [[MYCoreDataManager defaultManager] saveContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
