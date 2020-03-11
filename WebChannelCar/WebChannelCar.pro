QT += dbus widgets webchannel websockets

HEADERS += car.h \
    SocketWrap/websocketclientwrapper.h \
    SocketWrap/websockettransport.h \
    WebSDK.h

SOURCES += car.cpp \
    SocketWrap/websocketclientwrapper.cpp \
    SocketWrap/websockettransport.cpp \
    WebSDK.cpp    \
    main.cpp

#DESTDIR = $$PWD/bin

CONFIG(debug, debug|release) {
    DESTDIR = $$PWD/bin/debug
} else {
    DESTDIR = $$PWD/bin/release
}

