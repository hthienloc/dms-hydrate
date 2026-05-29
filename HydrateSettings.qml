import "./dms-common"
import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Modules.Plugins
import qs.Widgets

PluginSettings {
    id: root

    pluginId: "hydrate"

    SettingsCard {
        SectionTitle {
            text: I18n.tr("General Options")
            icon: "water_drop"
        }

        SliderSetting {
            label: I18n.tr("Daily Target (Cups)")
            description: I18n.tr("Set your daily target number of water cups.")
            settingKey: "dailyGoal"
            defaultValue: 8
            minimum: 1
            maximum: 20
            unit: I18n.tr(" cups")
        }

        SliderSetting {
            label: I18n.tr("Reminder Interval")
            description: I18n.tr("Subtle icon shape shifting interval when hydration is needed.")
            settingKey: "interval"
            defaultValue: 60
            minimum: 15
            maximum: 180
            unit: I18n.tr(" mins")
        }

        ToggleSetting {
            label: I18n.tr("Show Hints")
            description: I18n.tr("Display helpful mouse gesture guides inside the popout.")
            settingKey: "showHints"
            defaultValue: true
        }

    }

    PluginAbout {
        repoUrl: "https://github.com/hthienloc/dms-hydrate"
    }

}
