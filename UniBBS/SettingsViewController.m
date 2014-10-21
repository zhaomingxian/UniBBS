//
//  SettingsViewController.m
//  UniBBS
//
//  Created by Shengbin Meng on 10/21/14.
//  Copyright (c) 2014 Peking University. All rights reserved.
//

#import "SettingsViewController.h"
#import "WebViewController.h"
#import "SettingModel.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"更多";
        self.tabBarItem.image = [UIImage imageNamed:@"settings"];
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


#pragma mark - Table View delegate and data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    }
    return 1;
}

- (void) switchChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
    [SettingModel setBoolUsePostSuffixString:switchControl.on];
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DefaultStyleCell"];
        if(cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultStyleCell"] autorelease];
        }
        if ([indexPath row] == 0) {
            [cell.textLabel setText:@"打开小尾巴"];
            //add a switch
            UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
            [switchview addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            [switchview setOn:[SettingModel boolUsePostSuffixString] animated:NO];
            cell.accessoryView = switchview;
            [switchview release];
        }
        return cell;
    }
    
    if ([indexPath section] == 1) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Value1StyleCell"];
        if(cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Value1StyleCell"] autorelease];
        }
        
        if ([indexPath row] == 0) {
            [cell.textLabel setText:@"关于此应用"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if ([indexPath row] == 1) {
            [cell.textLabel setText:@"关于开发者"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if ([indexPath row] == 2) {
            [cell.textLabel setText:@"未名站点"];
            [cell.detailTextLabel setText:@"将打开浏览器访问"];
        }
        return cell;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *header = @"";
    if (section == 0) {
        header = @"设置";
    }
    if (section == 1) {
        header = @"关于";
    }
    return header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *footerText = @"";
    if (section == 0) {
        footerText = [NSString stringWithFormat:@"打开小尾巴就是在您发布的消息结尾加上“发自我的北大未名iOS客户端”字样"];
    }
    return footerText;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([indexPath section] == 1) {
        if ([indexPath row] == 0) {
            WebViewController *aboutViewController =[[[WebViewController alloc] init] autorelease];
            aboutViewController.webAddress = @"http://unibbs.sinaapp.com/bdwm";
            [self.navigationController pushViewController:aboutViewController animated:YES];
            return;
        }
        if ([indexPath row] == 1) {
            WebViewController *aboutViewController =[[[WebViewController alloc] init] autorelease];
            aboutViewController.webAddress = @"http://unibbs.sinaapp.com/authors";
            [self.navigationController pushViewController:aboutViewController animated:YES];
            return;
        }
        if ([indexPath row] == 2) {
            [[UIApplication sharedApplication] openURL:[[[NSURL alloc] initWithString:@"http://www.bdwm.net/bbs"] autorelease]];
            return;
        }
    }
}

@end