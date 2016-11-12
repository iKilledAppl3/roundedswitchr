TARGET = iphone:clang:latest
SDK = iPhoneOS8.1
ARCHS = armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = RoundedSwitchr
RoundedSwitchr_FILES = RoundedSwitchr.mm
RoundedSwitchr_INSTALL_PATH = /Library/PreferenceBundles
RoundedSwitchr_FRAMEWORKS = UIKit MessageUI CoreGraphics
RoundedSwitchr_PRIVATE_FRAMEWORKS = Preferences
RoundedSwitchr_LIBRARIES += cepheiprefs MobileGestalt
CFLAGS = -Wno-deprecated -Wno-deprecated-declarations -Wno-error

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/RoundedSwitchr.plist$(ECHO_END)
