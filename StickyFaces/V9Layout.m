//
//  V9Layout.m
//  testProject
//
//  Created by Bogdan Weidmann on 10.04.13.
//  Copyright (c) 2013 nexiles. All rights reserved.
//

#import "V9Layout.h"
#import "SpringBoardLayoutAttributes.h"

@interface V9Layout()
{
    NSMutableArray *_insertedIndexPaths;
    NSMutableArray *_deletedIndexPaths;
}

-(void)calculateLayoutProperties;
-(int)pagesInSection:(NSInteger)section;

@property (nonatomic, strong) NSMutableArray *frames;

@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, assign) CGSize pageSize;
@property (nonatomic, assign) CGSize itemSize;

@end

@implementation V9Layout

@synthesize itemsInOneRow = _itemsInOneRow, itemSize = _itemSize;
@synthesize lineSpacing = _lineSpacing, interitemSpacing = _interitemSpacing;
@synthesize frames = _frames;



-(void)prepareForCollectionViewUpdates:(NSArray *)updates {
    
    [super prepareForCollectionViewUpdates:updates];
    for (UICollectionViewUpdateItem *updateItem in updates) {
        if (updateItem.updateAction == UICollectionUpdateActionInsert) {
            [_insertedIndexPaths addObject:updateItem.indexPathAfterUpdate];
        } else if (updateItem.updateAction == UICollectionUpdateActionDelete)
        {
            [_deletedIndexPaths addObject:updateItem.indexPathBeforeUpdate];
        }
    }
    
    
}


-(void)finalizeCollectionViewUpdates {
    
    [_insertedIndexPaths removeAllObjects];
    [_deletedIndexPaths removeAllObjects];
}


-(SpringBoardLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    
    if ([_insertedIndexPaths containsObject:itemIndexPath]) {
        //1
        SpringBoardLayoutAttributes *attributes = [SpringBoardLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        
        //2
        CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
        attributes.center =CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
        attributes.alpha = 0.0f;
        attributes.transform3D = CATransform3DMakeScale(0.6f, 0.6f, 1.0f);
        
        //3
        return attributes;
        
    } else {
        return  (SpringBoardLayoutAttributes *)[super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    }
}


-(SpringBoardLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    
    if ([_deletedIndexPaths containsObject:itemIndexPath]) {
        SpringBoardLayoutAttributes *attributes = [SpringBoardLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        
        CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
        attributes.center = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
        attributes.alpha = 0.0f;
        attributes.transform3D = CATransform3DMakeScale(1.3f, 1.3f, 1.0f);
        
        return attributes;
    }
    else {
        return (SpringBoardLayoutAttributes *)[super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    }
    
    
}


-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        return [self initWithItemsInOneRow:3];
    }
    
    return self;
}

-(id)init {
    return [self initWithItemsInOneRow:3]; // Standard number of items in one row is 3.
}

-(id)initWithItemsInOneRow:(NSInteger)itemsInOneRow {
    if (self = [super init]) {
        self.itemsInOneRow = itemsInOneRow;
        self.frames = [NSMutableArray array];
    }

    return self;
}

-(void)calculateLayoutProperties {
    self.pageSize = self.collectionView.bounds.size;
    
    // The width of all line spacings is equal to width of ONE item. The same for interitem spacing

    CGFloat itemWidth = self.pageSize.width / (self.itemsInOneRow + 1); // +1 because we all spaces make width of one additional item
    CGFloat itemHeight = self.pageSize.height / (self.itemsInOneRow + 1); // the same
    
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    self.lineSpacing = (self.pageSize.width - (self.itemsInOneRow * self.itemSize.width)) / (self.itemsInOneRow + 1);
    self.interitemSpacing = (self.pageSize.height - (self.itemsInOneRow * self.itemSize.height)) / (self.itemsInOneRow + 1);
}

-(int)pagesInSection:(NSInteger)section {
    return ([self.collectionView numberOfItemsInSection:section] - 1) / (self.itemsInOneRow * self.itemsInOneRow)  + 1;
}

-(CGSize)collectionViewContentSize {
    // contentSize.width is equal to pages * pageSize.width
    NSInteger sections = 1;
    if ([self.collectionView respondsToSelector:@selector(numberOfSections)]) {
        sections = [self.collectionView numberOfSections];
    }
    int pages = 0;
    for (int section = 0; section < sections; section++) {
        pages = pages + [self pagesInSection:section];
    }
    return CGSizeMake(pages * self.pageSize.width, self.pageSize.height);
}

-(void)prepareLayout {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self calculateLayoutProperties];
    });
    
    [self.frames removeAllObjects];
    
    _insertedIndexPaths = [NSMutableArray new];
    _deletedIndexPaths = [NSMutableArray new];
    
    NSInteger sections = 1;
    if ([self.collectionView respondsToSelector:@selector(numberOfSections)]) {
        sections = [self.collectionView numberOfSections];
    }
    int pagesOffset = 0; // Pages that are used by prevoius sections
    int itemsInPage = self.itemsInOneRow * self.itemsInOneRow;
    for (int section = 0; section < sections; section++) {
        NSMutableArray *framesInSection = [NSMutableArray array];
        int pagesInSection = [self pagesInSection:section];
        int itemsInSection = [self.collectionView numberOfItemsInSection:section];
        for (int page = 0; page < pagesInSection; page++) {
            int itemsToAddToArray = itemsInSection - framesInSection.count;
            int itemsInCurrentPage = itemsInPage;
            if (itemsToAddToArray < itemsInPage) { // If there are less cells than expected (typically last page of section), we go only through existing cells.
                itemsInCurrentPage = itemsToAddToArray;
            }
            for (int itemInPage = 0; itemInPage < itemsInCurrentPage; itemInPage++) {
                CGFloat originX = (pagesOffset + page) * self.pageSize.width + self.lineSpacing + (itemInPage % self.itemsInOneRow) * (self.itemSize.width + self.lineSpacing);
                CGFloat originY = self.interitemSpacing + (itemInPage / self.itemsInOneRow) * (self.itemSize.height + self.interitemSpacing);
                CGRect itemFrame = CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
                [framesInSection addObject:NSStringFromCGRect(itemFrame)];
            }
        }
        [self.frames addObject:framesInSection];
        
        pagesOffset += pagesInSection;
    }
}




-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray array];
    
    NSInteger sections = 1;
    if ([self.collectionView respondsToSelector:@selector(numberOfSections)]) {
        sections = [self.collectionView numberOfSections];
    }
    
    int pagesOffset = 0;
    int itemsInPage = self.itemsInOneRow * self.itemsInOneRow;
    for (int section = 0; section < sections; section++) {
        int pagesInSection = [self pagesInSection:section];
        int itemsInSection = [self.collectionView numberOfItemsInSection:section];
        for (int page = 0; page < pagesInSection; page++) {
            CGRect pageFrame = CGRectMake((pagesOffset + page) * self.pageSize.width, 0, self.pageSize.width, self.pageSize.height);
            
            if (CGRectIntersectsRect(rect, pageFrame)) {
                int startItemIndex = page * itemsInPage;
                int itemsInCurrentPage = itemsInPage;
                if (itemsInSection - startItemIndex < itemsInPage) {
                    itemsInCurrentPage = itemsInSection - startItemIndex;
                }
                for (int itemInPage = 0; itemInPage < itemsInCurrentPage; itemInPage++) {
                    SpringBoardLayoutAttributes *itemAttributes = (SpringBoardLayoutAttributes *)[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:startItemIndex + itemInPage inSection:section]];
                    if (CGRectIntersectsRect(itemAttributes.frame, rect)) {
                        [attributes addObject:itemAttributes];
                    }
                    for (SpringBoardLayoutAttributes *attribs in attributes)
                    {
                        if ([self isDeletionModeOn]) attribs.deleteButtonHidden = NO;
                        else attribs.deleteButtonHidden = YES;
                    }
                }
            }
        }
        
        pagesOffset += pagesInSection;
    }
    return attributes;
}

-(SpringBoardLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    SpringBoardLayoutAttributes *attributes = [SpringBoardLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectFromString(self.frames[indexPath.section][indexPath.item]);
    
    if ([self isDeletionModeOn])
    {
        attributes.deleteButtonHidden = NO;
    }
    else
    {
        attributes.deleteButtonHidden = YES;
    }
    
    return attributes;
}



- (BOOL)isDeletionModeOn
{
    if ([[self.collectionView.delegate class] conformsToProtocol:@protocol(V9LayoutDelegate)]) {
        
        return [(id)self.collectionView.delegate isDeletionModeActiveForCollectionView:(UICollectionView *)self.collectionView layout:(UICollectionViewLayout *)self];
        
    }
    return NO;
    
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}


+ (Class)layoutAttributesClass
{
    return [SpringBoardLayoutAttributes class];
}



@end
