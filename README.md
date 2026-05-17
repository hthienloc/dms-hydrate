# Hydrate

Distraction-free drink water reminder and tracker.

<img src="screenshot.png" width="300" alt="Screenshot">

## Install


**Required:** This plugin requires [dms-common](https://github.com/hthienloc/dms-common) to be installed.

```bash
# 1. Install shared components
git clone https://github.com/hthienloc/dms-common ~/.config/DankMaterialShell/plugins/dms-common

# 2. Install this plugin
dms plugins install hydrate
```

Or manually:
```bash
git clone https://github.com/hthienloc/dms-hydrate ~/.config/DankMaterialShell/plugins/hydrate
```

## Features

- **Dehydration Prevention** - Ambient shape-shifting reminders prompt you to maintain daily water intake
- **Zero-Distraction Focus** - Operates silently on the bar with no intrusive popups or alert sounds
- **At-a-Glance Tracker** - Popout dashboard to monitor daily progress and target percentage
- **Frictionless Logging** - Quick-log cups via right-click to instantly record water intake

## Usage

| Action | Result |
|--------|--------|
| Left click | Toggle popout dashboard |
| Right click | Fast increment cup count by +1 |

## License

GPL-3.0

## Roadmap / TODO

- [ ] **Custom Container Sizes**: Log custom liquid measurements (ml/oz) with quick preset containers (Bottle, Glass, Mug).
- [ ] **Hydration History Chart**: Visualize daily/weekly progress trends via inline graphs in the dashboard.
- [ ] **Ambient Reminder Speeds**: Intelligent reminder frequency scaling based on dynamic physical activities or system uptime.
- [ ] **Sound Alerts Toggle**: Optional subtle water droplet audio chime toggles for optional notification.
- [ ] **DND Integration**: Automatically silence bar reminders during full-screen apps or focus mode.
- [ ] **Data Export/Import**: Backup logged hydration history stats to CSV or JSON formats.
