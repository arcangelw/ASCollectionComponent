//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

// When width or height is auto, it will use collectionView.size
// When inset lineSpacing itemSpacing is auto, it will use CollectionLayout's property.
UIKIT_EXTERN const CGFloat ASComponentAutomaticDimension;
UIKIT_EXTERN const CGSize ASComponentSizeAutomaticDimension;
UIKIT_EXTERN const UIEdgeInsets ASComponentInsetsAutomaticDimension;

/// isInterop时，Swift无法 return nil,提供一个emptyCellNode
UIKIT_EXTERN ASCellNode * ASComponentEmptyCellNode();

typedef UIEdgeInsets(^ASComponentNodeConstrainedInsetsGetter)(void);

UIKIT_EXTERN ASSizeRange ASComponentNodeConstrainedSizeForScrollDirection(ASCollectionView *collectionView, CGSize size, ASComponentNodeConstrainedInsetsGetter getter);

UIKIT_EXTERN CGSize ASComponentViewSizeForScrollDirection(ASCollectionView *collectionView, CGSize size, ASComponentNodeConstrainedInsetsGetter getter);

@class ASCollectionNodeRootComponent;
@protocol ASCollectionNodeComponent <NSObject, ASCollectionDelegateFlowLayout, ASCollectionDelegateInterop, ASCollectionDataSourceInterop, UICollectionViewDelegateFlowLayout>

@end

@interface ASCollectionNodeBaseComponent : NSObject <ASCollectionNodeComponent>

@property (weak, nonatomic, nullable) ASCollectionNodeBaseComponent *superComponent NS_SWIFT_NAME(superComponent);
@property (weak, nonatomic, nullable) ASCollectionNodeRootComponent *rootComponent;

/**
 The collection host by component. It is nil before RootComponent attach to a collectionNode.
 */
@property (readonly, weak, nonatomic, nullable) ASCollectionNode *collectionNode;

/**
 Register cell should be here, and only for register! It may invoke many times.
 */
- (void)prepareCollectionNode NS_REQUIRES_SUPER;

/**
 Life cycle
 Is really need?

 @param component Nil if remove from super component.
 */
//- (void)willMoveToComponent:(ASCollectionNodeBaseComponent * _Nullable)component NS_REQUIRES_SUPER;
//- (void)didMoveToComponent NS_REQUIRES_SUPER;
//- (void)willMoveToRootComponent:(ASCollectionNodeRootComponent * _Nullable)component NS_REQUIRES_SUPER;
//- (void)didMoveToRootComponent NS_REQUIRES_SUPER;

/**
 For ItemComponent, {item, section} is equal to indexPath.
 For SectionComponent, {item, section} is equal to first item's indexPath, or Zero.
 For SectionGroupComponent, item should always be 0, section is the first section in the component.
 */
@property (readonly, nonatomic) NSInteger item;
@property (readonly, nonatomic) NSInteger section;

@end

NS_ASSUME_NONNULL_END
