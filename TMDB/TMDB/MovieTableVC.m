//
//  MovieTableVC.m
//  TMDB
//
//  Created by Elijah Cobb on 4/5/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "MovieTableVC.h"
#import "MovieCell.h"
#import "MovieDetailVC.h"

@interface MovieTableVC (){
    IBOutlet UICollectionView *nowPlayingTable;
    IBOutlet UICollectionView *popularTable;
    IBOutlet UICollectionView *topRatedTable;
    IBOutlet UICollectionView *upcomingTable;
    NSArray *nowPlayingArray;
    NSArray *popularArray;
    NSArray *topRatedArray;
    NSArray *upcomingArray;
}

@end

@implementation MovieTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    nowPlayingTable.dataSource = self;
    nowPlayingTable.delegate = self;
    popularTable.dataSource = self;
    popularTable.delegate = self;
    topRatedTable.dataSource = self;
    topRatedTable.delegate = self;
    upcomingTable.dataSource = self;
    upcomingTable.delegate = self;
    
    NSString *stringToSend = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/now_playing?api_key=d4979f1aab306c534ccf049e3a9a267b&language=en-US&page=1"];
    NSData *recievedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringToSend]];
    NSDictionary *rootData = [NSJSONSerialization JSONObjectWithData:recievedData options:0 error:nil];
    nowPlayingArray = rootData[@"results"];
    [nowPlayingTable reloadData];
    
    stringToSend = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?api_key=d4979f1aab306c534ccf049e3a9a267b&language=en-US&page=1"];
    recievedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringToSend]];
    rootData = [NSJSONSerialization JSONObjectWithData:recievedData options:0 error:nil];
    popularArray = rootData[@"results"];
    [popularTable reloadData];
    
    stringToSend = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/top_rated?api_key=d4979f1aab306c534ccf049e3a9a267b&language=en-US&page=1"];
    recievedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringToSend]];
    rootData = [NSJSONSerialization JSONObjectWithData:recievedData options:0 error:nil];
    topRatedArray = rootData[@"results"];
    [topRatedTable reloadData];
    
    stringToSend = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/upcoming?api_key=d4979f1aab306c534ccf049e3a9a267b&language=en-US&page=1"];
    recievedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringToSend]];
    rootData = [NSJSONSerialization JSONObjectWithData:recievedData options:0 error:nil];
    upcomingArray = rootData[@"results"];
    [upcomingTable reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger items = 0;
    if (collectionView == nowPlayingTable) {
        items = nowPlayingArray.count;
    } else if (collectionView == popularTable) {
        items = popularArray.count;
    } else if (collectionView == topRatedTable) {
        items = topRatedArray.count;
    } else if (collectionView == upcomingTable) {
        items = upcomingArray.count;
    }
    return items;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (collectionView == nowPlayingTable) {
        cell.movieTitleLabel.text = nowPlayingArray[indexPath.row][@"original_title"];
        cell.movieImageView.image = nil;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w370_and_h556_bestv2%@",nowPlayingArray[indexPath.row][@"poster_path"]]]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.movieImageView.image = image;
            });
        });
    } else if (collectionView == popularTable) {
        cell.movieTitleLabel.text = popularArray[indexPath.row][@"original_title"];
        cell.movieImageView.image = nil;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w370_and_h556_bestv2%@",popularArray[indexPath.row][@"poster_path"]]]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.movieImageView.image = image;
            });
        });
    } else if (collectionView == topRatedTable) {
        cell.movieTitleLabel.text = topRatedArray[indexPath.row][@"original_title"];
        cell.movieImageView.image = nil;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w370_and_h556_bestv2%@",topRatedArray[indexPath.row][@"poster_path"]]]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.movieImageView.image = image;
            });
        });
    } else if (collectionView == upcomingTable) {
        cell.movieTitleLabel.text = upcomingArray[indexPath.row][@"original_title"];
        cell.movieImageView.image = nil;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w370_and_h556_bestv2%@",upcomingArray[indexPath.row][@"poster_path"]]]]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.movieImageView.image = image;
            });
        });
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailVC *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"movieDetailVC"];
    if (collectionView == nowPlayingTable) {
        detail.movie = nowPlayingArray[indexPath.row];
    } else if (collectionView == popularTable) {
        detail.movie = popularArray[indexPath.row];
    } else if (collectionView == topRatedTable) {
        detail.movie = topRatedArray[indexPath.row];
    } else if (collectionView == upcomingTable) {
        detail.movie = upcomingArray[indexPath.row];
    }
    [self.navigationController pushViewController:detail animated:YES];
}

@end
