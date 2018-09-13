//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#ifndef ASCollectionNodeComponent_Private_h
#define ASCollectionNodeComponent_Private_h

#import "ASCollectionNodeComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASCollectionNodeBaseComponent ()

@property (weak, nonatomic, nullable) ASCollectionNode *collectionNode;

/**
 For group component to caculate the indexPath.
 */
- (NSInteger)firstItemOfSubComponent:(id<ASCollectionNodeComponent>)subComp;
- (NSInteger)firstSectionOfSubComponent:(id<ASCollectionNodeComponent>)subComp;
@end

NS_ASSUME_NONNULL_END

#endif /* ASCollectionNodeComponent_Private_h */
