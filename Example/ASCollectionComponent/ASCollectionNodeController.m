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
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionHeadersPinToVisibleBounds = YES;
    layout.sectionFootersPinToVisibleBounds = YES;
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithNode:[[ASCollectionNode alloc] initWithCollectionViewLayout:layout]];
    if (self) {
        self.node.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _rootComponent = [[ASCollectionNodeRootComponent alloc] initWithCollectionNode:self.node isInterop:YES];
    ASMainComponent *mainComponent = [[ASMainComponent alloc] init];
    _rootComponent.subComponents = @[mainComponent];
    [self.node reloadData];
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
