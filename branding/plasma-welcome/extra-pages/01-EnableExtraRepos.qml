/*
 *  SPDX-FileCopyrightText: 2021 Felipe Kinoshita <kinofhek@gmail.com>
 *  SPDX-FileCopyrightText: 2022 Nate Graham <nate@kde.org>
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
    heading: i18ndc("plasma-welcome-fedora", "@info:window", "Enable Third Party Repositories")
    description: xi18ndc("plasma-welcome-fedora", "@info:usagetip", "goobOS strongly believes in and promotes free and open source software. However, proprietary software can be made available if desired.<nl/><nl/>Click this button to make it possible to install a number of proprietary games, applications, and graphics drivers using the Discover application or the DNF package manager.")
    id: root
    topContent: [
        Kirigami.UrlButton {
            id: thirdPartyInfoLink
            Layout.topMargin: Kirigami.Units.largeSpacing
            text: i18ndc("plasma-welcome-fedora", "@action:button", "See which repositories will get added")
            url: "https://docs.fedoraproject.org/en-US/workstation-working-group/third-party-repos/#_included_software"
        },
        Kirigami.UrlButton {
            id: thirdPartyPolicyLink
            Layout.topMargin: Kirigami.Units.largeSpacing
            text: i18ndc("plasma-welcome-fedora", "@action:button", "Learn more about Fedora's Third Party Repository Policy")
            url: "https://docs.fedoraproject.org/en-US/fesco/Third_Party_Repository_Policy/"
        },
        Kirigami.UrlButton {
            id: fedoraLicenseLink
            Layout.topMargin: Kirigami.Units.largeSpacing
            text: i18ndc("plasma-welcome-fedora", "@action:button", "Learn more about Fedora's license approval standards")
            url: "https://docs.fedoraproject.org/en-US/legal/license-approval/"
        },
        QQC2.Button {
            id: enableThirdParty
            text: i18nd("plasma-welcome-fedora", "Enable Third Party Repositories")
            onClicked: {
                Controller.runCommand("pkexec fedora-third-party enable");
                showPassiveNotification(i18nd("plasma-welcome-fedora", "Third-Party Repositories are now being enabled in the background."));
                disableThirdParty.visible = true;
                enableThirdParty.visible = false;
            }
            Layout.topMargin: Kirigami.Units.largeSpacing
        },
        QQC2.Button {
            id: disableThirdParty
            text: i18nd("plasma-welcome-fedora", "Disable Third Party Repositories")
            onClicked: {
                Controller.runCommand("pkexec fedora-third-party disable");
                showPassiveNotification(i18nd("plasma-welcome-fedora", "Third-Party Repositories are now being disabled in the background."));
                disableThirdParty.visible = false;
                enableThirdParty.visible = true;
            }
            Layout.topMargin: Kirigami.Units.largeSpacing
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
            source: "/usr/share/icons/hicolor/scalable/apps/mascot_konqi_3rdparty.svg"
        }
    }
    Component.onCompleted: {
        Controller.runCommand("fedora-third-party query --quiet", callback);
    }
    property var callback: (returnStatus, outputText) => {
        if (returnStatus == 0) {
            enableThirdParty.visible = false;
            disableThirdParty.visible = true;
            console.log('Third Party Repositories are enabled');
        } else {
            enableThirdParty.visible = true;
            disableThirdParty.visible = false;
            console.log('Third Party Repositories are not enabled');
        }
    }
}
