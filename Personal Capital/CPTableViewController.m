//
//  ViewController.m
//  Personal Capital
//
//  Created by JIAWEI CHEN on 8/6/17.
//
//

#import "CPTableViewController.h"
#import "Constants.h"
#import "CPChannelSource.h"

@interface CPTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CPChannelSource *source;
@end

@implementation CPTableViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    _source = [[CPChannelSource alloc] initWithFeedURLString:RSSFeedURL];
    [_source addObserver:self forKeyPath:@"articles" options:0 context:nil];
    [_source addObserver:self forKeyPath:@"error" options:NSKeyValueObservingOptionNew context:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - Tableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    else return _source.articles.count / 2;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) return @"Previous Articles";
    else return nil;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Tableview Delegate


#pragma mark - Datasoure change

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kArticles]) {
        // reload table
        [self.tableView reloadData];
    }
    else if ([keyPath isEqualToString:kError] && _source.error != nil) {
        // show error
        NSString *errorMessage = _source.error.localizedDescription;
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        [alertViewController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alertViewController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertViewController animated:YES completion:nil];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}



@end
