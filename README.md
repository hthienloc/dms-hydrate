# DMS Hydrate (Distraction-Free Drink Water Reminder)

`dms-hydrate` is an ultra-minimalist, distraction-free water tracker and reminder widget for **DankMaterialShell**. It strictly adheres to a minimalist philosophy—staying completely away from intrusive popups, modals, sounds, or toast windows, allowing you to use your computer without any distractions.

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
| **Increment Cup Count** | **Left-click** the bar pill. Instantly logs `+1` cup and postpones the next alert. |
| **Reset Today's Target** | **Right-click** the bar pill. Instantly resets logged cups to `0`. |

---

## Settings Configurations

Configure target volumes by navigating to **DMS Settings > Plugins > Hydrate**:

- **Daily Target (Cups)**: The number of daily cups to log, from `1` to `20` (default `8` cups).
- **Reminder Interval**: The duration in minutes between ambient reminder shape shifts, from `15` to `180` minutes (default `60` minutes).

---

## Staging & Testing

Stage it locally:
```bash
cp -r dms-hydrate/ ~/.config/DankMaterialShell/plugins/dmsHydrate
```
Scan and enable via DMS settings.
