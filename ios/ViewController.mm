#import "ViewController.h"
#import <GameController/GameController.h>

extern "C" void engine_run(const char* rom_path);
extern "C" void engine_frame();
extern "C" void engine_draw_frame(id<CAMetalDrawable> drawable, id<MTLTexture> framebuffer);

@implementation ViewController {
    MTKView *_mtkView;
    CADisplayLink *_displayLink;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    _mtkView = [[MTKView alloc] initWithFrame:self.view.bounds];
    _mtkView.device = MTLCreateSystemDefaultDevice();
    _mtkView.delegate = self;
    _mtkView.enableSetNeedsDisplay = NO;
    _mtkView.paused = YES;
    _mtkView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_mtkView];

    [self presentROMPicker];
    [self setupControllers];
}

- (void)presentROMPicker {
    UIDocumentPickerViewController *picker =
        [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:@[[UTType data]] asCopy:YES];
    picker.delegate = self;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    NSURL *romURL = urls.firstObject;
    if (romURL) {
        NSString *romPath = [romURL path];
        NSLog(@"ROM Selected: %@", romPath);
        engine_run([romPath UTF8String]);
        [self startGameLoop];
    }
}

- (void)startGameLoop {
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)step {
    engine_frame();
    [_mtkView draw];
}

- (void)drawInMTKView:(MTKView *)view {
    id<CAMetalDrawable> drawable = view.currentDrawable;
    if (!drawable) return;
    id<MTLTexture> framebuffer = drawable.texture;
    engine_draw_frame(drawable, framebuffer);
}

- (void)setupControllers {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(controllerConnected:)
                                             name:GCControllerDidConnectNotification object:nil];
    [GCController startWirelessControllerDiscoveryWithCompletionHandler:nil];
}

- (void)controllerConnected:(NSNotification *)note {
    GCController *controller = note.object;
    GCExtendedGamepad *gamepad = controller.extendedGamepad;
    if (gamepad) {
        gamepad.valueChangedHandler = ^(GCExtendedGamepad *pad, GCControllerElement *element) {
            // TODO: Forward controller input to engine here
        };
    }
}
@end
