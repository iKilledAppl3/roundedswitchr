TARGET = iphone:clang:latest
SDK = iPhoneOS8.1
ARCHS = armv7 arm64
THEOS_BUILD_DIR = DEBs

include theos/makefiles/common.mk

TWEAK_NAME = RoundedSwitchr
RoundedSwitchr_FILES = Tweak.xm
RoundedSwitchr_FRAMEWORKS = UIKit
RoundedSwitchr_CFLAGS = -Wno-error
RoundedSwitchr_LDFLAGS += -Wl,-segalign,4000
CFLAGS = -Wno-deprecated -Wno-deprecated-declarations -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += roundedswitchr
include $(THEOS_MAKE_PATH)/aggregate.mk
