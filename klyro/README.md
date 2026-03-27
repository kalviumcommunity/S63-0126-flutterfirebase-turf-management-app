# Responsive Layout Design for Klyro

This task adds a responsive turf management dashboard to the Klyro Flutter app. The screen demonstrates how `Container`, `Row`, and `Column` can be combined with `MediaQuery` and `Expanded` so the interface stacks neatly on phones and shifts into side-by-side panels on tablets or landscape layouts.

## Layout Concept

The design follows the turf booking theme already used in the app. On compact screens, content appears in a vertical flow: hero card, quick stats, schedule, facility details, and action button. On wider screens, the same content reflows into columns so important information remains visible without excessive scrolling.

Main implementation file:

- `lib/screens/responsive_layout.dart`

Navigation integration:

- `lib/screens/main_navigation_screen.dart`

## Core Widgets Used

### Container

`Container` is used for the hero banner, statistic cards, schedule items, and supporting panels.

```dart
Container(
  padding: EdgeInsets.all(isWide ? 28 : 20),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(28),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppTheme.darkGreen, AppTheme.primaryGreen],
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Turf Control Center'),
    ],
  ),
)
```

### Row

`Row` is used for the wide-screen layout so major sections can sit side by side.

```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(flex: 3, child: _buildSchedulePanel(isWide: true)),
    const SizedBox(width: 24),
    Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(child: _buildFacilityPanel(isWide: true)),
          const SizedBox(height: 24),
          _buildActionBar(isWide: true),
        ],
      ),
    ),
  ],
)
```

### Column

`Column` is used to stack sections vertically for smaller devices and to organize content inside cards.

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    _buildHeroCard(screenSize, isWide: false),
    const SizedBox(height: 16),
    _buildSectionTitle('Quick Stats'),
    const SizedBox(height: 12),
    _buildSchedulePanel(isWide: false),
  ],
)
```

## How Responsiveness Was Achieved

- `MediaQuery.sizeOf(context)` reads the screen width.
- Orientation is checked to support landscape behavior.
- A boolean breakpoint switches between compact and wide layouts.
- `Expanded` keeps sections proportional inside `Row` layouts.
- `SingleChildScrollView` prevents overflow on smaller devices.

Responsive decision snippet:

```dart
final Size screenSize = MediaQuery.sizeOf(context);
final Orientation orientation = MediaQuery.orientationOf(context);
final bool isWide =
    screenSize.width >= 700 ||
    (orientation == Orientation.landscape && screenSize.width >= 560);
```

## Screenshots

Add your screenshots here after running the app on two screen sizes or orientations.

### Small Screen / Portrait

Replace with your captured image, for example:

```md
![Phone Portrait](screenshots/responsive-phone-portrait.png)
```

### Large Screen / Tablet or Landscape

Replace with your captured image, for example:

```md
![Tablet Layout](screenshots/responsive-tablet-landscape.png)
```

## Reflection

### Why is responsiveness important in mobile apps?

Responsiveness helps the app stay usable and visually balanced across phones, tablets, and rotated screens. It improves readability, prevents overflow issues, and gives users a more polished experience regardless of device size.

### What challenges did you face while managing layout proportions?

The main challenge was deciding when content should stop stacking vertically and start using horizontal space. The layout needed enough flexibility to avoid cramped rows on medium screens while still reducing scrolling on larger displays.

### How can you improve your layout for different screen orientations?

The next improvement would be adding more adaptive breakpoints, scaling typography more precisely, and slightly changing card heights for landscape mode so the content feels better balanced on foldables, tablets, and desktop web widths.

## Submission Notes

- Commit message:
  - `feat: designed responsive layout using rows, columns, and containers`
- Suggested PR title:
  - `[Sprint-2] Responsive Layout Design – TeamName`
- PR description should include:
  - implementation summary
  - responsive screenshots
  - short reflection
  - demo video link
