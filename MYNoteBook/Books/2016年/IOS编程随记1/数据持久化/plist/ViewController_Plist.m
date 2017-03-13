//
//  ViewController_Plist.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/25.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_Plist.h"

@interface ViewController_Plist ()

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController_Plist

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Plist";
    NSString *filePath = [self dataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        for(int i = 0; i < [array count]; i++){
            [(UILabel *)_lineFields[i] setText:array[i]];
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    // Do any additional setup after loading the view.
}

- (NSString *)dataFilePath{
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [paths stringByAppendingPathComponent:@"data.plist"];
}

- (void)applicationWillResignActive{
    NSString *filePath = [self dataFilePath];
    NSArray *array = [_lineFields valueForKey:@"text"];
    [array writeToFile:filePath atomically:YES];
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
