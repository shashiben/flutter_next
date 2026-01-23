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
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade700,
            ),
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
            _buildSectionTitle(context, 'Basic Breadcrumb (Wrap)'),
            _buildExplanation(
              context,
              'A basic breadcrumb that wraps to multiple lines when needed. '
              'This is the default variant.',
            ),
            NextBreadCumb(
              childrens: [
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Home clicked')),
                      );
                    },
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: isHovered
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isHovered ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Products clicked')),
                      );
                    },
                    child: Text(
                      'Products',
                      style: TextStyle(
                        color: isHovered
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isHovered ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Electronics clicked')),
                      );
                    },
                    child: Text(
                      'Electronics',
                      style: TextStyle(
                        color: isHovered
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isHovered ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => Text(
                    'Smartphones',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            _buildSectionTitle(context, 'Scrollable Breadcrumb'),
            _buildExplanation(
              context,
              'A breadcrumb that scrolls horizontally when content overflows. '
              'Useful for long navigation paths.',
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: NextBreadCumb(
                variant: NextBreadcrumbVariant.scroll,
                childrens: [
                  NextBreadcrumbItem(
                    hoverBuilder: (context, isHovered) => GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Home clicked')),
                        );
                      },
                      child: Text(
                        'Home',
                        style: TextStyle(
                          color: isHovered
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade700,
                          fontWeight:
                              isHovered ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  NextBreadcrumbItem(
                    hoverBuilder: (context, isHovered) => GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Category clicked')),
                        );
                      },
                      child: Text(
                        'Category',
                        style: TextStyle(
                          color: isHovered
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade700,
                          fontWeight:
                              isHovered ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  NextBreadcrumbItem(
                    hoverBuilder: (context, isHovered) => GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Subcategory clicked')),
                        );
                      },
                      child: Text(
                        'Subcategory',
                        style: TextStyle(
                          color: isHovered
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade700,
                          fontWeight:
                              isHovered ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  NextBreadcrumbItem(
                    hoverBuilder: (context, isHovered) => GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Item clicked')),
                        );
                      },
                      child: Text(
                        'Item',
                        style: TextStyle(
                          color: isHovered
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade700,
                          fontWeight:
                              isHovered ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  NextBreadcrumbItem(
                    hoverBuilder: (context, isHovered) => Text(
                      'Details',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildSectionTitle(context, 'Custom Separator'),
            _buildExplanation(
              context,
              'Customize the separator between breadcrumb items.',
            ),
            NextBreadCumb(
              seperator: const Icon(Icons.arrow_forward, size: 16),
              childrens: [
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Home clicked')),
                      );
                    },
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: isHovered
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isHovered ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('About clicked')),
                      );
                    },
                    child: Text(
                      'About',
                      style: TextStyle(
                        color: isHovered
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isHovered ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => Text(
                    'Contact',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            NextBreadCumb(
              seperator: const Text('/'),
              spacing: 12.0,
              childrens: [
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Home clicked')),
                      );
                    },
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: isHovered
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isHovered ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Blog clicked')),
                      );
                    },
                    child: Text(
                      'Blog',
                      style: TextStyle(
                        color: isHovered
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isHovered ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => Text(
                    'Post Title',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            _buildSectionTitle(context, 'Custom Spacing'),
            _buildExplanation(
              context,
              'Adjust the spacing between breadcrumb items.',
            ),
            NextBreadCumb(
              spacing: 16.0,
              childrens: [
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Home clicked')),
                      );
                    },
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: isHovered
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isHovered ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Services clicked')),
                      );
                    },
                    child: Text(
                      'Services',
                      style: TextStyle(
                        color: isHovered
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isHovered ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => Text(
                    'Web Development',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            _buildSectionTitle(context, 'Breadcrumb with Icons'),
            _buildExplanation(
              context,
              'Breadcrumb items can include icons for better visual '
              'hierarchy.',
            ),
            NextBreadCumb(
              childrens: [
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Home clicked')),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.home,
                          size: 16,
                          color: isHovered
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: isHovered
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade700,
                            fontWeight:
                                isHovered ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Documents clicked')),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.folder,
                          size: 16,
                          color: isHovered
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Documents',
                          style: TextStyle(
                            color: isHovered
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade700,
                            fontWeight:
                                isHovered ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                NextBreadcrumbItem(
                  hoverBuilder: (context, isHovered) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.description,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Report.pdf',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
