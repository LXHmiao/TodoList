//
//  ViewController.m
//  To-do List2.0
//
//  Created by lxh_miao on 16/7/9.
//  Copyright © 2016年 lxh_miao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 初始化任务数组
    _tasks = [NSMutableArray array];
    // 将删除按钮初始化为不可用
    self.deleteButton.enabled = NO;
    
}

#pragma mark - 必须实现的数据源方法之一，在此处处理刷新tableView时出现的各种事件
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 当任务数变为0时使删除按钮和清空按钮不可用以及推出tableView的编辑状态
    if (self.tasks.count == 0) {
        self.titleField.text = @"To-do List";
        self.deleteButton.enabled = NO;
        self.clearButton.enabled = NO;
        self.tableView.editing = NO;
    }else {
        NSString *title = [NSString stringWithFormat:@"To-do List  (%ld)", self.tasks.count];
        self.titleField.text = title;
        self.deleteButton.enabled = YES;
        self.clearButton.enabled = YES;
    }
    //  返回_tasks中的任务个数
    return self.tasks.count;
}

#pragma mark - 必须实现的数据源方法之一，返回cell显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 定义标识用以cell的重新使用，提高性能
    static NSString *ID = @"cell";
    
    // 重新使用带有ID标识的cell，如果没有则新建一个带ID标识的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSString *task = self.tasks[indexPath.row];
    cell.textLabel.text = task;
    
    return cell;
}

#pragma mark - 提交编辑 并进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 当编辑类型为删除类型才进行删除操作
    if (editingStyle != UITableViewCellEditingStyleDelete)  return;
    // 在_tasks模型中移除当前对象，然后刷新tableView
    [self.tasks removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 插入任务操作，点击insert将输入的tasks加入_tasks并在tableView显示
- (IBAction)insertTasks:(UIButton *)sender {
    // 点击按钮即将editing初始化
    self.tableView.editing = NO;
    // 取出输入的内容
    NSString *text = self.textField.text;
    if (text.length == 0) {
        return;
    }
//    
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"MM-dd HH:mm";
//    NSString *time = [formatter stringFromDate:date];
    // 将取出的内容加入_tasks中
    NSString *task = text;
    //[NSString stringWithFormat:@"%@  %@", time, text];
    [self.tasks addObject:task];
    
    // 刷新tableView
    [self.tableView reloadData];
    
    // 最后将textField清空
    [self.textField setText:@""];
    [self.textField resignFirstResponder];
}

#pragma mark - 清空任务操作，采用了UIAlertController，点击按钮后弹框
- (IBAction)clearTasks:(UIBarButtonItem *)sender {
    // 新建一个UIAlertController并显示
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete all tasks or not" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    // 新建两个UIAlertAction按钮并处理相应的事件
    UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.tasks removeAllObjects];
        
        [self.tableView reloadData];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    // 将UIAlertAction加入到UIAlertController中
    [alertController addAction:Ok];
    [alertController addAction:cancel];
}

#pragma mark - 点击delete按钮进入tableView编辑模式
- (IBAction)deleteTasks:(UIBarButtonItem *)sender {
    BOOL result = !self.tableView.editing;
    [self.tableView setEditing:result animated:YES];
    
}
@end
