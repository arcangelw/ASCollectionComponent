//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeItemComponent.h"
#import "ASCollectionNodeSectionGroupComponent.h"

@implementation ASCollectionNodeItemComponent

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    return 1;
}

- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = self.size;
    BOOL autoWidth = size.width == ASComponentAutomaticDimension;
    BOOL autoHeight = size.height == ASComponentAutomaticDimension;
    UIEdgeInsets inset = UIEdgeInsetsZero;
    if (autoWidth || autoHeight) {
        inset = [self.rootComponent collectionView:collectionNode.view
                                            layout:collectionNode.collectionViewLayout
                            insetForSectionAtIndex:indexPath.section];
    }
    if (autoWidth) {
        size.width = MAX(collectionNode.frame.size.width - inset.left - inset.right, 0);
    }
    if (autoHeight) {
        size.height = MAX(collectionNode.frame.size.height - inset.top - inset.bottom, 0);
    }
    return CGSizeEqualToSize(size, CGSizeZero) ? ASSizeRangeUnconstrained : ASSizeRangeMake(size);
}

@end
