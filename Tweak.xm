//import needed headers
#import <SpringBoard/SpringBoard.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import <libactivator/libactivator.h>


      //declare needed variables
      UITapGestureRecognizer *tap;
      UIImageView *cenaImage;
    	UIWindow *cenaWindow;
      AVAudioPlayer *player;


      //Sound paths
    	NSString *soundPath = [[NSBundle bundleWithPath:@"/Library/Application Support/Superslam/"] pathForResource:@"johncena" ofType:@"caf"];
    	NSURL *soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];



      @interface Superslam12Activator :  NSObject <LAListener>
       -(void)noMoreCena;
      @end


      //do when activator gesture is used
      @implementation Superslam12Activator
      - (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {


        //function to be executed when user tapped on the screen
      	tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noMoreCena)];


        [self noMoreCena];


        //show cena
      	cenaWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
      	cenaImage.center = cenaWindow.center;
      	cenaWindow.backgroundColor = [UIColor clearColor];
      	cenaImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/Superslam/cena.png"]];
      	cenaWindow.hidden = NO;
      	[cenaWindow addSubview: cenaImage];
      	[cenaWindow addGestureRecognizer:tap];

        //play cena sound
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
        player.numberOfLoops = 0;
        player.volume = 1;
        [player play];


        [event setHandled:YES];

      }


      //remaining things for activator
      - (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
      	return @"Superslam12";
      }
      - (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
      	return @"Make John Cena appear!";
      }
      - (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
      	return [NSArray arrayWithObjects:@"springboard", nil];
      }



      + (void)load {
      	[[LAActivator sharedInstance] registerListener:[self new] forName:@"me.memor1es.superslam12"];
      }


      //function to hide cena and stop audio
      - (void)noMoreCena {
        cenaWindow.alpha = 0;
        cenaImage.alpha = 0;
        [cenaWindow removeFromSuperview];
        [cenaImage removeFromSuperview];

        [player stop];
      }



      @end
