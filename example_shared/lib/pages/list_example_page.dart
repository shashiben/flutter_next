import 'package:animation_next/animation_next.dart';
import 'package:flutter/material.dart';

import '../widgets/code_block.dart';

class ListExamplePage extends StatefulWidget {
  const ListExamplePage({super.key});

  @override
  State<ListExamplePage> createState() => _ListExamplePageState();
}

class _ListExamplePageState extends State<ListExamplePage> {
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Design new landing page',
      'subtitle': 'Create mockups and wireframes',
      'icon': Icons.design_services,
      'color': Colors.purple,
      'completed': false,
      'priority': 'High',
    },
    {
      'title': 'Review pull requests',
      'subtitle': '5 PRs pending review',
      'icon': Icons.rate_review,
      'color': Colors.blue,
      'completed': false,
      'priority': 'Medium',
    },
    {
      'title': 'Update documentation',
      'subtitle': 'Add API reference examples',
      'icon': Icons.description,
      'color': Colors.green,
      'completed': false,
      'priority': 'Low',
    },
    {
      'title': 'Fix critical bug',
      'subtitle': 'Issue #1234 - Login not working',
      'icon': Icons.bug_report,
      'color': Colors.red,
      'completed': false,
      'priority': 'High',
    },
    {
      'title': 'Team meeting',
      'subtitle': 'Sprint planning at 2 PM',
      'icon': Icons.calendar_today,
      'color': Colors.orange,
      'completed': false,
      'priority': 'Medium',
    },
  ];

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['completed'] = !(_tasks[index]['completed'] as bool);
    });
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _tasks.where((t) => t['completed'] as bool).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'List Animation',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Task list with sequential fade-in animations - perfect for to-do lists, notifications, and feeds',
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
                          Icons.task_alt,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Tasks',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              '$completedCount of ${_tasks.length} completed',
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
                  ..._tasks.asMap().entries.map((entry) {
                    final index = entry.key;
                    final task = entry.value;
                    final isCompleted = task['completed'] as bool;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: NextFadeInAnimation(
                        variant: NextFadeInVariant.fadeInLeft,
                        duration: const Duration(milliseconds: 500),
                        delay: Duration(milliseconds: index * 100),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: (task['color'] as Color)
                                  .withValues(alpha: isCompleted ? 0.2 : 0.4),
                              width: isCompleted ? 1 : 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Checkbox(
                                value: isCompleted,
                                onChanged: (value) => _toggleTask(index),
                                activeColor: task['color'] as Color,
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: (task['color'] as Color)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  task['icon'] as IconData,
                                  color: task['color'] as Color,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task['title'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            decoration: isCompleted
                                                ? TextDecoration.lineThrough
                                                : null,
                                            color: isCompleted
                                                ? Colors.grey.shade500
                                                : null,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getPriorityColor(
                                                    task['priority'] as String)
                                                .withValues(alpha: 0.1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            task['priority'] as String,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: _getPriorityColor(
                                                      task['priority']
                                                          as String),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            task['subtitle'] as String,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: Colors.grey.shade600,
                                                  decoration: isCompleted
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : null,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                size: 20,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
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
items.asMap().entries.map((entry) {
  final index = entry.key;
  final item = entry.value;
  return NextFadeInAnimation(
    variant: NextFadeInVariant.fadeInLeft,
    duration: Duration(milliseconds: 500),
    delay: Duration(milliseconds: index * 100),
    child: ListTile(
      leading: Icon(item.icon),
      title: Text(item.title),
      subtitle: Text(item.subtitle),
    ),
  );
}).toList()''',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
