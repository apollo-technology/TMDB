//
//  MovieDetailVC.m
//  TMDB
//
//  Created by Elijah Cobb on 4/5/17.
//  Copyright © 2017 Apollo Technology. All rights reserved.
//

#import "MovieDetailVC.h"

@interface MovieDetailVC (){
    IBOutlet UIImageView *backdropImageView;
    IBOutlet UIImageView *movieImageView;
    IBOutlet UITextView *overviewLabel;
}

@end

@implementation MovieDetailVC

@synthesize movie;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = movie[@"original_title"];
    overviewLabel.text = movie[@"overview"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w370_and_h556_bestv2%@",movie[@"backdrop_path"]]]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            backdropImageView.image = image;
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w370_and_h556_bestv2%@",movie[@"poster_path"]]]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            movieImageView.image = image;
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
