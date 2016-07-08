//
//  ViewController.m
//  myToDoList
//
//  Created by lxh_miao on 16/7/3.
//  Copyright © 2016年 lxh_miao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    NSMutableArray *_deleteTasks;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 初始化两个可变数组
    self.tasks = [NSMutableArray array];
    _deleteTasks = [NSMutableArray array];
    
    self.textField.placeholder = @"enter your task here";
    
    // 添加数据源为控制器本身，注意要满足UITableViewDataSource才能成为数据源
    self.tableView.dataSource = self;
}

#pragma mark 给tableView里面添加tasks
- (IBAction)addItem:(UIButton *)sender {
    // 取出textField中的内容
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd HH:mm";
    NSString *time = [formatter stringFromDate:date];
    NSString *text = [NSString stringWithFormat:@"%@  %@", time, [self.textField text]];
    if (text.length == 0) {
        return;
    }
    int count = 0;
    // 取出输入字符串中空格的个数
    for (int i = 0; i < [self.textField text].length; i++) {
        char c = [text characterAtIndex:i];
        if ( c == ' ') {
            count++;
        }
    }
    // 如果输入的全是空格则不加入_tasks
    if ([self.textField text].length != count) {
        // 将取得的text放入_tasks数组中
        [self.tasks addObject:text];
    }
    
    
    
    
    
    // 刷新tableView
    [self.tableView reloadData];
    
    // 重置textFiled
    [self.textField setText:@""];
    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  使用数据源协议必须实现的两个方法之一，返回tableView显示的行号
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // titleLable 的文本内容，显示出To-do List的条数， 打勾需要删除的不算
    if (self.tasks.count == 0) {
        self.titleLable.text = @"To-do List";
    }else {
        self.titleLable.text = [NSString stringWithFormat:@"To-do List  (%ld)", self.tasks.count];
    }
    
    // 当没有选中task时使得trash键unenable，选中时使其enable
    if (_deleteTasks.count == 0) {
        _deleteItem.enabled = NO;
    }else {
        _deleteItem.enabled = YES;
    }
    
    return [self.tasks count];
}

#pragma mark  使用数据源协议必须实现的两个方法之一，返回tableView每一行并显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 将标识抽出统一定义
    static NSString *ID = @"cell";
    // tableView 的性能优化，即从缓存池中取出已有的cell使用，这样就不需要每次都新alloc一个cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 如果缓存中没有已有的cell，再新建一个cell并加上标识
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    // 取出_tasks中的的tasks
    NSString *item = [self.tasks objectAtIndex:indexPath.row];
    
    
    // 然后将tasks赋值给cell的textLable
    cell.textLabel.text = item;
    
    // 判断该task是否在_deleteTasks中，如果在就打勾，不在就不打勾
    if ([_deleteTasks containsObject:item]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // 返回cell
    return cell;
    
}

#pragma mark 点击task选中操作，将选中的加入_deleteTasks数组以待删除，再点击取消加入
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"To-do" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//    UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
//    [alertController addAction:cancel];
//    [alertController addAction:ensure];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.placeholder = @"输入修改后的内容";
//        //textField.text = self.tasks[indexPath.row];
//    }];
//    [self presentViewController:alertController animated:YES completion:nil];
    
    
    // 取出当前点击的task以备加入_deleteTasks数组
    NSString *deleteTask = self.tasks[indexPath.row];
    
    // 判断是否在_deleteTasks数组中，如果已经在_deleteTasks数组中则从数组中移除，否则加入_deleteTasks数组
    if ([_deleteTasks containsObject:deleteTask]) {
        [_deleteTasks removeObject:deleteTask];
    }else {
        [_deleteTasks addObject:deleteTask];
    }
    
    // 刷新该行，并加上动画
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
    
}

#pragma mark UITableViewDelegate中的方法，更改行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark 删除选中的task
- (IBAction)deleteItem:(UIBarButtonItem *)sender {
//    self.tableView.editing = YES;
    NSMutableArray *deletePath = [NSMutableArray array];
    for (NSString *task in _deleteTasks) {
        NSUInteger index = [_tasks indexOfObject:task];
        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
        [deletePath addObject:path];
    }
    
    // 将待删除的task从_task数组移除，并将_deleteTasks数组清空
    [self.tasks removeObjectsInArray:_deleteTasks];
    [_deleteTasks removeAllObjects];
    
    // 刷新tableView数据
    [self.tableView deleteRowsAtIndexPaths:deletePath withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark 清除所有tasks
- (IBAction)clear:(UIBarButtonItem *)sender {
    
   
    [_tasks removeAllObjects];
    [_deleteTasks removeAllObjects];
    self.titleLable.text = @"To-do List";
    
    // 刷新tableView
    [self.tableView reloadData];
    
}


@end
