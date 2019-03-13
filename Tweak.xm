
#import <SpringBoard/SpringBoard.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import <libactivator/libactivator.h>



      UITapGestureRecognizer *tap;
      UIImageView *cenaImage;
    	UIWindow *cenaWindow;
      AVAudioPlayer *audioPlayer;





    	NSString *soundPath = [[NSBundle bundleWithPath:@"/Library/Application Support/Superslam/"] pathForResource:@"johncena" ofType:@"caf"];
    	NSURL *soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];



      @interface Superslam12Activator :  NSObject <LAListener>
       -(void)noMoreCena;
      @end




      @implementation Superslam12Activator
      - (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {


        // remove cena on tap
      	tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noMoreCena)];



        //Remove Cena from Screen - If triggered two times
        cenaWindow.alpha = 0;
        cenaImage.alpha = 0;
        [cenaWindow removeFromSuperview];
        [cenaImage removeFromSuperview];
        [audioPlayer stop];






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




      //remove Cena from screen function
      - (void)noMoreCena {
        cenaWindow.alpha = 0;
        cenaImage.alpha = 0;
        [cenaWindow removeFromSuperview];
        [cenaImage removeFromSuperview];
        [audioPlayer stop];
      }





      //Activator labels and so on...

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
      	[[LAActivator sharedInstance] registerListener:[self new] forName:@"com.sh0rtflow.Superslam12"];
      }




      @end
