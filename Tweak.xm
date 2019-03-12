#import <SpringBoard/SpringBoard.h>
#import <AudioToolbox/AudioServices.h>
#import <libactivator/libactivator.h>
#import <AVFoundation/AVFoundation.h>


    	AVAudioPlayer *audioPlayer;
      UITapGestureRecognizer *tap;
      UIImageView *cenaImage;
    	UIWindow *cenaWindow;





    	NSString *soundPath = [[NSBundle bundleWithPath:@"/Library/Application Support/Superslam/"] pathForResource:@"johncena" ofType:@"caf"];
    	NSURL *soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];

      @interface Superslam12Activator :  NSObject <LAListener>
       -(void)removeCena;
      @end




      @implementation Superslam12Activator
      - (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {


      	tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCena)];



        //Remove Cena from Screen - If triggered two times
        [audioPlayer stop];
        [cenaWindow removeFromSuperview];
        [cenaImage removeFromSuperview];
        cenaImage.alpha = 0;
      	cenaWindow.alpha = 0;






      	//add cena + audio

      	cenaWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
      	cenaImage.center = cenaWindow.center;
      	cenaWindow.backgroundColor = [UIColor clearColor];
      	cenaImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/Superslam/cena.png"]];
      	cenaWindow.hidden = NO;
      	[cenaWindow addSubview: cenaImage];
      	[cenaWindow addGestureRecognizer:tap];
      	[audioPlayer play];

        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
        audioPlayer.numberOfLoops = 0;
        audioPlayer.volume = 1;


        [event setHandled:YES];

      }

      //Activator labels and so on...

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



      //remove Cena from screen function
      -(void)removeCena {
      	[audioPlayer stop];
      	[cenaWindow removeFromSuperview];
      	[cenaImage removeFromSuperview];
        cenaWindow.alpha = 0;
        cenaImage.alpha = 0;
      }

      @end
