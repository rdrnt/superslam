include $(THEOS)/makefiles/common.mk

TWEAK_NAME = superslam12
superslam12_FILES = Tweak.xm
superslam12_FRAMEWORKS = UIKit AVFoundation AudioToolbox
superslam12_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
