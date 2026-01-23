import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Next Example',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Next Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // NextButton example
            NextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button pressed!')),
                );
              },
              child: const Text('NextButton Example'),
            ),
            const SizedBox(height: 16),

            // NextAlert example
            const NextAlert(
              heading: Text('Alert Example'),
              variant: NextVariant.info,
              child: Text('This is a NextAlert widget'),
            ),
            const SizedBox(height: 16),

            // NextAccordion example
            NextAccordion(
              title: const Text('Accordion Example'),
              children: [
                const Text('This is the content of the accordion.'),
                const SizedBox(height: 8),
                NextButton(
                  onPressed: () {},
                  child: const Text('Button inside accordion'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // NextBreadCumb example
            NextBreadCumb(
              childrens: [
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => Text(
                    'Home',
                    style: TextStyle(
                      color: isHovered ? Colors.blue : Colors.black87,
                      fontWeight:
                          isHovered ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => Text(
                    'Example',
                    style: TextStyle(
                      color: isHovered ? Colors.blue : Colors.black87,
                      fontWeight:
                          isHovered ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
