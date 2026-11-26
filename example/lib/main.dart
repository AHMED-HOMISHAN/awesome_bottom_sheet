import 'package:awesome_bottom_sheet/awesome_bottom_sheet.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _brandTheme = false;

  /// App-wide sheet styling, toggled from the demo page.
  static const _brandSheetTheme = AwesomeBottomSheetThemeData(
    borderRadius: BorderRadius.all(Radius.circular(28)),
    successColor: Color(0xFF2E7D32),
    errorColor: Color(0xFFC62828),
    warningColor: Color(0xFFEF6C00),
    infoColor: Color(0xFF1565C0),
    iconSize: 96,
    titleStyle: TextStyle(letterSpacing: 0.5),
  );

  ThemeData _theme(Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: brightness,
      ),
      extensions: [if (_brandTheme) _brandSheetTheme],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Bottom Sheet',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      home: DemoPage(
        themeMode: _themeMode,
        brandTheme: _brandTheme,
        onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
        onBrandThemeChanged: (value) => setState(() => _brandTheme = value),
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({
    super.key,
    required this.themeMode,
    required this.brandTheme,
    required this.onThemeModeChanged,
    required this.onBrandThemeChanged,
  });

  final ThemeMode themeMode;
  final bool brandTheme;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ValueChanged<bool> onBrandThemeChanged;

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String _lastResult = 'Open a sheet to see its result here.';
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _report(String label, AwesomeMessageResult result) {
    setState(() => _lastResult = '$label → ${result.name}');
  }

  Future<void> _showInfo() async {
    final result = await AwesomeBottomSheet.showInfo(
      context: context,
      title: 'Did you know?',
      description:
          'You can await every sheet and branch on the result '
          'instead of wiring callbacks.',
    );
    _report('Info', result);
  }

  Future<void> _showSuccess() async {
    final result = await AwesomeBottomSheet.showSuccess(
      context: context,
      title: 'Payment received',
      description: 'Your order #4821 is confirmed and on its way.',
      primaryButtonText: 'Track order',
      secondaryButtonText: 'Done',
    );
    _report('Success', result);
  }

  Future<void> _showWarning() async {
    final result = await AwesomeBottomSheet.showWarning(
      context: context,
      title: 'Unsaved changes',
      description: 'Leaving now will discard your edits.',
      primaryButtonText: 'Discard',
      secondaryButtonText: 'Keep editing',
    );
    _report('Warning', result);
  }

  Future<void> _showError() async {
    final result = await AwesomeBottomSheet.showError(
      context: context,
      title: 'Upload failed',
      description:
          'Check your connection and try again. If the problem '
          'persists, contact support.',
      primaryButtonText: 'Retry',
      secondaryButtonText: 'Cancel',
    );
    _report('Error', result);
  }

  Future<void> _showStyled() async {
    final result = await AwesomeBottomSheet.showInfo(
      context: context,
      title: 'Brand colors',
      description:
          'Every color, radius and text style can be overridden '
          'per sheet or once for the whole app.',
      accentColor: Colors.deepPurple,
      backgroundColor: Colors.deepPurple.shade50,
      borderRadius: const BorderRadius.all(Radius.circular(32)),
      primaryButtonText: 'Love it',
      secondaryButtonText: 'Not now',
      secondaryButtonColor: Colors.deepPurple.shade200,
      secondaryButtonTextColor: Colors.deepPurple,
      titleStyle: const TextStyle(fontStyle: FontStyle.italic),
    );
    _report('Styled', result);
  }

  Future<void> _showSingleButton() async {
    final result = await AwesomeBottomSheet.showSuccess(
      context: context,
      title: 'All caught up',
      description: 'No new notifications.',
      showSecondaryButton: false,
      primaryButtonText: 'Great',
    );
    _report('Single button', result);
  }

  Future<void> _showCustomIcon() async {
    final result = await AwesomeBottomSheet.showInfo(
      context: context,
      title: 'Your own icon',
      description: 'Pass any widget as the icon, or a Lottie asset path.',
      icon: const Icon(Icons.rocket_launch, size: 72, color: Colors.orange),
      accentColor: Colors.orange,
    );
    _report('Custom icon', result);
  }

  Future<void> _showWithContent() async {
    _nameController.clear();
    final result = await AwesomeBottomSheet.showInfo(
      context: context,
      title: 'Name this device',
      description: 'The sheet moves above the keyboard automatically.',
      content: TextField(
        controller: _nameController,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Device name',
          border: OutlineInputBorder(),
        ),
      ),
      primaryButtonText: 'Save',
      secondaryButtonText: 'Cancel',
    );
    final name = _nameController.text.trim();
    _report('Content${name.isEmpty ? '' : ' ("$name")'}', result);
  }

  Future<void> _showAutoDismiss() async {
    final result = await AwesomeBottomSheet.showSuccess(
      context: context,
      title: 'Copied',
      description: 'This sheet closes itself after two seconds.',
      showSecondaryButton: false,
      autoDismissAfter: const Duration(seconds: 2),
    );
    _report('Auto dismiss', result);
  }

  Future<void> _showNonDismissible() async {
    final result = await AwesomeBottomSheet.showWarning(
      context: context,
      title: 'Accept the new terms',
      description:
          'Tapping outside, dragging down and the back gesture are '
          'disabled. Only the buttons close this sheet.',
      barrierDismissible: false,
      primaryButtonText: 'Accept',
      secondaryButtonText: 'Read terms',
    );
    _report('Non-dismissible', result);
  }

  Future<void> _showLongContent() async {
    final result = await AwesomeBottomSheet.showInfo(
      context: context,
      title: 'Release notes',
      description: List.generate(
        12,
        (i) =>
            'Improvement ${i + 1}: long descriptions scroll inside the '
            'sheet while the buttons stay reachable.',
      ).join('\n\n'),
      primaryButtonText: 'Got it',
      showSecondaryButton: false,
    );
    _report('Long content', result);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Bottom Sheet'),
        actions: [
          IconButton(
            tooltip: 'Toggle dark mode',
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => widget.onThemeModeChanged(
              Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last result',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(_lastResult),
                ],
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('App-wide sheet theme'),
            subtitle: const Text(
              'AwesomeBottomSheetThemeData: rounder corners, brand colors',
            ),
            value: widget.brandTheme,
            onChanged: widget.onBrandThemeChanged,
          ),
          const _SectionTitle('Message types'),
          _DemoButton('Info', Icons.info_outline, _showInfo),
          _DemoButton('Success', Icons.check_circle_outline, _showSuccess),
          _DemoButton('Warning', Icons.warning_amber_outlined, _showWarning),
          _DemoButton('Error', Icons.error_outline, _showError),
          const _SectionTitle('Customization'),
          _DemoButton('Custom colors and radius', Icons.palette, _showStyled),
          _DemoButton('Single button', Icons.check, _showSingleButton),
          _DemoButton(
            'Custom icon widget',
            Icons.rocket_launch,
            _showCustomIcon,
          ),
          _DemoButton('Text field content', Icons.keyboard, _showWithContent),
          _DemoButton(
            'Long scrolling description',
            Icons.notes,
            _showLongContent,
          ),
          const _SectionTitle('Behavior'),
          _DemoButton('Auto dismiss after 2s', Icons.timer, _showAutoDismiss),
          _DemoButton(
            'Non-dismissible',
            Icons.lock_outline,
            _showNonDismissible,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _DemoButton extends StatelessWidget {
  const _DemoButton(this.label, this.icon, this.onPressed);

  final String label;
  final IconData icon;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: FilledButton.tonalIcon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Align(alignment: Alignment.centerLeft, child: Text(label)),
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}
