cmake_minimum_required(VERSION 3.16)

project(Game2048 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appGame2048
    main.cpp
)

qt_add_qml_module(appGame2048
    URI Game2048
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Page/MenuPage.qml
        QML_FILES Page/GamePage.qml
        QML_FILES Cube.qml
        QML_FILES Page/GameEndPage.qml
        QML_FILES
        QML_FILES FieldGame.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appGame2048 PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appGame2048
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appGame2048
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appGame2048
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

set_property(TARGET appGame2048 PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
          "${CMAKE_CURRENT_SOURCE_DIR}/Deployment/android")
