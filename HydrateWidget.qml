import "./dms-common"
import QtQuick
import QtQuick.Controls
import Quickshell
import qs.Common
import qs.Modules.Plugins
import qs.Services
import qs.Widgets

PluginComponent {
    // Pure Neutral (Matches bar)

    id: root

    // --- Configuration Settings ---
    readonly property int dailyGoal: pluginData.dailyGoal ?? 8
    readonly property int interval: pluginData.interval ?? 60
    readonly property bool showHints: pluginData.showHints ?? true
    // --- Core State properties ---
    property int cupsLogged: 0
    property string lastLogDate: ""
    property real lastDrinkTimestamp: 0
    property bool needsHydration: false
    // --- Helper properties for dynamic icon shape & color ---
    readonly property string pillIconName: {
        if (root.cupsLogged >= root.dailyGoal)
            return "check_circle";

        if (root.needsHydration)
            return "local_drink";

        return "water_drop";
    }
    readonly property color pillIconColor: {
        if (root.cupsLogged >= root.dailyGoal)
            return Theme.primary;

        if (root.needsHydration)
            return Theme.warning;

        return Theme.surfaceText;
    }

    // --- State Persistence Helpers ---
    function saveState() {
        if (pluginService) {
            pluginService.savePluginState(pluginId, "cupsLogged", root.cupsLogged);
            pluginService.savePluginState(pluginId, "lastLogDate", root.lastLogDate);
            pluginService.savePluginState(pluginId, "lastDrinkTimestamp", root.lastDrinkTimestamp);
        }
    }

    function logCup() {
        root.cupsLogged += 1;
        root.needsHydration = false;
        root.lastDrinkTimestamp = Date.now();
        saveState();
    }

    function resetToday() {
        root.cupsLogged = 0;
        root.needsHydration = false;
        root.lastDrinkTimestamp = Date.now();
        saveState();
    }

    // --- Initialization & Daily Auto-Reset ---
    Component.onCompleted: {
        const today = new Date().toDateString();
        const savedDate = pluginService ? pluginService.loadPluginState(pluginId, "lastLogDate", "") : "";
        if (savedDate !== today) {
            root.cupsLogged = 0;
            root.lastLogDate = today;
            root.lastDrinkTimestamp = Date.now();
            root.needsHydration = false;
            saveState();
        } else {
            root.cupsLogged = pluginService ? pluginService.loadPluginState(pluginId, "cupsLogged", 0) : 0;
            root.lastLogDate = savedDate;
            root.lastDrinkTimestamp = pluginService ? pluginService.loadPluginState(pluginId, "lastDrinkTimestamp", Date.now()) : Date.now();
            const elapsed = Date.now() - root.lastDrinkTimestamp;
            root.needsHydration = (elapsed >= root.interval * 60 * 1000) && (root.cupsLogged < root.dailyGoal);
        }
    }
    // --- Minimalist Interaction Model ---
    // Left-click toggles popout dashboard, Right-click increments cups logged.
    pillClickAction: null
    pillRightClickAction: () => {
        root.logCup();
    }
    // --- Popout Sizing ---
    popoutWidth: 320
    popoutHeight: root.showHints ? 295 : 255

    // --- Background Timer (Alarms & Midnight Reset) ---
    Timer {
        interval: 10000 // Check every 10 seconds
        repeat: true
        running: true
        triggeredOnStart: false
        onTriggered: {
            const today = new Date().toDateString();
            if (root.lastLogDate !== today) {
                root.cupsLogged = 0;
                root.lastLogDate = today;
                root.lastDrinkTimestamp = Date.now();
                root.needsHydration = false;
                saveState();
                return ;
            }
            if (root.cupsLogged < root.dailyGoal) {
                const elapsed = Date.now() - root.lastDrinkTimestamp;
                const limit = root.interval * 60 * 1000;
                root.needsHydration = (elapsed >= limit);
            } else {
                root.needsHydration = false;
            }
        }
    }

    // --- Horizontal Bar Pill Layout ---
    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingS
            anchors.verticalCenter: parent ? parent.verticalCenter : undefined

            DankIcon {
                name: root.pillIconName
                size: Theme.iconSizeSmall
                color: root.pillIconColor
                anchors.verticalCenter: parent.verticalCenter
            }

            StyledText {
                text: root.cupsLogged + "/" + root.dailyGoal
                font.pixelSize: Theme.fontSizeMedium
                font.weight: Font.Medium
                color: Theme.surfaceText
                anchors.verticalCenter: parent.verticalCenter
            }

        }

    }

    // --- Vertical Bar Pill Layout ---
    verticalBarPill: Component {
        Column {
            spacing: Theme.spacingS
            anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined

            DankIcon {
                name: root.pillIconName
                size: Theme.iconSizeSmall
                color: root.pillIconColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            StyledText {
                text: root.cupsLogged + "/" + root.dailyGoal
                font.pixelSize: Theme.fontSizeSmall
                font.weight: Font.Medium
                color: Theme.surfaceText
                anchors.horizontalCenter: parent.horizontalCenter
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

                // Simple progress cup visual
                Item {
                    width: parent.width
                    height: 130

                    // Clean Cup graphic
                    Rectangle {
                        id: cupFrame

                        width: 90
                        height: 120
                        anchors.centerIn: parent
                        color: "transparent"
                        border.color: Theme.surfaceVariantText
                        border.width: 4
                        radius: 10
                        clip: true

                        // Animated Wavy Water Level
                        Item {
                            id: waterLevelContainer

                            width: parent.width - 8
                            height: Math.max(0, (parent.height - 8) * Math.min(1, root.cupsLogged / root.dailyGoal))
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 4
                            anchors.horizontalCenter: parent.horizontalCenter
                            clip: true

                            // Background wave (Parallax Back Layer)
                            Canvas {
                                id: backWave

                                property real phase: 0
                                property int cupsLoggedRef: root.cupsLogged

                                anchors.fill: parent
                                onPhaseChanged: requestPaint()
                                onCupsLoggedRefChanged: requestPaint()
                                onPaint: {
                                    var ctx = getContext("2d");
                                    ctx.reset();
                                    var w = width;
                                    var h = height;
                                    ctx.fillStyle = Theme.primary;
                                    ctx.globalAlpha = 0.4;
                                    ctx.beginPath();
                                    ctx.moveTo(0, h);
                                    var isFilled = (root.cupsLogged >= root.dailyGoal);
                                    for (var x = 0; x <= w; x += 2) {
                                        var y = isFilled ? 0 : (5 * Math.sin((x / w) * 2 * Math.PI + phase));
                                        ctx.lineTo(x, y + (isFilled ? 0 : 8));
                                    }
                                    ctx.lineTo(w, h);
                                    ctx.lineTo(0, h);
                                    ctx.closePath();
                                    ctx.fill();
                                }
                            }

                            // Foreground wave (Front Layer)
                            Canvas {
                                id: frontWave

                                property real phase: 0
                                property int cupsLoggedRef: root.cupsLogged

                                anchors.fill: parent
                                onPhaseChanged: requestPaint()
                                onCupsLoggedRefChanged: requestPaint()
                                onPaint: {
                                    var ctx = getContext("2d");
                                    ctx.reset();
                                    var w = width;
                                    var h = height;
                                    ctx.fillStyle = Theme.primary;
                                    ctx.globalAlpha = 0.75;
                                    ctx.beginPath();
                                    ctx.moveTo(0, h);
                                    var isFilled = (root.cupsLogged >= root.dailyGoal);
                                    for (var x = 0; x <= w; x += 2) {
                                        var y = isFilled ? 0 : (5 * Math.sin((x / w) * 2 * Math.PI - phase));
                                        ctx.lineTo(x, y + (isFilled ? 0 : 8));
                                    }
                                    ctx.lineTo(w, h);
                                    ctx.lineTo(0, h);
                                    ctx.closePath();
                                    ctx.fill();
                                }
                            }

                            // Infinite wave animations
                            NumberAnimation {
                                target: backWave
                                property: "phase"
                                from: 0
                                to: 2 * Math.PI
                                duration: 2400
                                loops: Animation.Infinite
                                running: root.cupsLogged > 0 && root.cupsLogged < root.dailyGoal
                            }

                            NumberAnimation {
                                target: frontWave
                                property: "phase"
                                from: 0
                                to: 2 * Math.PI
                                duration: 1400
                                loops: Animation.Infinite
                                running: root.cupsLogged > 0 && root.cupsLogged < root.dailyGoal
                            }

                            Behavior on height {
                                NumberAnimation {
                                    duration: 300
                                    easing.type: Easing.OutCubic
                                }

                            }

                        }

                        // Cup reflection overlay
                        Rectangle {
                            width: 3
                            height: parent.height - 16
                            anchors.left: parent.left
                            anchors.leftMargin: 6
                            anchors.verticalCenter: parent.verticalCenter
                            color: Theme.surfaceText
                            opacity: 0.12
                            radius: 1.5
                        }

                        // Percentage Label inside the cup
                        StyledText {
                            anchors.centerIn: parent
                            text: Math.round(Math.min(100, (root.cupsLogged / root.dailyGoal) * 100)) + "%"
                            font.pixelSize: Theme.fontSizeMedium
                            font.weight: Font.Bold
                            color: Theme.surfaceText
                        }

                    }

                }

                // Popout Interactive controls (Reset button)
                Row {
                    spacing: Theme.spacingS
                    anchors.horizontalCenter: parent.horizontalCenter

                    DankButton {
                        text: I18n.tr("Add Cup (+1)")
                        backgroundColor: Theme.primary
                        textColor: Theme.onPrimary
                        onClicked: logCup()
                    }

                    DankButton {
                        text: I18n.tr("Reset Target")
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
                        text: I18n.tr("Right-click the bar icon to quickly log +1 cup.")
                    }

                }

            }

        }

    }

}
