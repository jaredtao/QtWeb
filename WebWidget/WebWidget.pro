QT += core gui webenginewidgets

CONFIG += c++11

SOURCES += \
        main.cpp

CONFIG(debug, debug|release) {
    DESTDIR = $$PWD/bin/debug
} else {
    DESTDIR = $$PWD/bin/release
}
