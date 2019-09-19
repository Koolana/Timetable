#-------------------------------------------------
#
# Project created by QtCreator 2019-09-11T20:27:23
#
#-------------------------------------------------

QT       += core gui network xml quick

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = TimetableQtQuick
TEMPLATE = app

android{
    include(/home/kolana/QT/android_openssl-5.12.4_5.13.0/openssl.pri)#подключает OpenSSL к проекту (сам OpenSSl находится по этому пути)

    QMAKE_CFLAGS += -gcc-toolchain $$NDK_TOOLCHAIN_PATH -fno-limit-debug-info
    QMAKE_LINK    = $$QMAKE_CXX $$QMAKE_CFLAGS -Wl,--exclude-libs,libgcc.a -Wl,--exclude-libs,libatomic.a -nostdlib++
    equals(ANDROID_TARGET_ARCH, armeabi-v7a): QMAKE_LINK += -Wl,--exclude-libs,libunwind.a
    QMAKE_CFLAGS += -DANDROID_HAS_WSTRING --sysroot=$$NDK_ROOT/sysroot \
                -isystem $$NDK_ROOT/sysroot/usr/include/$$NDK_TOOLS_PREFIX \
                -isystem $$NDK_ROOT/sources/cxx-stl/llvm-libc++/include \
                -isystem $$NDK_ROOT/sources/android/support/include \
                -isystem $$NDK_ROOT/sources/cxx-stl/llvm-libc++abi/include
    ANDROID_SOURCES_CXX_STL_LIBDIR = $$NDK_ROOT/sources/cxx-stl/llvm-libc++/libs/$$ANDROID_TARGET_ARCH
}

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        filteringsystem.cpp \
        main.cpp \
        pagereader.cpp \
        testqmlss.cpp \
        libs/QGumboParser/gumbo-parser/src/attribute.c \
        libs/QGumboParser/gumbo-parser/src/char_ref.c \
        libs/QGumboParser/gumbo-parser/src/error.c \
        libs/QGumboParser/gumbo-parser/src/parser.c \
        libs/QGumboParser/gumbo-parser/src/string_buffer.c \
        libs/QGumboParser/gumbo-parser/src/string_piece.c \
        libs/QGumboParser/gumbo-parser/src/tag.c \
        libs/QGumboParser/gumbo-parser/src/tokenizer.c \
        libs/QGumboParser/gumbo-parser/src/utf8.c \
        libs/QGumboParser/gumbo-parser/src/util.c \
        libs/QGumboParser/gumbo-parser/src/vector.c \
        libs/QGumboParser/qgumboattribute.cpp \
        libs/QGumboParser/qgumbodocument.cpp \
        libs/QGumboParser/qgumbonode.cpp \
        timemodule.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

HEADERS += \
        filteringsystem.h \
        pagereader.h \
        testqmlss.h \
        timemodule.h \
        timetabledata.h \
        libs/QGumboParser/HtmlTag.h \
        libs/QGumboParser/gumbo-parser/src/attribute.h \
        libs/QGumboParser/gumbo-parser/src/char_ref.h \
        libs/QGumboParser/gumbo-parser/src/char_ref.rl \
        libs/QGumboParser/gumbo-parser/src/error.h \
        libs/QGumboParser/gumbo-parser/src/gumbo.h \
        libs/QGumboParser/gumbo-parser/src/insertion_mode.h \
        libs/QGumboParser/gumbo-parser/src/parser.h \
        libs/QGumboParser/gumbo-parser/src/string_buffer.h \
        libs/QGumboParser/gumbo-parser/src/string_piece.h \
        libs/QGumboParser/gumbo-parser/src/tag_enum.h \
        libs/QGumboParser/gumbo-parser/src/tag_gperf.h \
        libs/QGumboParser/gumbo-parser/src/tag_sizes.h \
        libs/QGumboParser/gumbo-parser/src/tag_strings.h \
        libs/QGumboParser/gumbo-parser/src/token_type.h \
        libs/QGumboParser/gumbo-parser/src/tokenizer.h \
        libs/QGumboParser/gumbo-parser/src/tokenizer_states.h \
        libs/QGumboParser/gumbo-parser/src/utf8.h \
        libs/QGumboParser/gumbo-parser/src/util.h \
        libs/QGumboParser/gumbo-parser/src/vector.h \
        libs/QGumboParser/qgumboattribute.h \
        libs/QGumboParser/qgumbodocument.h \
        libs/QGumboParser/qgumbonode.h

SUBDIRS += libs/QGumboParser/QGumboParser.pro \
