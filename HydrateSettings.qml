import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Modules.Plugins
import qs.Services
import qs.Widgets

PluginSettings {
    id: root

    pluginId: "dmsHydrate"

    StyledText {
        width: parent.width
        text: "Hydration Settings"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledRect {
        width: parent.width
        height: contentColumn.implicitHeight + Theme.spacingL * 2
        radius: Theme.cornerRadius
        color: Theme.surfaceContainerHigh

        Column {
            id: contentColumn

            anchors.fill: parent
            anchors.margins: Theme.spacingL
            spacing: Theme.spacingM

            StyledText {
                text: "Target & Alert Interval"
                font.pixelSize: Theme.fontSizeMedium
                font.weight: Font.Medium
                color: Theme.surfaceText
            }

            SliderSetting {
                label: "Daily Target (Cups)"
                description: "Set your daily target number of water cups."
                settingKey: "dailyGoal"
                defaultValue: 8
                minimum: 1
                maximum: 20
                unit: " cups"
            }

            SliderSetting {
                label: "Reminder Interval"
                description: "Subtle icon shape shifting interval when hydration is needed."
                settingKey: "interval"
                defaultValue: 60
                minimum: 15
                maximum: 180
                unit: " mins"
            }

            ToggleSetting {
                label: "Show Hints"
                description: "Display helpful mouse gesture guides inside the popout."
                settingKey: "showHints"
                defaultValue: true
            }

        }

    }

}
