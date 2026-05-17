# DMS Hydrate (Distraction-Free Drink Water Reminder)

`dms-hydrate` is an elegant, distraction-free water tracker and reminder widget for **DankMaterialShell**. It strictly adheres to a minimalist philosophy—staying away from intrusive popups, notification sounds, or active toast alerts, communicating instead through ambient shape shifting on your bar and a clean visual progress dashboard.

---

## Minimalist Philosophy & Mechanics

Rather than throwing alerts on your screen, `dms-hydrate` communicates ambiently and silently directly on your DankBar:

1. **Ambient Shape Shifting**:
   - **💧 Water Drop (`water_drop`)**: Neutral state. Blends in naturally with your other panel widgets.
   - **🥛 Drink Glass (`local_drink` in Amber/Orange)**: Changes shape and color silently when the configured hydration interval passes, acting as a quiet visual prompt.
   - **✅ Check Circle (`check_circle` in Green)**: Visual indicator when your daily cups target has been met.
2. **📅 Smart Calendar Day Reset**: Auto-resets your cup count back to `0` when a new calendar day begins.

---

## Quick Gestures

All interactions happen directly on the bar pill with simple mouse clicks:

| Action | Gesture |
|:---|:---|
| **Toggle Dashboard Popout** | **Left-click** the bar pill. Toggles a clean visual cup progress panel. |
| **Fast-Increment Cup Count** | **Right-click** the bar pill. Instantly logs `+1` cup and postpones the next alert. |

Inside the dashboard popout, you can also:
- Click **Add Cup (+1)** to log water intake.
- Click **Reset Target** to clear today's logged cups back to `0`.

---

## Settings Configurations

Configure target volumes by navigating to **DMS Settings > Plugins > Hydrate**:

- **Daily Target (Cups)**: The number of daily cups to log, from `1` to `20` (default `8` cups).
- **Reminder Interval**: The duration in minutes between ambient reminder shape shifts, from `15` to `180` minutes (default `60` minutes).
- **Show Hints**: Show or hide the interaction gesture guides inside the popout (default `true`).

---

## Installation

This plugin depends on `dms-common` for standard DMS layout components and cards. Ensure `dms-common` is cloned in the parent directory next to `dms-hydrate`:

```bash
git clone https://github.com/hthienloc/dms-common.git
```

---

## Staging & Testing

Stage it locally to your desktop configuration folder:
```bash
cp -r dms-hydrate/ ~/.config/DankMaterialShell/plugins/hydrate
```
Scan and enable via DMS settings.
