#import <SpringBoard/SpringBoard.h>
#import <AudioToolbox/AudioServices.h>
#import <libactivator/libactivator.h>
#import <AVFoundation/AVAudioPlayer.h>

    	//Variables
    	AVAudioPlayer *audioPlayer;
    	UIWindow *cenaWindow;
    	UIImageView *cenaImage;
    	UITapGestureRecognizer *tap;
    	NSString *soundPath = [[NSBundle bundleWithPath:@"/Library/Application Support/Superslam/"] pathForResource:@"johncena" ofType:@"caf"];
    	NSURL *soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];

@interface SuperslamActivator :  NSObject <LAListener>
 -(void)noMoreCena;
@end


@implementation SuperslamActivator
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	//tap
	tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noMoreCena)];

	//remove it, just incase triggered twice (thx willysun)
	cenaWindow.alpha = 0;
	cenaImage.alpha = 0;
	[cenaWindow removeFromSuperview];
	[cenaImage removeFromSuperview];
	[audioPlayer stop];

	

	//John Cena Audio
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
	audioPlayer.numberOfLoops = 0;
	audioPlayer.volume = 1;

	[event setHandled:YES];

	//imaginary window and image
	cenaWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	cenaImage.center = cenaWindow.center;
	cenaWindow.backgroundColor = [UIColor clearColor];
	cenaImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/Superslam/cena.png"]];
	cenaWindow.hidden = NO;
	[cenaWindow addSubview: cenaImage];	
	[cenaWindow addGestureRecognizer:tap];
	[audioPlayer play];

}

//method to remove Mr. Cena
-(void)noMoreCena {
	cenaWindow.alpha = 0;
	cenaImage.alpha = 0;
	[cenaWindow removeFromSuperview];
	[cenaImage removeFromSuperview];
	[audioPlayer stop];
	
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
	return @"Superslam";
}
- (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
	return @"Make Champ appear!";
}
- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
	return [NSArray arrayWithObjects:@"springboard", nil];
}

+ (void)load {
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"com.rdurant.Superslam"];
}
@end
