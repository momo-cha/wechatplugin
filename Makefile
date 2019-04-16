THEOS_DEVICE_IP = 127.0.0.1
THEOS_DEVICE_PORT = 2222
ARCHS = armv7 arm64
THEOS = /opt/theos
THEOS_MARK_PATH=$(THEOS)/makefiles

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WeChatNearbyPlugin
WeChatNearbyPlugin_FILES = Tweak.xm
WeChatNearbyPlugin_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
