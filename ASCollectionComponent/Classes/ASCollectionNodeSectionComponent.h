//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASCollectionNodeSectionComponent : ASCollectionNodeBaseComponent

/**
 It will fit the collection height or width when use ASComponentAutomaticDimension.
 */
@property (assign, nonatomic) CGSize headerSize;
@property (assign, nonatomic) CGSize footerSize;
@property (assign, nonatomic) CGSize size;

/**
 It will use FlowLayout's properties if ASComponentAutomaticDimension.
 */
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat itemSpacing;
@property (assign, nonatomic) UIEdgeInsets sectionInset;

@end


@interface ASCollectionNodeHeaderFooterSectionComponent : ASCollectionNodeSectionComponent

@property (strong, nonatomic, nullable) __kindof ASCollectionNodeSectionComponent *headerComponent;
@property (strong, nonatomic, nullable) __kindof ASCollectionNodeSectionComponent *footerComponent;
@property (strong, nonatomic, nullable) __kindof ASCollectionNodeSectionComponent *headerFooterComponent;

@end

@interface ASCollectionNodeItemGroupComponent : ASCollectionNodeHeaderFooterSectionComponent

@property (strong, nonatomic, nullable) NSArray<__kindof ASCollectionNodeBaseComponent *> *subComponents;

- (__kindof ASCollectionNodeBaseComponent * _Nullable)componentAtItem:(NSInteger)atItem;

@end

NS_ASSUME_NONNULL_END
