# DMS Hydrate (Drink Water Reminder Widget Plugin)

`dms-hydrate` is an elegant, highly interactive hydration tracking and reminder plugin for the **DankMaterialShell** Linux desktop environment. It helps you maintain healthy hydration habits by providing real-time bar widgets, scheduled desktop notifications, and an intuitive tracking visual inside the popout panel.

---

## Features

- **💧 Dynamic Bar Pill**: Keeps you updated at a glance with your real-time water count (e.g. `💧 750/2000 ml`). Highlights in clean green when your daily objective is reached.
- **🥛 Animated Progress Glass**: A visual glass vector in the popout dashboard that dynamically rises and bounces as you log water intake.
- **📅 Smart Day Auto-Reset**: Remembers your logs and automatically resets your daily water count back to `0 ml` when a new calendar day starts.
- **⏰ Scheduled Notifications**: Generates system toast notification alerts at customized intervals to remind you to drink. Logging water instantly postpones the next alarm.
- **⚡ Fast Gestures**: Right-click the bar pill to quick-log `250 ml` of water instantly, without interrupting your flow.

---

## Usage

| Gesture / Click | Description |
|:---|:---|
| **Left-Click Pill** | Opens or toggles the Popout hydration tracker dashboard. |
| **Right-Click Pill** | Instantly quick-logs `+250 ml` and resets the reminder schedule. |

Inside the Popout dashboard, you can:
1. Log specific standard sizes using the preset buttons: `+250ml` (cup), `+330ml` (glass), and `+500ml` (bottle).
2. Reset today's intake via the **Reset** button.

---

## Settings Configurations

Modify settings by navigating to **DMS Settings > Plugins > Hydrate**:

- **Daily Water Target**: The daily volume goal in milliliters (ml) from `1000 ml` to `4000 ml` (default `2000 ml`).
- **Reminder Interval**: The countdown timer length between reminder alarms in minutes from `15` to `180` (default `60` minutes).
- **Enable Reminders**: Toggle system notifications on or off.
- **Show Hints**: Show or hide the popout interaction gesture hints.

---

## Installation & Staging

To stage and test this plugin locally on DankMaterialShell:

1. Clone or copy this directory to your local configuration plugins folder:
   ```bash
   cp -r dms-hydrate/ ~/.config/DankMaterialShell/plugins/dmsHydrate
   ```
2. Open **DMS Control Center Settings > Plugins > Scan for Plugins**.
3. Toggle `Hydrate` on and add it to your DankBar configuration layout.
