/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "car.h"
#include "WebSDK.h"
#include <QtWidgets/QApplication>
#include <QtWidgets/QGraphicsView>
#include <QtWidgets/QGraphicsScene>
#include <QSize>
#include <QPoint>
#include <QMainWindow>
#include <QPushButton>
#include <QObject>
#include <QCoreApplication>
#include <QtWebChannel/QQmlWebChannel>
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QMainWindow window;
    window.setWindowTitle("Qt Controlled Car");
    window.resize(1024, 600);
    QGraphicsScene scene;
    scene.setSceneRect(-500, -500, 1000, 1000);
    scene.setItemIndexMethod(QGraphicsScene::NoIndex);

    Car car;
    scene.addItem(&car);

    QGraphicsView view(&scene, &window);
    view.setRenderHint(QPainter::Antialiasing);
    view.setBackgroundBrush(Qt::darkGray);
    view.resize(1024, 550);
    view.setGeometry(0, 50, 1024, 550);

    QPushButton resetButton("Reset", &window);
    resetButton.setGeometry(230, 0, 80, 30);

    QPushButton button("Controller", &window);
    button.setGeometry(320, 0, 80, 30);

    WebSDK sdk(&window, &car);
    QObject::connect(&button, &QPushButton::clicked, [&]() { sdk.openWeb(app.applicationDirPath() + "/page/index.html", WebSDK::BrowserType::Edge); });
    QObject::connect(&resetButton, &QPushButton::clicked, [&]() {
        car.setSpeed(0);
        car.setAngle(0);
        car.setTransform({});
    });

    window.show();
    return app.exec();
}
