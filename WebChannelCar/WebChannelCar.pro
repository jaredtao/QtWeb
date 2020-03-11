QT += dbus widgets

HEADERS += car.h \
    controller.h
SOURCES += car.cpp \
    main.cpp \
    controller.cpp

CONFIG(debug, debug|release) {
    DESTDIR = $$PWD/bin/debug
} else {
    DESTDIR = $$PWD/bin/release
}

FORMS += \
    controller.ui
