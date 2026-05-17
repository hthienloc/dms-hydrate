# AI Agent Workflow for DMS Plugins

This document describes the standardized workflow and best practices for AI agents developing plugins for **Dank Material Shell (DMS)**.

## Core Principles

1.  **Inheritance**: Always use `PluginComponent` as the root of the widget and `PluginSettings` for the settings page.
2.  **Robustness**: Access `pluginData` properties using the nullish coalescing operator (`??`) to provide safe defaults before settings are fully loaded.
3.  **UI Consistency**: Use DMS design tokens from `Theme` (e.g., `Theme.surfaceText`, `Theme.spacingM`, `Theme.cornerRadius`).
4.  **Skeleton Architecture**:
    - **Widget**: Wrap pill content in an `Item` with `implicitWidth/Height`. Use `DankIcon` for indicators.
    - **Settings**: Use `StyledRect` cards to group settings. Use `ToggleSetting` and `SliderSetting` for standard controls.

## Development Steps

### 1. Planning
- Identify the core functionality and required permissions (`plugin.json`).
- Define the interaction model (Click, Hover, Drag-and-Drop).

### 2. Implementation
- **Initial Setup**: Create a symlink from the development folder to `~/.config/DankMaterialShell/plugins/<id>` to enable real-time testing.
- **plugin.json**: Set unique `id`, descriptive `name`, and required `capabilities`.
- **Settings UI**: Build the `StyledRect` skeleton first. Use neutral and concise labels.
- **Widget Logic**: Implement the scanning/management logic inside `PluginComponent`.
- **Visuals**: Ensure the icon and colors match the system theme. Use `Theme.surfaceText` for text and icons.

### 3. Interaction Patterns
- **Hover**: Use `HoverHandler` for high-reliability hover detection.
- **Click**: Use `pillClickAction` to handle primary interactions.
- **Timers**: Use `Timer` components for delayed actions (expand/collapse).

### 4. Documentation
- Create a `README.md` using the standardized template.
- Use `<img src="screenshot.png" width="400">` for screenshots.
- Include a `git clone` and `ln -s` installation guide.

### 5. Publication & Registration
- **GitHub Upload**: Initialize git, commit all files, and create a public repository using `gh repo create dms-<plugin-id> --public --source=. --remote=origin --push`.
- **Registry Entry**:
  - Navigate to the `dms-plugin-registry` repository.
  - Create `plugins/hthienloc-<plugin-id>.json` following the standard schema.
  - Ensure the `screenshot` URL points to the `master` (or `main`) branch of the new repo.
  - Submit a Pull Request to the upstream registry to make the plugin discoverable.

## Design Constraints
- Keep it simple and neutral.
- Avoid "big words" and marketing jargon.
- Prioritize functional clarity and shell consistency.
