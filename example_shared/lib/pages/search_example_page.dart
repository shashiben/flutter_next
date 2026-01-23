import 'package:animation_next/animation_next.dart';
import 'package:flutter/material.dart';

import '../widgets/code_block.dart';

class SearchExamplePage extends StatefulWidget {
  const SearchExamplePage({super.key});

  @override
  State<SearchExamplePage> createState() => _SearchExamplePageState();
}

class _SearchExamplePageState extends State<SearchExamplePage> {
  bool _isExpanded = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<Map<String, dynamic>> _allItems = [
    {
      'name': 'Flutter Development',
      'category': 'Development',
      'icon': Icons.code
    },
    {
      'name': 'Dart Programming',
      'category': 'Development',
      'icon': Icons.developer_mode
    },
    {
      'name': 'Mobile App Design',
      'category': 'Design',
      'icon': Icons.phone_android
    },
    {
      'name': 'UI/UX Best Practices',
      'category': 'Design',
      'icon': Icons.palette
    },
    {
      'name': 'Animation Techniques',
      'category': 'Design',
      'icon': Icons.animation
    },
    {
      'name': 'State Management',
      'category': 'Development',
      'icon': Icons.settings
    },
  ];
  List<Map<String, dynamic>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _controller.addListener(_onSearchChanged);
    _focusNode.addListener(() {
      setState(() {
        _isExpanded = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      final query = _controller.text.toLowerCase();
      _filteredItems = _allItems
          .where(
              (item) => item['name'].toString().toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Bar Animation',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Expandable search bar with smooth slide animation and live search results',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 48),

          // Live Example
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.search,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Search',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              "Find what you're looking for",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  NextSlideAnimation(
                    variant: _isExpanded
                        ? NextSlideVariant.slideInLeft
                        : NextSlideVariant.slideInRight,
                    duration: const Duration(milliseconds: 300),
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _controller.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _controller.clear();
                                  _filteredItems = _allItems;
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                    ),
                  ),
                  if (_isExpanded && _filteredItems.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    NextFadeInAnimation(
                      variant: NextFadeInVariant.fadeIn,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 300),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = _filteredItems[index];
                            return NextFadeInAnimation(
                              variant: NextFadeInVariant.fadeInLeft,
                              duration: const Duration(milliseconds: 300),
                              delay: Duration(milliseconds: index * 50),
                              child: ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    item['icon'] as IconData,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                title: Text(item['name'] as String),
                                subtitle: Text(item['category'] as String),
                                trailing:
                                    const Icon(Icons.chevron_right, size: 20),
                                onTap: () {
                                  _controller.text = item['name'] as String;
                                  _focusNode.unfocus();
                                  setState(() => _isExpanded = false);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  if (_isExpanded && _controller.text.isEmpty) ...[
                    const SizedBox(height: 16),
                    NextFadeInAnimation(
                      variant: NextFadeInVariant.fadeIn,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Start typing to search',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Code Example
          Text(
            'Code Example',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CodeBlock(
                code: '''
bool _isExpanded = false;
final FocusNode _focusNode = FocusNode();

_focusNode.addListener(() {
  setState(() => _isExpanded = _focusNode.hasFocus);
});

NextSlideAnimation(
  variant: _isExpanded 
      ? NextSlideVariant.slideInLeft 
      : NextSlideVariant.slideInRight,
  duration: Duration(milliseconds: 300),
  child: TextField(
    focusNode: _focusNode,
    decoration: InputDecoration(
      hintText: 'Search...',
      prefixIcon: Icon(Icons.search),
    ),
  ),
)''',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
