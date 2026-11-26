# Contributing

Thanks for helping improve awesome_bottom_sheet. Bug reports, documentation
fixes and features are all welcome.

## Before you start

- Open an issue for anything larger than a small fix so we can agree on the
  approach first.
- Keep the package focused: it shows **feedback messages** as bottom sheets.
  General-purpose sheet mechanics (snapping, nested navigation) are out of
  scope; packages such as `smooth_sheets` cover them well.

## Development

```sh
flutter pub get
flutter test
flutter analyze --fatal-infos
dart format .
cd example && flutter run
```

The built-in Lottie icons loop forever, so widget tests advance time with
`tester.pump(duration)` rather than `pumpAndSettle`. See
`test/test_utils.dart`.

## Screenshots

`example/test/screenshots_test.dart` renders the README and pub.dev images
from the real example app so they never drift from the code. It is skipped
unless you opt in. You need ImageMagick and libwebp (`brew install imagemagick
webp`).

```sh
cd example
flutter test test/screenshots_test.dart --dart-define=SCREENSHOTS=true
cd ../doc/screenshots
magick raw/success_light.png raw/error_dark.png raw/content_light.png \
  raw/styled_light.png +append -resize 50% showcase.png
cwebp -q 85 showcase.png -o showcase.webp
for f in success_light error_dark info_light warning_light content_light styled_light; do
  magick raw/$f.png -resize 50% $f.png && cwebp -q 85 $f.png -o $f.webp && rm $f.png
done
rm -rf raw showcase.png
```

## Pull requests

1. Branch from `main`.
2. Add or update tests for every behavior change.
3. Add a line under **Unreleased** in `CHANGELOG.md`.
4. Make sure CI is green.

## Releasing (maintainers)

1. Move the **Unreleased** notes under a new version heading and bump
   `version:` in `pubspec.yaml` following [semantic versioning](https://semver.org).
2. Commit, then tag: `git tag v1.2.3 && git push --tags`.
3. The `publish.yml` workflow publishes the tag to pub.dev through automated
   publishing.
