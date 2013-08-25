//
//  RootViewController.m
//  ExpandTableDemo
//
//  Created by ligf on 13-7-5.
//  Copyright (c) 2013年 yonyou. All rights reserved.
//

#import "RootViewController.h"
#define originalHeight 25.0f
#define isOpen @"85.0f"

@interface RootViewController ()

@end

@implementation RootViewController
{
    NSMutableDictionary *dicClicked;  // 用于标识单击了的Cell
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    dicClicked = [NSMutableDictionary dictionaryWithCapacity:3];
//    dicClicked = [NSMutableDictionary dictionaryWithCapacity:3];
    dicClicked = [[NSMutableDictionary alloc] initWithCapacity:3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [arrayData count];
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[dicClicked objectForKey:indexPath] isEqualToString: isOpen])
    {
        return [[dicClicked objectForKey:indexPath] floatValue];
    }
    else
    {
        return originalHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *name = (indexPath.row % 2 == 0) ? @"listbg_odd_ico" : @"listbg_even_ico";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]] autorelease];
    
    NSString *statisticsContent = [[NSString alloc] initWithString:@"岁月流芳，花开几度，走在岁月里，醉在流香里，总在时光里辗转徘徊。花开几许，落花几度，岁月寒香，飘进谁的诗行，一抹幽香，掺入几许愁伤，流年似花，春来秋往，睁开迷离的双眼，回首张望，随风的尘烟荡漾着迷忙，昨日的光阴已逝去，留下无尽的回忆让人留恋与追忆"];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.text = statisticsContent;
    cell.textLabel.textColor = [UIColor brownColor]
    ;
    cell.textLabel.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制
    cell.textLabel.numberOfLines = 8;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
    if (targetCell.frame.size.height == originalHeight)
    {
        [dicClicked setObject:isOpen forKey:indexPath];
    }
    else
    {
        [dicClicked removeObjectForKey:indexPath];
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
