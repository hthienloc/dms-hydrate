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

- **Dehydration & Back Pain Prevention** - Ambient shape-shifting reminders nudge you to stand up, stretch, and drink water to prevent muscle stiffness and back strain from sitting too long
- **Zero-Distraction Focus** - Operates completely silently directly on your bar with no intrusive notification windows, popups, or sound alerts
- **At-a-Glance Awareness** - Popout dashboard allows you to monitor your intake progress and daily percentage levels instantly
- **Frictionless Logging** - Quick-log cups via right-click to instantly record intake and postpone alerts without breaking your active workflow

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
