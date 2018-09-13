//
//  ASCollectionNodeController.m
//  ASCollectionComponent_Example
//
//  Created by 吴哲 on 2018/9/11.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeController.h"
#import "ASMainComponent.h"
#import "ASCollectionSectionPinToVisibleBoundsLayout.h"

@interface ASCollectionNodeController ()
/// rootComponent
@property(nonatomic ,strong) ASCollectionNodeRootComponent *rootComponent;
@end

@implementation ASCollectionNodeController

- (instancetype)init
{
    ASCollectionSectionPinToVisibleBoundsLayout *layout = [[ASCollectionSectionPinToVisibleBoundsLayout alloc] init];
    layout.needSectionHeadersPinToVisibleBounds = YES;
    layout.needSectionFootersPinToVisibleBounds = YES;
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithNode:[[ASCollectionNode alloc] initWithCollectionViewLayout:layout]];
    if (self) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        ((ASCollectionNode *)self.node).view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _rootComponent = [[ASCollectionNodeRootComponent alloc] initWithCollectionNode:(ASCollectionNode *)self.node];
    ASMainComponent *mainComponent = [[ASMainComponent alloc] init];
    _rootComponent.subComponents = @[mainComponent];
    
    [((ASCollectionNode *)self.node) reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
