ARCHS = armv7 arm64
THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

TWEAK_NAME = Superslam
Superslam_FILES = Tweak.xm
Superslam_FRAMEWORKS = UIKit AudioToolbox AVFoundation
Superslam_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
