//
//  ASMainComponent.m
//  ASCollectionComponent_Example
//
//  Created by 吴哲 on 2018/9/11.
//  Copyright © 2018年 arcangelw. All rights reserved.
//

#import "ASMainComponent.h"
#import <Masonry/Masonry.h>

static UIEdgeInsets const defaultInsets = {15, 15, 15, 15};

@interface ASUIKitCell : UICollectionViewCell
- (void)setTextAt:(NSIndexPath *)indexPath;
@end
@implementation ASUIKitCell {
    UILabel *_titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(defaultInsets);
        }];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _titleLabel.text = nil;
}

- (void)setTextAt:(NSIndexPath *)indexPath
{
    _titleLabel.text = [NSString stringWithFormat:@"UIKitCell section:%@-item:%@", @(indexPath.section), @(indexPath.item)];
}

@end

@interface ASUIKitReusableView : UICollectionReusableView
- (void)setTextFor:(NSString *)kind at:(NSIndexPath *)indexPath;
@end
@implementation ASUIKitReusableView {
    UILabel *_titleLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(defaultInsets);
        }];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _titleLabel.text = nil;
}

- (void)setTextFor:(NSString *)kind at:(NSIndexPath *)indexPath
{
    _titleLabel.text = [NSString stringWithFormat:@"UIKit%@ section:%@", kind, @(indexPath.section)];
}
@end

@implementation ASHeaderComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.headerSize = CGSizeMake(0, 35);
    }
    return self;
}

- (void)prepareCollectionNode
{
    [super prepareCollectionNode];
    [self.collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
    [self.collectionNode.view registerClass:[ASUIKitReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section % 2 == 1) {
        ASTextCellNode *node = [[ASTextCellNode alloc] init];
        node.textInsets = defaultInsets;
        node.text = [NSString stringWithFormat:@"NodoHeader section:%@", @(indexPath.section)];
//        node.backgroundColor = UIColor.redColor;
//        node.style.preferredSize = (CGSize){30.f,30.f};
        return node;
    }
    return ASComponentEmptyCellNode();
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && indexPath.section % 2 == 0) {
        ASUIKitReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        [view setTextFor:@"Header" at:indexPath];
        return view;
    }
    return nil;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplaySupplementaryElementWithNode:(ASCellNode *)node
{
    if ([node.supplementaryElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        node.backgroundColor = UIColor.redColor;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        view.backgroundColor = UIColor.redColor;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    static ASUIKitReusableView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[ASUIKitReusableView alloc] init];
    });
    [view setTextFor:@"Header" at:[NSIndexPath indexPathForItem:0 inSection:section]];
    return [view systemLayoutSizeFittingSize:self.size];
}

@end

@implementation ASFooterComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.footerSize = CGSizeMake(35.f, 35);
    }
    return self;
}

- (void)prepareCollectionNode
{
    [super prepareCollectionNode];
    [self.collectionNode registerSupplementaryNodeOfKind:UICollectionElementKindSectionFooter];
    [self.collectionNode.view registerClass:[ASUIKitReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter] && indexPath.section % 2 == 0) {
        ASTextCellNode *node = [[ASTextCellNode alloc] init];
        node.textInsets = defaultInsets;
        node.text = [NSString stringWithFormat:@"NodoFooter section:%@", @(indexPath.section)];
        //        node.backgroundColor = UIColor.redColor;
//        node.style.preferredSize = (CGSize){30.f,30.f};
        return node;
    }
    return ASComponentEmptyCellNode();
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter] && indexPath.section % 2 == 1) {
        ASUIKitReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        [view setTextFor:@"Footer" at:indexPath];
        return view;
    }
    return nil;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplaySupplementaryElementWithNode:(ASCellNode *)node
{
    if ([node.supplementaryElementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        node.backgroundColor = UIColor.blueColor;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        view.backgroundColor = UIColor.blueColor;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    static ASUIKitReusableView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[ASUIKitReusableView alloc] init];
    });
    [view setTextFor:@"Footer" at:[NSIndexPath indexPathForItem:0 inSection:section]];
    return [view systemLayoutSizeFittingSize:self.size];
}

@end

@implementation ASMainComponent {
    CGSize _itemSize;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSpacing = 10.f;
        self.lineSpacing = 10.f;
        self.sectionInset = defaultInsets;
        self.headerComponent = [[ASHeaderComponent alloc] init];
        self.footerComponent = [[ASFooterComponent alloc] init];
    }
    return self;
}

- (void)prepareCollectionNode
{
    [super prepareCollectionNode];
    CGFloat width= (CGRectGetWidth(self.collectionNode.bounds) - self.sectionInset.left - self.sectionInset.right - self.itemSpacing ) / 2.0;
    _itemSize = CGSizeMake(width, 100);
    self.size = CGSizeMake(width, ASComponentAutomaticDimension);
    [self.collectionNode.view registerClass:[ASUIKitCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode
{
    return 5;
}
- (NSInteger)collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (ASCellNode *)collectionNode:(ASCollectionNode *)collectionNode nodeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item % 2 == 0) return ASComponentEmptyCellNode();
    ASTextCellNode *node = [[ASTextCellNode alloc] init];
    node.textInsets = defaultInsets;
    node.text = [NSString stringWithFormat:@"NodeCell section:%@-item:%@", @(indexPath.section), @(indexPath.item)];
    return node;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item % 2 == 1) return nil;
    ASUIKitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setTextAt:indexPath];
    return cell;
}

- (void)collectionNode:(ASCollectionNode *)collectionNode willDisplayItemWithNode:(ASCellNode *)node
{
    node.backgroundColor = [UIColor colorWithRed:arc4random_uniform(225)/225.f green:arc4random_uniform(225)/225.f blue:arc4random_uniform(225)/225.f alpha:1.f];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(225)/225.f green:arc4random_uniform(225)/225.f blue:arc4random_uniform(225)/225.f alpha:1.f];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static ASUIKitCell *cell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [[ASUIKitCell alloc] init];
    });
    [cell.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.size.width);
    }];
    [cell setTextAt:indexPath];
    return [cell.contentView systemLayoutSizeFittingSize:self.size];
}

@end
