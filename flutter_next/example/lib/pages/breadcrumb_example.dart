import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

class BreadcrumbExamplePage extends StatelessWidget {
  const BreadcrumbExamplePage({super.key});

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
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: Colors.grey.shade700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NextBreadCrumb Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle(context, 'Basic Breadcrumb'),
            _buildExplanation(context,
              'A simple breadcrumb trail for navigation hierarchy. Each `NextBreadCrumbItem` represents a level.'),
            NextBreadCrumb(
              items: [
                NextBreadCrumbItem(text: 'Home'),
                NextBreadCrumbItem(text: 'Products'),
                NextBreadCrumbItem(text: 'Electronics'),
                NextBreadCrumbItem(text: 'Laptops', isLast: true), // isLast typically styles it as non-interactive
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Breadcrumb with Custom Separator'),
            _buildExplanation(context,
              'Demonstrates customizing the separator between breadcrumb items using the `separator` property. You can use any widget as a separator.'),
            _buildExplanation(context, 'Using Text(">>") as separator:'),
            NextBreadCrumb(
              separator: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Text('>>', style: TextStyle(color: Colors.grey)),
              ),
              items: [
                NextBreadCrumbItem(text: 'Dashboard'),
                NextBreadCrumbItem(text: 'Settings'),
                NextBreadCrumbItem(text: 'Profile', isLast: true),
              ],
            ),
            const SizedBox(height: 10),
            _buildExplanation(context, 'Using an Icon as separator:'),
            NextBreadCrumb(
              separator: const Icon(Icons.arrow_forward_ios, size: 12.0, color: Colors.blueAccent),
              items: [
                NextBreadCrumbItem(text: 'Categories'),
                NextBreadCrumbItem(text: 'Books'),
                NextBreadCrumbItem(text: 'Fiction', isLast: true),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Breadcrumb with Clickable Items (Actions)'),
            _buildExplanation(context,
              'Shows breadcrumb items that are interactive. Tapping an item can trigger an `onTap` action. The last item is usually not clickable.'),
            NextBreadCrumb(
              items: [
                NextBreadCrumbItem(
                  text: 'Home Page',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Home Page tapped!'), duration: Duration(seconds: 1)),
                    );
                  },
                ),
                NextBreadCrumbItem(
                  text: 'User Area',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User Area tapped!'), duration: Duration(seconds: 1)),
                    );
                  },
                ),
                NextBreadCrumbItem(text: 'Edit Details', isLast: true),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle(context, 'Breadcrumb with Icons & Custom Styling'),
            _buildExplanation(context,
              'Illustrates adding leading icons to breadcrumb items for better visual guidance and custom text styling.'),
            NextBreadCrumb(
              activeItemColor: Colors.deepPurple, // Color for non-last items
              lastItemColor: Colors.black54,    // Color for the last item
              separator: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text('/', style: TextStyle(color: Colors.orange)),
              ),
              items: [
                NextBreadCrumbItem(
                  leading: const Icon(Icons.home_filled, size: 18, color: Colors.deepPurple),
                  text: 'Main',
                  onTap: () {}, // Make it appear clickable
                ),
                NextBreadCrumbItem(
                  leading: const Icon(Icons.folder, size: 18, color: Colors.deepPurple),
                  text: 'Documents',
                   onTap: () {},
                ),
                NextBreadCrumbItem(
                  leading: const Icon(Icons.description, size: 18, color: Colors.black54),
                  text: 'Report.docx',
                  isLast: true,
                ),
              ],
            ),
             const SizedBox(height: 10),
             _buildExplanation(context, 'Another example with different styling:'),
             NextBreadCrumb(
              activeItemColor: Colors.blue.shade700,
              lastItemColor: Colors.grey.shade700,
              itemTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              lastItemTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              items: [
                NextBreadCrumbItem(text: 'Store', onTap: () {}),
                NextBreadCrumbItem(text: 'Apparel', onTap: () {}),
                NextBreadCrumbItem(text: 'Shirts', onTap: () {}),
                NextBreadCrumbItem(text: 'Summer Collection', isLast: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
