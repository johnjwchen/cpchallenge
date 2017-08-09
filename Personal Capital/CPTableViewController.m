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
#import "CPMainArticleTableViewCell.h"
#import "CPPreviousArticleTableViewCell.h"
#import "CPPreviousArticleHeaderView.h"

@interface CPTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CPChannelSource *source;
@end

static NSString * const kCPMainArticleTableViewCell = @"CPMainArticleTableViewCell";
static NSString * const kCPPreviousArticleTableViewCell = @"CPPreviousArticleTableViewCell";
static NSString * const kCPPreviousArticleHeaderView = @"CPPreviousArticleHeaderView";

//static CGFloat ratioOfArticleCellHeightWidth = 0.7;

@implementation CPTableViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidLoad {
    self.title = @"Investing – Daily Capital";
    _source = [[CPChannelSource alloc] initWithFeedURLString:RSSFeedURL];
    [_source addObserver:self forKeyPath:@"articles" options:0 context:nil];
    [_source addObserver:self forKeyPath:@"error" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.tableView registerClass:[CPMainArticleTableViewCell class] forCellReuseIdentifier:kCPMainArticleTableViewCell];
    [self.tableView registerClass:[CPPreviousArticleTableViewCell class] forCellReuseIdentifier:kCPPreviousArticleTableViewCell];
    [self.tableView registerClass:[CPPreviousArticleHeaderView class] forCellReuseIdentifier:kCPPreviousArticleHeaderView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.delegate = nil;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadSource)];
}
- (void)reloadSource {
    [_source load];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.tableView.delegate == nil) {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [_source load];
    }
}

#pragma mark - Tableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 2;
    else return _source.articles.count / 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
        CPMainArticleTableViewCell *mainArticleCell = (CPMainArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCPMainArticleTableViewCell];
        [mainArticleCell setArticle:_source.articles.firstObject];
        [mainArticleCell setNeedsLayout];
        [mainArticleCell layoutIfNeeded];
        return mainArticleCell;
        }
        else {
            CPPreviousArticleHeaderView *headerViewCell = (CPPreviousArticleHeaderView*)[tableView dequeueReusableCellWithIdentifier:kCPPreviousArticleHeaderView];
            headerViewCell.label.text = @"Previous Articles";
            return headerViewCell;
        }
    }
    else {
        CPPreviousArticleTableViewCell *previewArticleCell = (CPPreviousArticleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCPPreviousArticleTableViewCell];
        id<ArticleItem> leftArticle = _source.articles[2*(indexPath.row+1)-1];
        id<ArticleItem> rightArticle = 2*(indexPath.row+1) < _source.articles.count ? _source.articles[2*(indexPath.row+1)] : nil;
        [previewArticleCell setLeftArticle:leftArticle rightArticle:rightArticle];
        [previewArticleCell.contentView setNeedsLayout];
        [previewArticleCell.contentView layoutIfNeeded];
        return previewArticleCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return indexPath.row == 0? [CPMainArticleTableViewCell rowHeight] : 36;
    }
    else {
        return [CPPreviousArticleTableViewCell rowHeight];
    }
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
