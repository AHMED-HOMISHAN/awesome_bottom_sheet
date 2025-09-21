import 'package:flutter/material.dart';
import 'package:awesome_bottom_sheet/awesome_bottom_sheet.dart';

void main() {
  runApp(const AwesomeBottomSheetExample());
}

class AwesomeBottomSheetExample extends StatelessWidget {
  const AwesomeBottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Bottom Sheet Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ExamplePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  String _lastAction = 'No action yet';

  void _updateLastAction(String action) {
    setState(() {
      _lastAction = action;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(action),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Bottom Sheet Demo'),
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Message
              _buildDemoButton(
                icon: Icons.info,
                label: 'Show Info Message',
                color: Colors.blue,
                onPressed: () {
                  AwesomeMessageService.showInfo(
                    context: context,
                    title: '💡 Information',
                    description:
                        'This is an informational message with some helpful details about the current operation. You can customize everything!',
                    onPrimaryPressed: () {
                      _updateLastAction('Info: Primary button (OK) pressed!');
                    },
                    onSecondaryPressed: () {
                      _updateLastAction(
                          'Info: Secondary button (Close) pressed!');
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              // Success Message
              _buildDemoButton(
                icon: Icons.check_circle,
                label: 'Show Success Message',
                color: Colors.green,
                onPressed: () {
                  AwesomeMessageService.showSuccess(
                    context: context,
                    title: '🎉 Success!',
                    description:
                        'Your operation has been completed successfully! All changes have been saved to your account.',
                    primaryButtonText: 'Continue',
                    secondaryButtonText: 'Done',
                    primaryButtonColor: Colors.green[600],
                    onPrimaryPressed: () {
                      _updateLastAction('Success: Continue button pressed!');
                    },
                    onSecondaryPressed: () {
                      _updateLastAction('Success: Done button pressed!');
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              // Warning Message
              _buildDemoButton(
                icon: Icons.warning,
                label: 'Show Warning Message',
                color: Colors.orange,
                onPressed: () {
                  AwesomeMessageService.showWarning(
                    context: context,
                    title: '⚠️ Warning',
                    description:
                        'Please be careful! This action might have unintended consequences. Are you sure you want to proceed?',
                    primaryButtonText: 'Proceed Anyway',
                    secondaryButtonText: 'Cancel',
                    primaryButtonColor: Colors.orange[600],
                    secondaryButtonColor: Colors.grey[300],
                    onPrimaryPressed: () {
                      _updateLastAction(
                          'Warning: Proceeded with risky action!');
                    },
                    onSecondaryPressed: () {
                      _updateLastAction('Warning: Cancelled risky action!');
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              // Error Message
              _buildDemoButton(
                icon: Icons.error,
                label: 'Show Error Message',
                color: Colors.red,
                onPressed: () {
                  AwesomeMessageService.showError(
                    context: context,
                    title: '❌ Error Occurred',
                    description:
                        'Something went wrong during the operation. Please check your connection and try again, or contact support if the problem persists.',
                    primaryButtonText: 'Retry',
                    secondaryButtonText: 'Cancel',
                    primaryButtonColor: Colors.red[600],
                    primaryButtonTextColor: Colors.white,
                    onPrimaryPressed: () {
                      _updateLastAction('Error: Retry button pressed!');
                    },
                    onSecondaryPressed: () {
                      _updateLastAction('Error: Cancel button pressed!');
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              // Advanced Examples Section
              const Divider(),
              const Text(
                'Advanced Examples',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Custom Styled Message
              _buildDemoButton(
                icon: Icons.palette,
                label: 'Custom Styled Message',
                color: Colors.purple,
                onPressed: () {
                  AwesomeMessageService.showInfo(
                    context: context,
                    title: '🎨 Custom Style',
                    description:
                        'This message demonstrates custom colors and button styles. You can make it match your app\'s branding perfectly!',
                    primaryButtonText: 'Accept',
                    secondaryButtonText: 'Decline',
                    primaryButtonColor: Colors.purple[600],
                    secondaryButtonColor: Colors.grey[400],
                    primaryButtonTextColor: Colors.white,
                    secondaryButtonTextColor: Colors.black87,
                    onPrimaryPressed: () {
                      _updateLastAction('Custom: Accept button pressed!');
                    },
                    onSecondaryPressed: () {
                      _updateLastAction('Custom: Decline button pressed!');
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              // Non-dismissible Message
              _buildDemoButton(
                icon: Icons.block,
                label: 'Non-Dismissible Message',
                color: Colors.grey[700]!,
                onPressed: () {
                  AwesomeMessageService.showWarning(
                    context: context,
                    title: '🔒 Important Notice',
                    description:
                        'This message cannot be dismissed by tapping outside or dragging down. You must use the buttons to proceed.',
                    barrierDismissible: false,
                    primaryButtonText: 'I Understand',
                    secondaryButtonText: 'More Info',
                    onPrimaryPressed: () {
                      _updateLastAction('Non-dismissible: Understood!');
                    },
                    onSecondaryPressed: () {
                      _updateLastAction(
                          'Non-dismissible: More info requested!');
                      // Show another message with more details
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (context.mounted) {
                          AwesomeMessageService.showInfo(
                            context: context,
                            title: 'More Information',
                            description:
                                'Non-dismissible messages are perfect for critical notifications that require user acknowledgment.',
                          );
                        }
                      });
                    },
                  );
                },
              ),

              // Features Card
              Card(
                color: Colors.grey[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '✨ Package Features:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• 4 message types (Info, Success, Warning, Error)\n'
                        '• Customizable button colors and text\n'
                        '• Optional description text\n'
                        '• Custom button actions\n'
                        '• Animated icons with smooth transitions\n'
                        '• Support for Lottie animations\n'
                        '• Dismissible/Non-dismissible options\n'
                        '• Beautiful slide-up animation',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(
        icon,
        size: 20,
        color: Colors.white,
      ),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      onPressed: onPressed,
    );
  }
}
