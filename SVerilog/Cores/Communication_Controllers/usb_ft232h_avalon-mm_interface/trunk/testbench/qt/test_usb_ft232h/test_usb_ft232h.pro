TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp


win32 {
    contains(QT_ARCH, i386) {
        LIBS += -L$$PWD/libs/win32/x86/ -lftd2xx
    }
    else {
        LIBS += -L$$PWD/libs/win32/x64/ -lftd2xx
    }
}

linux {
    contains(QT_ARCH, i386) {
        LIBS += -L$$PWD/libs/linux/x86/ -lftd2xx
    }
    else {
        LIBS += -L$$PWD/libs/linux/x64/ -lftd2xx
    }
    LIBS += -ldl -lpthread
}
