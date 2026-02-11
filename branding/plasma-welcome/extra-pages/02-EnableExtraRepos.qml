/*
 *  SPDX-FileCopyrightText: 2025 The GoobApp foundation
 *
 *  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only OR LicenseRef-KDE-Accepted-GPL
 */

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import Qt5Compat.GraphicalEffects

import org.kde.plasma.welcome

GenericPage {
    heading: i18ndc("plasma-welcome-fedora", "@info:window", "GoobApp Community")
    description: xi18ndc("plasma-welcome-fedora", "@info:usagetip", "I just figured out how to make a page, so I'm just very excited about this.")
    id: root
    topContent: [
        Kirigami.UrlButton {
            id: thirdPartyInfoLink
            Layout.topMargin: Kirigami.Units.largeSpacing
            text: i18ndc("plasma-welcome-fedora", "@action:button", "Open GoobApp!")
            url: "https://goobapp.org/"
        },
        Kirigami.UrlButton {
            id: thirdPartyPolicyLink
            Layout.topMargin: Kirigami.Units.largeSpacing
            text: i18ndc("plasma-welcome-fedora", "@action:button", "View GoobApp on GitHub")
            url: "https://github.com/GoobApp/"
        }
    ]
    ColumnLayout {
        anchors.fill: parent
        spacing: root.padding
        id: pandaImage
        Image {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: Kirigami.Units.gridUnit * 25

            fillMode: Image.PreserveAspectFit
            mipmap: true
            source: "/usr/share/icons/hicolor/scalable/apps/goofy_goober.png"
        }
    }
}
