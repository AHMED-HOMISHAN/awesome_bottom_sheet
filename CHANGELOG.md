# Changelog

All notable changes to this project are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses
[Semantic Versioning](https://semver.org/).

## [Unreleased]

## [1.0.0] - 2026-11-26

First stable release. The package now targets the standalone `material_ui`
library, returns typed results, adapts to dark mode and ships a real test
suite. See **Migrating from 0.x** in the README for a step-by-step guide.

### Breaking changes

- **Requires Flutter 3.47+ and Dart 3.13+.** The package imports
  `package:material_ui/material_ui.dart` instead of the deprecated
  `package:flutter/material.dart`. This fixes a crash
  (`No MaterialLocalizations found`) in apps that already migrated to
  `material_ui`, and removes the pub.dev static-analysis penalty. Apps on
  older Flutter versions can stay on `0.0.6`.
- `AwesomeBottomSheet.show*` methods return `Future<AwesomeMessageResult>`
  instead of `Future<T?>`. The old generic never carried a value.
- `barrierDismissible` now defaults to `true` in the `show*` methods, matching
  `AwesomeMessageConfig`, the README and Flutter's `showModalBottomSheet`.
  Pass `barrierDismissible: false` explicitly to keep a sheet open.
- Non-dismissible sheets now also block the system back gesture, so "only the
  buttons close it" is actually true.
- `ThemeHelper.getLottieAnimation` returns the `LottieData` for a type
  instead of a placeholder string.
- `LottieAnimations` and `ThemeHelper` can no longer be instantiated.

### Deprecated

- `AwesomeMessageService` is now an alias of `AwesomeBottomSheet`. Existing
  calls keep working; the alias will be removed in 2.0.0.
- `LottieData.toJsonString()` and `LottieData.formattedJson`. Use
  `LottieData.bytes`. Both now produce valid JSON (`toJsonString()` did not).

### Added

- `AwesomeBottomSheet` entry point with `show`, `showConfig`, `showInfo`,
  `showSuccess`, `showWarning` and `showError`.
- `AwesomeMessageResult` (`primary`, `secondary`, `dismissed`,
  `autoDismissed`) so callers can `await` a sheet.
- `AwesomeBottomSheetThemeData`, a `ThemeExtension` for app-wide defaults:
  background, radius, margin, padding, max width, icon size, elevation,
  per-type accent colors, text and button styles.
- Per-sheet options: `icon` (any widget), `content` (any widget below the
  description), `showSecondaryButton`, `accentColor`, `backgroundColor`,
  `borderRadius`, `titleStyle`, `descriptionStyle`, `autoDismissAfter`,
  `useRootNavigator`, `routeSettings`, `barrierColor`.
- `AwesomeMessageConfig.copyWith`, `AwesomeMessageType.defaultColor`,
  `AwesomeMessageType.label`, `LottieAnimations.forType`,
  `LottieAnimations.values`, `LottieData.bytes`.
- Dark mode: colors derive from the app's `ColorScheme` instead of
  hard-coded white and grey.
- Keyboard and safe-area aware layout, scrolling for long descriptions, and a
  maximum card width on tablets and desktop.
- Reduced-motion support: the entrance animation is skipped and the icon
  plays once when the platform asks to disable animations.
- Semantics: the title is announced as a header, the icon is hidden from
  screen readers.
- pub.dev `topics` and `screenshots`, a `.pubignore` that shrinks the
  published archive from 3 MB to about 180 KB.
- GitHub Actions CI (format, analyze, test, publish dry run), pub.dev
  automated publishing workflow, issue and pull request templates,
  Dependabot and a contributing guide.

### Fixed

- The widget test suite never passed: every test timed out in
  `pumpAndSettle` because the built-in Lottie icons loop forever. The suite was
  rewritten (51 tests) and runs in CI.
- The built-in animation JSON was re-serialized and re-parsed by the lottie
  package on every rebuild, including every frame of the entrance animation.
  Bytes are now encoded once per animation and cached, so lottie's own
  composition cache hits.
- The sheet no longer slides in twice (once from the route, once from its own
  `SlideTransition`) and no longer rebuilds its whole subtree on every
  animation frame.
- The README example for non-dismissible sheets popped the calling page by
  calling `Navigator.pop` from `onPrimaryPressed` after the sheet had already
  closed.
- `AnimationController` is now created with `SingleTickerProviderStateMixin`.

## [0.0.6] - 2025-09-22

- Updated documentation.

## [0.0.5] - 2025-09-22

- Upgrade dependencies.

## [0.0.4] - 2025-09-22

- Update to 4.0 release of the package.

## [0.0.3] - 2025-09-21

- Demo app video added to showcase features.

## [0.0.2] - 2025-09-21

- Added an example.

## [0.0.1] - 2025-09-21

- Initial release of Awesome Bottom Sheet package
- Four message types: Info, Success, Warning, and Error
- Customizable button colors and text colors
- Support for custom button labels and actions
- Animated icons with smooth entrance animations
- Optional description text support
- Lottie animation support for custom icons
- Dismissible/Non-dismissible bottom sheet options
- Beautiful slide-up animation with fade effects
- Example app demonstrating all features

[Unreleased]: https://github.com/AHMED-HOMISHAN/awesome_bottom_sheet/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/AHMED-HOMISHAN/awesome_bottom_sheet/compare/3f3f374...v1.0.0
