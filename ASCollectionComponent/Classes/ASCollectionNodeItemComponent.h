//
//  Created by 吴哲 on 2018/9/01.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASCollectionNodeComponent.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASCollectionNodeItemComponent : ASCollectionNodeBaseComponent

/**
 ItemSize. It will fit the collection height or width when use ASComponentAutomaticDimension.
 */
@property (assign, nonatomic) CGSize size;

@end

NS_ASSUME_NONNULL_END
