//
//  ViewController_Ticket_Purchasse.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/25.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_Ticket_Purchasse.h"
#import "Ticket.h"

@interface ViewController_Ticket_Purchasse ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@property (strong, nonatomic) NSMutableString *logStr;

@property (strong, nonatomic) NSOperationQueue *queue;



@end

@implementation ViewController_Ticket_Purchasse

- (void)viewDidLoad {
    [super viewDidLoad];
    _logStr = [NSMutableString string];
    self.title = @"购票系统";
    _segmentedControl.selectedSegmentIndex = 3;
    _queue = [NSOperationQueue currentQueue];
    // Do any additional setup after loading the view.
}

- (IBAction)onClickTicketPurchase:(id)sender {
    Ticket *ticket = [Ticket sharedTicket];
    if(ticket.ticket == 0){//复位
        ticket.ticket = 100;
        [_logStr setString:@""];
    }
    
     for(int i = 1; i <= 101 ; i++){//售票系统总票数：10张

    switch (_segmentedControl.selectedSegmentIndex) {
         case 0:
            [self multi_Thread_NSObject:i];
            break;
         case 1:
            [self multi_Thread_NSThread:i];
            break;
         case 2:
            [self multi_Thread_NSOperation:i];
            break;
         case 3:
            [self multi_Thread_GCD:i];
         default:
            break;
    }
    }
}


- (void)multi_Thread_GCD:(NSInteger)i{
       __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        Ticket *ticket = [Ticket sharedTicket];
        if(ticket.ticket > 0){
            [weakSelf.logStr appendFormat:@"用户%ld购票成功，票数剩余%ld\n", (long)i, (long)-- ticket.ticket];
        }else{
            [weakSelf.logStr appendFormat:@"购票失败，余票不足！\n"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.logTextView setText:weakSelf.logStr];
        });
    });
}


- (void)multi_Thread_NSObject:(NSInteger)i{
    [self performSelectorInBackground:@selector(nsObjectSubMethod:) withObject:[NSNumber numberWithInteger:i]];
}
- (void)nsObjectSubMethod:(NSNumber *)integer{
   NSInteger  i = [integer integerValue];
    __weak typeof(self) weakSelf = self;
        NSLog(@"%@",[NSThread currentThread]);
        Ticket *ticket = [Ticket sharedTicket];
        if(ticket.ticket > 0){
            [weakSelf.logStr appendFormat:@"用户%ld购票成功，票数剩余%ld\n", (long)i, (long)-- ticket.ticket];
        }else{
            [weakSelf.logStr appendFormat:@"购票失败，余票不足！\n"];
        }
    [self performSelectorOnMainThread:@selector(nsObjectMainMethod) withObject:nil waitUntilDone:NO];
}
- (void)nsObjectMainMethod{
    [self.logTextView setText:self.logStr];
}


- (void)multi_Thread_NSOperation:(NSInteger)i{
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(nsOperationSubMethod:) object:[NSNumber numberWithInteger:i]];
//    [operation start];
    
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        [self nsoperationSubMethod:i];
//    }];
    [_queue addOperation:operation];
}
- (void)nsOperationSubMethod:(NSNumber *)integer{
    NSInteger  i = [integer integerValue];
    __weak typeof(self) weakSelf = self;
    NSLog(@"%@",[NSThread currentThread]);
    Ticket *ticket = [Ticket sharedTicket];
    if(ticket.ticket > 0){
        [weakSelf.logStr appendFormat:@"用户%ld购票成功，票数剩余%ld\n", (long)i, (long)-- ticket.ticket];
    }else{
        [weakSelf.logStr appendFormat:@"购票失败，余票不足！\n"];
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [weakSelf.logTextView setText:weakSelf.logStr];
    }];
}


- (void)multi_Thread_NSThread:(NSInteger)i{
    [NSThread detachNewThreadSelector:@selector(nsthreadSubMethod:) toTarget:self withObject:[NSNumber numberWithInteger:i]];
//        NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(nsoperationSubMethod:) object:[NSNumber numberWithInteger:i]];
//    [thread start];
}
- (void)nsthreadSubMethod:(NSNumber *)integer{
    NSInteger  i = [integer integerValue];
    __weak typeof(self) weakSelf = self;
    NSLog(@"%@",[NSThread currentThread]);
    Ticket *ticket = [Ticket sharedTicket];
    if(ticket.ticket > 0){
        [weakSelf.logStr appendFormat:@"用户%ld购票成功，票数剩余%ld\n", (long)i, (long)-- ticket.ticket];
    }else{
        [weakSelf.logStr appendFormat:@"购票失败，余票不足！\n"];
    }
     [self performSelectorOnMainThread:@selector(nsObjectMainMethod) withObject:nil waitUntilDone:NO];
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
