//
//  fileListTableViewController.m
//  mySubmit
//
//  Created by demo on 2018/5/6.
//  Copyright © 2018年 demo. All rights reserved.
//

#import "fileListTableViewController.h"
#import "fileListTableViewCell.h"

@interface fileListTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *fileListTableView;


@end

@implementation fileListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fileListTableView.delegate = self;
    self.fileListTableView.dataSource = self;
   // [self.tableView registerNib:nil forCellReuseIdentifier:@"fileListTableViewCell"];
    //[self.fileListTableView registerClass:[fileListTableViewCell class] forCellReuseIdentifier:@"fileListTableViewCell"];
//    [self.tableView registerClass: forCellReuseIdentifier:@"fileListTableViewCell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
#warning Incomplete implementation, return the number of rows
    //return self.fileList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    fileListTableViewCell *cell = (fileListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"fileListTableViewCell"];
    //cell.backgroundColor = [UIColor clearColor];
    if (cell) {
        cell.fileNameLabel.text = @"格子";
        cell.fileTypeLabel.text = @"详细";
    }
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
