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
                text: "Target & Alerts"
                font.pixelSize: Theme.fontSizeMedium
                font.weight: Font.Medium
                color: Theme.surfaceText
            }

            SliderSetting {
                label: "Daily Water Target"
                description: "Set your daily water intake objective in milliliters."
                settingKey: "dailyGoal"
                defaultValue: 2000
                minimum: 1000
                maximum: 4000
                unit: " ml"
            }

            SliderSetting {
                label: "Reminder Interval"
                description: "Time between hydration alert notifications."
                settingKey: "interval"
                defaultValue: 60
                minimum: 15
                maximum: 180
                unit: " mins"
            }

            ToggleSetting {
                label: "Enable Reminders"
                description: "Send desktop notification alerts when it is time to drink water."
                settingKey: "enableNotifications"
                defaultValue: true
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
