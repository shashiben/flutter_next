import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class AlertsExamplePage extends StatefulWidget {
  const AlertsExamplePage({super.key});

  @override
  State<AlertsExamplePage> createState() => _AlertsExamplePageState();
}

class _AlertsExamplePageState extends State<AlertsExamplePage> {
  bool _dismissibleAlertVisible = true;
  bool _dismissibleIconAlertVisible = true;

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildExplanation(BuildContext context, String explanation) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: Text(
        explanation,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontStyle: FontStyle.italic, color: Colors.grey.shade700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NextAlerts Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle(context, 'Basic Alert Variants'),
            _buildExplanation(
                context,
                'Displays different predefined alert variants, each with a distinct color scheme. '
                'These are controlled by the `variant` property of NextAlert.'),
            const NextAlert(
              child: Text('This is a primary alert.'),
            ),
            const SizedBox(height: 8),
            const NextAlert(
              variant: NextVariant.secondary,
              child: Text('This is a secondary alert.'),
            ),
            const SizedBox(height: 8),
            const NextAlert(
              variant: NextVariant.success,
              child: Text('This is a success alert.'),
            ),
            const SizedBox(height: 8),
            const NextAlert(
              variant: NextVariant.danger,
              child: Text('This is a danger alert.'),
            ),
            const SizedBox(height: 8),
            const NextAlert(
              variant: NextVariant.warning,
              child: Text('This is a warning alert.'),
            ),
            const SizedBox(height: 8),
            const NextAlert(
              variant: NextVariant.info,
              child: Text('This is an info alert.'),
            ),
            const SizedBox(height: 8),
            const NextAlert(
              variant: NextVariant.light,
              child: Text('This is a light alert.'),
            ),
            const SizedBox(height: 8),
            const NextAlert(
              variant: NextVariant.dark,
              child: Text('This is a dark alert.'),
            ),

            _buildSectionTitle(context, 'Alerts with Icons'),
            _buildExplanation(
                context,
                'Shows how to include a leading icon in alerts using the `leadingIcon` property. '
                'The icon will be automatically colored to match the alert variant.'),
            // NextAlert(
            //   variant: NextVariant.success,
            //   leadingIcon: const Icon(Icons.check_circle_outline),
            //   child: const Text('Success! Your action was completed.'),
            // ),
            // const SizedBox(height: 8),
            // NextAlert(
            //   variant: NextVariant.warning,
            //   leadingIcon: const Icon(Icons.warning_amber_outlined),
            //   child: const Text('Warning: Please check the input fields.'),
            // ),
            // const SizedBox(height: 8),
            // NextAlert(
            //   variant: NextVariant.info,
            //   leadingIcon: const Icon(Icons.info_outline),
            //   child: const Text('Info: System maintenance scheduled for tonight.'),
            // ),

            _buildSectionTitle(context, 'Dismissible Alerts'),
            _buildExplanation(
                context,
                "Demonstrates dismissible alerts. Click the 'x' icon to close them. "
                'This requires setting `showCloseButton: true` and providing an `onDismiss` callback to manage visibility.'),
            // if (_dismissibleAlertVisible)
            //   NextAlert(
            //     variant: NextVariant.primary,
            //     showCloseButton: true,
            //     onDismiss: () {
            //       setState(() {
            //         _dismissibleAlertVisible = false;
            //       });
            //     },
            //     child: const Text('This primary alert is dismissible.'),
            //   ),
            if (!_dismissibleAlertVisible)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                    onPressed: () =>
                        setState(() => _dismissibleAlertVisible = true),
                    child: const Text('Reset Dismissible Alert')),
              ),
            const SizedBox(height: 8),
            // if (_dismissibleIconAlertVisible)
            //   NextAlert(
            //     variant: NextVariant.danger,
            //     leadingIcon: const Icon(Icons.dangerous_outlined),
            //     showCloseButton: true,
            //     onDismiss: () {
            //       setState(() {
            //         _dismissibleIconAlertVisible = false;
            //       });
            //     },
            //     child: const Text('This dismissible danger alert also has an icon.'),
            //   ),
            if (!_dismissibleIconAlertVisible)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                    onPressed: () =>
                        setState(() => _dismissibleIconAlertVisible = true),
                    child: const Text('Reset Dismissible Icon Alert')),
              ),

            _buildSectionTitle(context, 'Alert with Custom Rich Content'),
            _buildExplanation(
                context,
                'Illustrates using custom rich content within an alert. '
                'You can pass any widget as the child, for example, a Column with a title, paragraph, and buttons.'),
            // NextAlert(
            //   variant: NextVariant.info,
            //   leadingIcon: const Icon(Icons.campaign_outlined),
            //   showCloseButton: true, // Optional for this example
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Important Announcement!',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 16,
            //           color: NextVariant.info.textColor, // Use variant color for consistency
            //         ),
            //       ),
            //       const SizedBox(height: 4),
            //       Text(
            //         'We are excited to announce new features coming soon to our platform. '
            //         'Stay tuned for more updates and prepare for an enhanced user experience.',
            //          style: TextStyle(color: NextVariant.info.textColor),
            //       ),
            //       const SizedBox(height: 12),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           TextButton(
            //             onPressed: () {
            //               // Action for 'Learn More'
            //               ScaffoldMessenger.of(context).showSnackBar(
            //                 const SnackBar(content: Text('Learn More clicked!')),
            //               );
            //             },
            //             child: Text('Learn More', style: TextStyle(color: NextVariant.info.textColor, fontWeight: FontWeight.bold)),
            //           ),
            //           const SizedBox(width: 8),
            //            TextButton(
            //             onPressed: () {
            //                ScaffoldMessenger.of(context).showSnackBar(
            //                 const SnackBar(content: Text('Dismiss clicked from custom button!')),
            //               );
            //             },
            //             child: Text('Dismiss', style: TextStyle(color: NextVariant.info.textColor)),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
