//
//  TVTableVC.m
//  TMDB
//
//  Created by Elijah Cobb on 4/5/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "TVTableVC.h"
#import "MovieCell.h"

@interface TVTableVC (){
    IBOutlet UICollectionView *airingTodayTable;
    IBOutlet UICollectionView *popularTable;
    IBOutlet UICollectionView *topRatedTable;
    NSArray *airingTodayArray;
    NSArray *popularArray;
    NSArray *topRatedArray;
}

@end

@implementation TVTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    airingTodayTable.dataSource = self;
    airingTodayTable.delegate = self;
    popularTable.dataSource = self;
    popularTable.delegate = self;
    topRatedTable.dataSource = self;
    topRatedTable.delegate = self;
    
    NSString *stringToSend = [NSString stringWithFormat:@"https://api.themoviedb.org/3/tv/airing_today?api_key=d4979f1aab306c534ccf049e3a9a267b&language=en-US&page=1"];
    NSData *recievedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringToSend]];
    NSDictionary *rootData = [NSJSONSerialization JSONObjectWithData:recievedData options:0 error:nil];
    airingTodayArray = rootData[@"results"];
    [airingTodayTable reloadData];
    
    stringToSend = [NSString stringWithFormat:@"https://api.themoviedb.org/3/tv/popular?api_key=d4979f1aab306c534ccf049e3a9a267b&language=en-US&page=1"];
    recievedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringToSend]];
    rootData = [NSJSONSerialization JSONObjectWithData:recievedData options:0 error:nil];
    popularArray = rootData[@"results"];
    [popularTable reloadData];
    
    stringToSend = [NSString stringWithFormat:@"https://api.themoviedb.org/3/tv/top_rated?api_key=d4979f1aab306c534ccf049e3a9a267b&language=en-US&page=1"];
    recievedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringToSend]];
    rootData = [NSJSONSerialization JSONObjectWithData:recievedData options:0 error:nil];
    topRatedArray = rootData[@"results"];
    [topRatedTable reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger items = 0;
    if (collectionView == airingTodayTable) {
        items = airingTodayArray.count;
    } else if (collectionView == popularTable) {
        items = popularArray.count;
    } else if (collectionView == topRatedTable) {
        items = topRatedArray.count;
    }
    return items;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (collectionView == airingTodayTable) {
        cell.movieTitleLabel.text = airingTodayArray[indexPath.row][@"original_name"];
        cell.movieImageView.image = nil;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w370_and_h556_bestv2%@",airingTodayArray[indexPath.row][@"poster_path"]]]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.movieImageView.image = image;
            });
        });
    } else if (collectionView == popularTable) {
        cell.movieTitleLabel.text = popularArray[indexPath.row][@"original_name"];
        cell.movieImageView.image = nil;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w370_and_h556_bestv2%@",popularArray[indexPath.row][@"poster_path"]]]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.movieImageView.image = image;
            });
        });
    } else if (collectionView == topRatedTable) {
        cell.movieTitleLabel.text = topRatedArray[indexPath.row][@"original_name"];
        cell.movieImageView.image = nil;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w370_and_h556_bestv2%@",topRatedArray[indexPath.row][@"poster_path"]]]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.movieImageView.image = image;
            });
        });
    }
    
    return cell;
}

@end
