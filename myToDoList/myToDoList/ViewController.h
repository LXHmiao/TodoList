//
//  ViewController.h
//  myToDoList
//
//  Created by lxh_miao on 16/7/3.
//  Copyright © 2016年 lxh_miao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteItem;

@property (nonatomic) NSMutableArray *tasks;

- (IBAction)clear:(UIBarButtonItem *)sender;

- (IBAction)addItem:(UIButton *)sender;

- (IBAction)deleteItem:(UIBarButtonItem *)sender;


@end

