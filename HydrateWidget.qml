import QtQuick
import QtQuick.Controls
import Quickshell
import qs.Common
import qs.Modules.Plugins
import qs.Services
import qs.Widgets

PluginComponent {
    // Left-click toggles popout using PopoutComponent

    id: root

    // --- Configuration Settings ---
    readonly property int dailyGoal: pluginData.dailyGoal ?? 2000
    readonly property int interval: pluginData.interval ?? 60
    readonly property bool enableNotifications: pluginData.enableNotifications ?? true
    readonly property bool showHints: pluginData.showHints ?? true
    // --- Core State properties ---
    property int waterLogged: 0
    property string lastLogDate: ""
    property real lastDrinkTimestamp: 0

    // --- State Persistence Helpers ---
    function saveState() {
        if (pluginService) {
            pluginService.savePluginState(pluginId, "waterLogged", root.waterLogged);
            pluginService.savePluginState(pluginId, "lastLogDate", root.lastLogDate);
            pluginService.savePluginState(pluginId, "lastDrinkTimestamp", root.lastDrinkTimestamp);
        }
    }

    function logWater(amount) {
        root.waterLogged += amount;
        root.lastDrinkTimestamp = Date.now();
        saveState();
        if (typeof ToastService !== "undefined" && ToastService)
            ToastService.showInfo("Added " + amount + " ml! Keep hydrating! 💧");

    }

    function resetToday() {
        root.waterLogged = 0;
        root.lastDrinkTimestamp = Date.now();
        saveState();
    }

    // --- Initialization & Daily Auto-Reset ---
    Component.onCompleted: {
        const today = new Date().toDateString();
        const savedDate = pluginService ? pluginService.loadPluginState(pluginId, "lastLogDate", "") : "";
        if (savedDate !== today) {
            root.waterLogged = 0;
            root.lastLogDate = today;
            root.lastDrinkTimestamp = Date.now();
            saveState();
        } else {
            root.waterLogged = pluginService ? pluginService.loadPluginState(pluginId, "waterLogged", 0) : 0;
            root.lastLogDate = savedDate;
            root.lastDrinkTimestamp = pluginService ? pluginService.loadPluginState(pluginId, "lastDrinkTimestamp", Date.now()) : Date.now();
        }
    }
    // --- Interaction Gestures ---
    pillClickAction: null
    // Right-click quick log standard drink
    onPillRightClicked: {
        logWater(250);
    }
    // --- Popout Sizing ---
    popoutWidth: 320
    popoutHeight: root.showHints ? 310 : 270

    // --- Background Timer (Alarms, Notifications & Midnight Reset) ---
    Timer {
        interval: 10000 // Check every 10 seconds
        repeat: true
        running: true
        triggeredOnStart: false
        onTriggered: {
            const today = new Date().toDateString();
            if (root.lastLogDate !== today) {
                root.waterLogged = 0;
                root.lastLogDate = today;
                root.lastDrinkTimestamp = Date.now();
                saveState();
                return ;
            }
            if (root.enableNotifications) {
                const now = Date.now();
                const elapsedMs = now - root.lastDrinkTimestamp;
                const limitMs = root.interval * 60 * 1000;
                if (elapsedMs >= limitMs) {
                    if (typeof ToastService !== "undefined" && ToastService)
                        ToastService.showInfo("Time to drink water! 💧 You have consumed " + root.waterLogged + " / " + root.dailyGoal + " ml today.");

                    root.lastDrinkTimestamp = now;
                    saveState();
                }
            }
        }
    }

    // --- Horizontal Bar Pill Layout ---
    horizontalBarPill: Component {
        Item {
            id: pillContainer

            implicitWidth: contentRow.implicitWidth + Theme.spacingM * 2
            implicitHeight: parent.widgetThickness

            Row {
                id: contentRow

                anchors.centerIn: parent
                spacing: Theme.spacingS

                DankIcon {
                    name: "water_drop"
                    size: Theme.iconSizeSmall
                    color: root.waterLogged >= root.dailyGoal ? "#4CAF50" : "#2196F3"
                }

                StyledText {
                    text: root.waterLogged + "/" + root.dailyGoal + " ml"
                    font.pixelSize: Theme.fontSizeSmall
                    font.weight: Font.Medium
                    color: Theme.surfaceText
                }

            }

        }

    }

    // --- Vertical Bar Pill Layout ---
    verticalBarPill: Component {
        Item {
            implicitWidth: parent.widgetThickness
            implicitHeight: contentColumn.implicitHeight + Theme.spacingM * 2

            Column {
                id: contentColumn

                anchors.centerIn: parent
                spacing: Theme.spacingS

                DankIcon {
                    name: "water_drop"
                    size: Theme.iconSizeSmall
                    color: root.waterLogged >= root.dailyGoal ? "#4CAF50" : "#2196F3"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                StyledText {
                    text: root.waterLogged >= 1000 ? (root.waterLogged / 1000).toFixed(1) + "L" : root.waterLogged + "m"
                    font.pixelSize: Theme.fontSizeXS
                    font.weight: Font.Medium
                    color: Theme.surfaceText
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }

        }

    }

    // --- Popout Content Panel ---
    popoutContent: Component {
        PopoutComponent {
            id: mainContent

            property var parentPopout: null

            onParentPopoutChanged: root.activePopoutReference = parentPopout
            width: parent ? parent.width : 0
            headerText: "Hydration Tracker"
            showCloseButton: true

            Column {
                width: parent.width
                spacing: Theme.spacingM

                // Daily Progress Water Glass visual
                Item {
                    width: parent.width
                    height: 110

                    // Glass container
                    Rectangle {
                        id: glassFrame

                        width: 76
                        height: 106
                        anchors.centerIn: parent
                        color: "transparent"
                        border.color: Theme.surfaceVariantText
                        border.width: 3
                        radius: 8

                        // Animated Water Fill
                        Rectangle {
                            width: parent.width - 6
                            height: Math.max(0, (parent.height - 6) * Math.min(1, root.waterLogged / root.dailyGoal))
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 3
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "#2196F3"
                            opacity: 0.75
                            radius: 5

                            Behavior on height {
                                NumberAnimation {
                                    duration: 400
                                    easing.type: Easing.OutBack
                                }

                            }

                        }

                        // Glass reflection overlay
                        Rectangle {
                            width: 3
                            height: parent.height - 12
                            anchors.left: parent.left
                            anchors.leftMargin: 6
                            anchors.verticalCenter: parent.verticalCenter
                            color: Theme.surfaceText
                            opacity: 0.15
                            radius: 1
                        }

                        // Percentage Label inside the glass
                        StyledText {
                            anchors.centerIn: parent
                            text: Math.round(Math.min(100, (root.waterLogged / root.dailyGoal) * 100)) + "%"
                            font.pixelSize: Theme.fontSizeSmall
                            font.weight: Font.Bold
                            color: Theme.surfaceText
                        }

                    }

                }

                // Drink Log Quick Presets Row
                Row {
                    spacing: Theme.spacingS
                    anchors.horizontalCenter: parent.horizontalCenter

                    DankButton {
                        text: "+250ml"
                        backgroundColor: Theme.primary
                        textColor: Theme.onPrimary
                        onClicked: logWater(250)
                    }

                    DankButton {
                        text: "+330ml"
                        backgroundColor: Theme.primary
                        textColor: Theme.onPrimary
                        onClicked: logWater(330)
                    }

                    DankButton {
                        text: "+500ml"
                        backgroundColor: Theme.primary
                        textColor: Theme.onPrimary
                        onClicked: logWater(500)
                    }

                    DankButton {
                        text: "Reset"
                        backgroundColor: Theme.surfaceContainerHigh
                        textColor: Theme.surfaceText
                        onClicked: resetToday()
                    }

                }

                // Hint Guide Section
                HintSection {
                    width: parent.width
                    showHints: root.showHints

                    HintItem {
                        icon: "info"
                        text: "Left-click bar to open, Right-click to quick log 250ml."
                    }

                }

            }

        }

    }

}
