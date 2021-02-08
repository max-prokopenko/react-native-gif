// #import <Foundation/Foundation.h>
// #import <React/RCTViewManager.h>

// #import "UIView+React.h"
#import "FLAnimatedImage.h"
#import "GifView.h"
#import <React/RCTLog.h>

@implementation GifView {

  FLAnimatedImageView *_imageView;
  FLAnimatedImage *_image;

}
- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    _imageView = [[FLAnimatedImageView alloc] init];        
  }
  return self;
}
- (void)layoutSubviews
{
  _imageView.frame = self.bounds;
  [self addSubview:_imageView];
}

- (void)setSource:(NSString *)source
{
  if (![source isEqual:_source]) {
    _source = [source copy];
    [self reloadImage];
  }
}
- (void)setResizeMode:(NSString *)resizeMode
{
  if(![resizeMode isEqual:_resizeMode]) {
    _resizeMode = resizeMode;
    [self reloadImage];
  }
}

-(void)reloadImage {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
  //  NSData *_imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_source]];

    NSURL *url = [NSURL URLWithString:_source];
    [self loadAnimatedImageWithURL:url completion:^(FLAnimatedImage *animatedImage) {
      _image = animatedImage;
    }];

    // if(_imageData == nil) {
    //   _imageData = [NSData dataWithContentsOfFile:[NSURL URLWithString:_source]];
    // }
    // _image = [FLAnimatedImage animatedImageWithGIFData:_imageData];
    
    if([_resizeMode isEqualToString:@"contain"]) {
      _imageView.contentMode = UIViewContentModeScaleAspectFit;
    } else if ([_resizeMode isEqualToString:@"cover"]) {
      _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    _imageView.animatedImage = _image;  
  });
}

- (void)loadAnimatedImageWithURL:(NSURL *const)url completion:(void (^)(FLAnimatedImage *animatedImage))completion
{
    NSArray *const pathComponents = url.pathComponents;
    // NSString *const filename = url.lastPathComponent;
    // NSString *const filename = [NSString stringWithFormat:@"%@%@", @"cache_" , filenamePath];
    NSString *filename = [pathComponents componentsJoinedByString:@"_"];
    RCTLogInfo(@"Filename is %@", filename);
    NSString *const diskPath = [NSHomeDirectory() stringByAppendingPathComponent:filename];
    NSData * __block animatedImageData = [[NSFileManager defaultManager] contentsAtPath:diskPath];
    FLAnimatedImage * __block animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
    
    if (animatedImage) {
        if (completion) {
            completion(animatedImage);
        }
    } else {
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            animatedImageData = data;
            animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
            if (animatedImage) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(animatedImage);
                    });
                }
                [data writeToFile:diskPath atomically:YES];
            }
        }] resume];
    }
}


@end
