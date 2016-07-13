//
//  ViewController.h
//  To-do List2.0
//
//  Created by lxh_miao on 16/7/9.
//  Copyright © 2016年 lxh_miao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *titleField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearButton;
@property (copy, nonatomic) NSMutableArray *tasks;

- (IBAction)insertTasks:(UIButton *)sender;
- (IBAction)clearTasks:(UIBarButtonItem *)sender;
- (IBAction)deleteTasks:(UIBarButtonItem *)sender;
@end

