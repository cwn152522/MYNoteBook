//
//  ViewController_NSKeyedArchiver.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/25.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_NSKeyedArchiver.h"
#import "MYObject.h"

@interface ViewController_NSKeyedArchiver ()

@end

@implementation ViewController_NSKeyedArchiver

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSKeyedArchiver";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MYObject *object = [NSKeyedUnarchiver unarchiveObjectWithFile:[self datafilePath]];
    if(object){
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%ld岁的%@有个%ld岁的孩子叫%@", object.number, object.string, object.child.number, object.child.string] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)applicationWillResignActive{
    NSString *dataPath = [self datafilePath];
    MYObject *object = [[MYObject alloc] init];
    MYObject *child = [[MYObject alloc] init];
    
    child.number = 2;
    child.string = @"嗒呲";
    
    object.number = 24;
    object.string = @"嘣呲";
    object.child = child;
    [NSKeyedArchiver archiveRootObject:object toFile:dataPath];
}

- (NSString *)datafilePath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [path stringByAppendingPathComponent:@"data.suibian"];
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
