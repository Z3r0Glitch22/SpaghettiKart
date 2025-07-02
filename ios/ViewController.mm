#import <MetalKit/MetalKit.h>
#import "ViewController.h"
#import "engine.h"

@interface ViewController () <MTKViewDelegate>
@end

@implementation ViewController {
    MTKView *_mtkView;
}

// Called when the drawable size of the view changes
- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
    // Optional: Handle resizing if needed
}

// Called every frame to render content
- (void)drawInMTKView:(MTKView *)view {
    engine_draw_frame(); // Ensure this function is defined in your engine
}

@end