import 'package:animation_next/animation_next.dart';
import 'package:flutter/material.dart';

import '../widgets/code_block.dart';

class DropdownExamplePage extends StatefulWidget {
  const DropdownExamplePage({super.key});

  @override
  State<DropdownExamplePage> createState() => _DropdownExamplePageState();
}

class _DropdownExamplePageState extends State<DropdownExamplePage> {
  final Map<String, bool> _expandedSections = {
    'account': false,
    'notifications': false,
    'privacy': false,
  };

  void _toggleSection(String key) {
    setState(() {
      _expandedSections[key] = !_expandedSections[key]!;
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
            'Dropdown Animation',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Smooth expandable sections with slide-down animation - perfect for settings, FAQs, and accordions',
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
                          Icons.settings,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Settings',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Manage your preferences',
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
                  _SettingsSection(
                    title: 'Account',
                    icon: Icons.person,
                    isExpanded: _expandedSections['account']!,
                    onTap: () => _toggleSection('account'),
                    children: const [
                      _SettingItem(
                        icon: Icons.edit,
                        title: 'Edit Profile',
                        subtitle: 'Update your personal information',
                        trailing: Icon(Icons.chevron_right),
                      ),
                      _SettingItem(
                        icon: Icons.email,
                        title: 'Email Settings',
                        subtitle: 'Manage email preferences',
                        trailing: Icon(Icons.chevron_right),
                      ),
                      _SettingItem(
                        icon: Icons.password,
                        title: 'Change Password',
                        subtitle: 'Update your account password',
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _SettingsSection(
                    title: 'Notifications',
                    icon: Icons.notifications,
                    isExpanded: _expandedSections['notifications']!,
                    onTap: () => _toggleSection('notifications'),
                    children: [
                      _SettingItem(
                        icon: Icons.notifications_active,
                        title: 'Push Notifications',
                        subtitle: 'Receive push notifications',
                        trailing: Switch(value: true, onChanged: (v) {}),
                      ),
                      _SettingItem(
                        icon: Icons.email_outlined,
                        title: 'Email Notifications',
                        subtitle: 'Get updates via email',
                        trailing: Switch(value: false, onChanged: (v) {}),
                      ),
                      _SettingItem(
                        icon: Icons.sms,
                        title: 'SMS Notifications',
                        subtitle: 'Receive text messages',
                        trailing: Switch(value: false, onChanged: (v) {}),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _SettingsSection(
                    title: 'Privacy & Security',
                    icon: Icons.security,
                    isExpanded: _expandedSections['privacy']!,
                    onTap: () => _toggleSection('privacy'),
                    children: [
                      _SettingItem(
                        icon: Icons.lock,
                        title: 'Two-Factor Authentication',
                        subtitle: 'Add an extra layer of security',
                        trailing: Switch(value: true, onChanged: (v) {}),
                      ),
                      _SettingItem(
                        icon: Icons.visibility_off,
                        title: 'Private Profile',
                        subtitle: 'Hide your profile from others',
                        trailing: Switch(value: false, onChanged: (v) {}),
                      ),
                      const _SettingItem(
                        icon: Icons.delete_outline,
                        title: 'Delete Account',
                        subtitle: 'Permanently delete your account',
                        trailing: Icon(Icons.chevron_right, color: Colors.red),
                      ),
                    ],
                  ),
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

AnimatedCrossFade(
  duration: Duration(milliseconds: 200),
  crossFadeState: _isExpanded
      ? CrossFadeState.showSecond
      : CrossFadeState.showFirst,
  firstChild: SizedBox.shrink(),
  secondChild: NextSlideAnimation(
    variant: NextSlideVariant.slideInTop,
    duration: Duration(milliseconds: 400),
    child: Container(
      padding: EdgeInsets.all(16),
      child: YourContent(),
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

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.isExpanded,
    required this.onTap,
    required this.children,
  });
  final String title;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onTap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isExpanded
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade300,
          width: isExpanded ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.expand_more,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isExpanded) ...[
            Divider(height: 1, color: Colors.grey.shade300),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: NextSlideAnimation(
                variant: NextSlideVariant.slideInTop,
                duration: const Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: children,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              ),
              if (trailing is Icon)
                trailing
              else
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: trailing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
