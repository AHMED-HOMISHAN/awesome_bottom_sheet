
# Awesome Bottom Sheet

A beautiful and customizable Flutter package for displaying animated message bottom sheets with support for different message types (info, success, warning, error), custom styling, and Lottie animations.

## Features

✨ **4 Message Types**: Info, Success, Warning, and Error with predefined colors and icons

🎨 **Fully Customizable**: Custom button colors, text colors, and button labels

🎭 **Animated Icons**: Built-in animated icons with support for custom Lottie animations

⚡ **Smooth Animations**: Beautiful slide-up animations with fade effects

🔧 **Flexible Actions**: Custom callbacks for both primary and secondary buttons

🚫 **Dismissible Control**: Option to make bottom sheets dismissible or non-dismissible

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  awesome_bottom_sheet: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

#### Info Message
```dart
AwesomeMessageBottomSheet.showInfo(
  context: context,
  title: 'Information',
  description: 'This is an informational message.',
);
```

#### Success Message
```dart
AwesomeMessageBottomSheet.showSuccess(
  context: context,
  title: 'Success!',
  description: 'Operation completed successfully.',
);
```

#### Warning Message
```dart
AwesomeMessageBottomSheet.showWarning(
  context: context,
  title: 'Warning',
  description: 'Please proceed with caution.',
);
```

#### Error Message
```dart
AwesomeMessageBottomSheet.showError(
  context: context,
  title: 'Error',
  description: 'Something went wrong.',
);
```

### Advanced Usage

#### Custom Colors and Actions
```dart
AwesomeMessageBottomSheet.showInfo(
  context: context,
  title: 'Custom Message',
  description: 'This message has custom styling.',
  primaryButtonText: 'Accept',
  secondaryButtonText: 'Decline',
  primaryButtonColor: Colors.purple,
  secondaryButtonColor: Colors.grey[300],
  primaryButtonTextColor: Colors.white,
  secondaryButtonTextColor: Colors.black87,
  onPrimaryPressed: () {
    // Handle accept action
    print('Accepted!');
  },
  onSecondaryPressed: () {
    // Handle decline action
    print('Declined!');
  },
);
```

#### Non-Dismissible Message
```dart
AwesomeMessageBottomSheet.showWarning(
  context: context,
  title: 'Important!',
  description: 'This message cannot be dismissed by tapping outside.',
  barrierDismissible: false,
  primaryButtonText: 'I Understand',
  onPrimaryPressed: () {
    // Handle understanding confirmation
    Navigator.of(context).pop();
  },
);
```

#### Custom Lottie Animation
```dart
AwesomeMessageBottomSheet.showSuccess(
  context: context,
  title: 'Custom Animation',
  description: 'This message uses a custom Lottie animation.',
  customLottieAsset: 'assets/animations/custom_success.json',
);
```

## API Reference

### AwesomeMessageBottomSheet Static Methods

| Method | Description |
|--------|-------------|
| `showInfo()` | Shows an info message with blue theme |
| `showSuccess()` | Shows a success message with green theme |
| `showWarning()` | Shows a warning message with orange theme |
| `showError()` | Shows an error message with red theme |

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `context` | `BuildContext` | ✅ | The build context |
| `title` | `String` | ✅ | The main title text |
| `description` | `String?` | ❌ | Optional description text |
| `primaryButtonText` | `String` | ❌ | Text for primary button (default: 'OK') |
| `secondaryButtonText` | `String` | ❌ | Text for secondary button (default: 'Close') |
| `primaryButtonColor` | `Color?` | ❌ | Custom color for primary button |
| `secondaryButtonColor` | `Color?` | ❌ | Custom color for secondary button |
| `primaryButtonTextColor` | `Color?` | ❌ | Custom text color for primary button |
| `secondaryButtonTextColor` | `Color?` | ❌ | Custom text color for secondary button |
| `onPrimaryPressed` | `VoidCallback?` | ❌ | Callback for primary button press |
| `onSecondaryPressed` | `VoidCallback?` | ❌ | Callback for secondary button press |
| `customLottieAsset` | `String?` | ❌ | Path to custom Lottie animation |
| `barrierDismissible` | `bool` | ❌ | Whether the bottom sheet can be dismissed (default: true) |

## Message Types

### Info
- **Color**: Blue
- **Icon**: Info outline icon
- **Use case**: General information, tips, updates

### Success
- **Color**: Green
- **Icon**: Check circle outline icon
- **Use case**: Successful operations, confirmations

### Warning
- **Color**: Orange
- **Icon**: Warning amber outline icon
- **Use case**: Cautions, important notices

### Error
- **Color**: Red
- **Icon**: Error outline icon
- **Use case**: Errors, failures, critical issues

## Customization

### Button Styling
You can customize both buttons independently:
- **Colors**: Set `primaryButtonColor` and `secondaryButtonColor`
- **Text Colors**: Set `primaryButtonTextColor` and `secondaryButtonTextColor`
- **Labels**: Set `primaryButtonText` and `secondaryButtonText`

### Animations
- **Built-in Icons**: Each message type has a default animated icon
- **Custom Lottie**: Use `customLottieAsset` to specify your own Lottie animation
- **Entrance Animation**: Smooth slide-up with fade effect

### Behavior
- **Dismissible**: Control whether users can dismiss by tapping outside or dragging
- **Custom Actions**: Define what happens when each button is pressed

## Example App

Check out the `example/main.dart` file for a complete example showing all features and use cases.

## Dependencies

- `flutter`: Flutter SDK
- `lottie`: For Lottie animation support

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
