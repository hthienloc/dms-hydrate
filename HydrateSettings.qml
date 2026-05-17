import "../dms-common"
import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Modules.Plugins
import qs.Widgets

PluginSettings {
    id: root

    pluginId: "hydrate"

    PluginHeader {
        title: "Hydration Tracker Settings"
        description: "Configure daily target and distraction-free visual reminders."
    }

    SettingsCard {
        SectionTitle {
            text: "General Options"
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
