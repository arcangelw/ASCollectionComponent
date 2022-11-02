//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeItemComponent.h"
#import "ASCollectionNodeSectionGroupComponent.h"

@implementation ASCollectionNodeItemComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        _size = ASComponentSizeAutomaticDimension;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    return 1;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return ASComponentNodeConstrainedSizeForScrollDirection(collectionNode.view, self.size, ^UIEdgeInsets{
        return [self.rootComponent collectionView:collectionNode.view
                                           layout:collectionNode.collectionViewLayout
                           insetForSectionAtIndex:indexPath.section];
    });
}

@end
