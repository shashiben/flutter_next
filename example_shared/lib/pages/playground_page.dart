import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';
import 'package:go_router/go_router.dart';

enum PlaygroundCategory {
  animation,
  flutterNext,
}

enum AnimationType {
  bounce,
  fadeIn,
  fadeOut,
  slide,
  zoom,
  flip,
  colorTween,
}

enum FlutterNextWidgetType {
  button,
  alert,
  accordion,
  breadcrumb,
}

class PlaygroundPage extends StatefulWidget {
  const PlaygroundPage({super.key, required this.state});
  final GoRouterState state;

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage>
    with TickerProviderStateMixin {
  late PlaygroundCategory _category;
  late AnimationType _animationType;
  late FlutterNextWidgetType _widgetType;
  late String _selectedVariant;
  late int _durationMs;
  late int _delayMs;
  late String _curveName;
  late NextButtonVariant _buttonVariant;
  late NextVariant _alertVariant;
  late bool _buttonEnabled;
  late bool _accordionExpanded;
  late bool _alertVisible;
  late AnimationController _controller;

  static final Map<String, Curve> _curveMap = {
    'linear': Curves.linear,
    'easeIn': Curves.easeIn,
    'easeOut': Curves.easeOut,
    'easeInOut': Curves.easeInOut,
    'bounceIn': Curves.bounceIn,
    'bounceOut': Curves.bounceOut,
    'elasticIn': Curves.elasticIn,
    'elasticOut': Curves.elasticOut,
  };

  Curve get _curve => _curveMap[_curveName] ?? Curves.easeOut;

  void _updateFromQueryParameters() {
    final params = widget.state.uri.queryParameters;

    // Category
    final categoryStr = params['category'] ?? 'animation';
    _category = categoryStr == 'flutterNext'
        ? PlaygroundCategory.flutterNext
        : PlaygroundCategory.animation;

    // Animation Type
    final animationTypeStr = params['animationType'] ?? 'bounce';
    _animationType = AnimationType.values.firstWhere(
      (e) => e.name == animationTypeStr,
      orElse: () => AnimationType.bounce,
    );

    // Widget Type
    final widgetTypeStr = params['widgetType'] ?? 'button';
    _widgetType = FlutterNextWidgetType.values.firstWhere(
      (e) => e.name == widgetTypeStr,
      orElse: () => FlutterNextWidgetType.button,
    );

    // Variant
    final variants = _getVariantsForType(_animationType);
    _selectedVariant =
        params['variant'] ?? (variants.isNotEmpty ? variants.first : '');
    if (!variants.contains(_selectedVariant) && variants.isNotEmpty) {
      _selectedVariant = variants.first;
    }

    // Duration & Delay
    _durationMs = int.tryParse(params['duration'] ?? '1000') ?? 1000;
    _delayMs = int.tryParse(params['delay'] ?? '0') ?? 0;

    // Curve
    _curveName = params['curve'] ?? 'easeOut';

    // Button Variant
    final buttonVariantStr = params['buttonVariant'] ?? 'filled';
    _buttonVariant = NextButtonVariant.values.firstWhere(
      (e) => e.name == buttonVariantStr,
      orElse: () => NextButtonVariant.filled,
    );

    // Alert Variant
    final alertVariantStr = params['alertVariant'] ?? 'primary';
    _alertVariant = NextVariant.values.firstWhere(
      (e) => e.name == alertVariantStr,
      orElse: () => NextVariant.primary,
    );

    // Boolean parameters
    _buttonEnabled = params['buttonEnabled'] != 'false';
    _accordionExpanded = params['accordionExpanded'] == 'true';
    _alertVisible = params['alertVisible'] != 'false';
  }

  void _updateQueryParameters() {
    final params = <String, String>{
      'category': _category.name,
    };

    if (_category == PlaygroundCategory.animation) {
      params.addAll({
        'animationType': _animationType.name,
        'variant': _selectedVariant,
        'duration': _durationMs.toString(),
        'delay': _delayMs.toString(),
        'curve': _curveName,
      });
    } else {
      params['widgetType'] = _widgetType.name;
      if (_widgetType == FlutterNextWidgetType.button) {
        params.addAll({
          'buttonVariant': _buttonVariant.name,
          'buttonEnabled': _buttonEnabled.toString(),
        });
      } else if (_widgetType == FlutterNextWidgetType.alert) {
        params.addAll({
          'alertVariant': _alertVariant.name,
          'alertVisible': _alertVisible.toString(),
        });
      } else if (_widgetType == FlutterNextWidgetType.accordion) {
        params['accordionExpanded'] = _accordionExpanded.toString();
      }
    }

    context.go('/playground?${Uri(queryParameters: params).query}');
  }

  @override
  void initState() {
    super.initState();
    _updateFromQueryParameters();
    _controller = AnimationController(
      duration: Duration(milliseconds: _durationMs),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(PlaygroundPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.uri != widget.state.uri) {
      setState(() {
        _updateFromQueryParameters();
        _controller.duration = Duration(milliseconds: _durationMs);
        _controller.reset();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> _getVariantsForType(AnimationType type) {
    switch (type) {
      case AnimationType.bounce:
        return NextBounceVariant.values.map((e) => e.name).toList();
      case AnimationType.fadeIn:
        return NextFadeInVariant.values.map((e) => e.name).toList();
      case AnimationType.fadeOut:
        return NextFadeOutVariant.values.map((e) => e.name).toList();
      case AnimationType.slide:
        return NextSlideVariant.values.map((e) => e.name).toList();
      case AnimationType.zoom:
        return NextZoomVariant.values.map((e) => e.name).toList();
      case AnimationType.flip:
        return NextFlipVariant.values.map((e) => e.name).toList();
      case AnimationType.colorTween:
        return ['colorTween'];
    }
  }

  Widget _buildAnimationPreview() {
    final card = Card(
      elevation: 4,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade400,
              Colors.purple.shade400,
            ],
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.star,
            color: Colors.white,
            size: 80,
          ),
        ),
      ),
    );

    switch (_animationType) {
      case AnimationType.bounce:
        const bounceVariants = NextBounceVariant.values;
        final bounceVariant = bounceVariants.firstWhere(
          (e) => e.name == _selectedVariant,
          orElse: () => bounceVariants.first,
        );
        return NextBounceAnimation(
          key: ValueKey('bounce_$_selectedVariant'),
          variant: bounceVariant,
          duration: Duration(milliseconds: _durationMs),
          delay: Duration(milliseconds: _delayMs),
          // Curve parameter is ignored - animation uses static curve based on variant
          curve: _curve,
          controller: _controller,
          autoStart: false,
          child: card,
        );
      case AnimationType.fadeIn:
        const fadeInVariants = NextFadeInVariant.values;
        final fadeInVariant = fadeInVariants.firstWhere(
          (e) => e.name == _selectedVariant,
          orElse: () => fadeInVariants.first,
        );
        return NextFadeInAnimation(
          key: ValueKey('fadeIn_$_selectedVariant'),
          variant: fadeInVariant,
          duration: Duration(milliseconds: _durationMs),
          delay: Duration(milliseconds: _delayMs),
          curve: _curve,
          controller: _controller,
          autoStart: false,
          child: card,
        );
      case AnimationType.fadeOut:
        const fadeOutVariants = NextFadeOutVariant.values;
        final fadeOutVariant = fadeOutVariants.firstWhere(
          (e) => e.name == _selectedVariant,
          orElse: () => fadeOutVariants.first,
        );
        return NextFadeOutAnimation(
          key: ValueKey('fadeOut_$_selectedVariant'),
          variant: fadeOutVariant,
          duration: Duration(milliseconds: _durationMs),
          delay: Duration(milliseconds: _delayMs),
          curve: _curve,
          controller: _controller,
          autoStart: false,
          child: card,
        );
      case AnimationType.slide:
        const slideVariants = NextSlideVariant.values;
        final slideVariant = slideVariants.firstWhere(
          (e) => e.name == _selectedVariant,
          orElse: () => slideVariants.first,
        );
        return NextSlideAnimation(
          key: ValueKey('slide_$_selectedVariant'),
          variant: slideVariant,
          duration: Duration(milliseconds: _durationMs),
          delay: Duration(milliseconds: _delayMs),
          curve: _curve,
          controller: _controller,
          autoStart: false,
          child: card,
        );
      case AnimationType.zoom:
        const zoomVariants = NextZoomVariant.values;
        final zoomVariant = zoomVariants.firstWhere(
          (e) => e.name == _selectedVariant,
          orElse: () => zoomVariants.first,
        );
        return NextZoomAnimation(
          key: ValueKey('zoom_$_selectedVariant'),
          variant: zoomVariant,
          duration: Duration(milliseconds: _durationMs),
          delay: Duration(milliseconds: _delayMs),
          curve: _curve,
          controller: _controller,
          autoStart: false,
          child: card,
        );
      case AnimationType.flip:
        const flipVariants = NextFlipVariant.values;
        final flipVariant = flipVariants.firstWhere(
          (e) => e.name == _selectedVariant,
          orElse: () => flipVariants.first,
        );
        return NextFlipAnimation(
          key: ValueKey('flip_$_selectedVariant'),
          variant: flipVariant,
          duration: Duration(milliseconds: _durationMs),
          delay: Duration(milliseconds: _delayMs),
          curve: _curve,
          controller: _controller,
          autoStart: false,
          child: card,
        );
      case AnimationType.colorTween:
        return NextColorTweenWidget(
          beginColor: Colors.blue.shade400,
          endColor: Colors.purple.shade400,
          duration: Duration(milliseconds: _durationMs),
          delay: Duration(milliseconds: _delayMs),
          curve: _curve,
          controller: _controller,
          child: (controller, color) {
            return Card(
              elevation: 4,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: color,
                ),
                child: const Center(
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),
            );
          },
        );
    }
  }

  Widget _buildFlutterNextPreview() {
    switch (_widgetType) {
      case FlutterNextWidgetType.button:
        return NextButton(
          variant: _buttonVariant,
          enabled: _buttonEnabled,
          onPressed: _buttonEnabled
              ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Button pressed!')),
                  );
                }
              : null,
          child: const Text('Button'),
        );
      case FlutterNextWidgetType.alert:
        return NextAlert(
          variant: _alertVariant,
          visible: _alertVisible,
          onClosePressed: _alertVisible
              ? () {
                  _alertVisible = false;
                  _updateQueryParameters();
                }
              : null,
          child: const Text('This is an alert message'),
        );
      case FlutterNextWidgetType.accordion:
        return NextAccordion(
          initiallyExpanded: _accordionExpanded,
          title: const Text('Accordion Title'),
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'This is the accordion content. You can expand and collapse it.',
              ),
            ),
          ],
        );
      case FlutterNextWidgetType.breadcrumb:
        return NextBreadCumb(
          childrens: [
            NextBreadcrumbItem(
              hoverBuilder: (context, isHovered) => Text(
                'Home',
                style: TextStyle(
                  color: isHovered
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            NextBreadcrumbItem(
              hoverBuilder: (context, isHovered) => Text(
                'Library',
                style: TextStyle(
                  color: isHovered
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            NextBreadcrumbItem(
              hoverBuilder: (context, isHovered) => Text(
                'Data',
                style: TextStyle(
                  color: isHovered
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildPreview() {
    if (_category == PlaygroundCategory.animation) {
      return _buildAnimationPreview();
    } else {
      return _buildFlutterNextPreview();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Playground'),
          elevation: 0,
        ),
        drawer: _buildDrawer(context),
        body: _buildBody(context),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 280,
            color: Theme.of(context).colorScheme.surface,
            child: _buildSidebar(context),
          ),
          // Main Content
          Expanded(
            child: Column(
              children: [
                AppBar(
                  title: const Text('Playground'),
                  elevation: 0,
                  automaticallyImplyLeading: false,
                ),
                Expanded(
                  child: _buildBody(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Playground',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Experiment with Next Animation and Flutter Next widgets',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 32),
          // Preview at top (Storybook style)
          Card(
            elevation: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Preview',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: _buildPreview(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Controls below
          Text(
            'Controls',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Animation controls
                    if (_category == PlaygroundCategory.animation) ...[
                      _buildDropdown<String>(
                        label: 'Variant',
                        value: _selectedVariant,
                        items: _getVariantsForType(_animationType),
                        onChanged: (value) {
                          setState(() {
                            _selectedVariant = value!;
                            _controller.reset();
                          });
                          _updateQueryParameters();
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSlider(
                              label: 'Duration (ms)',
                              value: _durationMs.toDouble(),
                              min: 100,
                              max: 3000,
                              divisions: 29,
                              onChanged: (value) {
                                _durationMs = value.toInt();
                                _controller.duration =
                                    Duration(milliseconds: _durationMs);
                                _updateQueryParameters();
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSlider(
                              label: 'Delay (ms)',
                              value: _delayMs.toDouble(),
                              min: 0,
                              max: 1000,
                              divisions: 20,
                              onChanged: (value) {
                                _delayMs = value.toInt();
                                _updateQueryParameters();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _controller.reset();
                                _controller.forward();
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Play'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _controller.reverse();
                              },
                              icon: const Icon(Icons.replay),
                              label: const Text('Reverse'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _controller.reset();
                              },
                              icon: const Icon(Icons.stop),
                              label: const Text('Reset'),
                            ),
                          ),
                        ],
                      ),
                    ],
                    // Flutter Next controls
                    if (_category == PlaygroundCategory.flutterNext) ...[
                      if (_widgetType == FlutterNextWidgetType.button) ...[
                        Row(
                          children: [
                            Expanded(
                              child: _buildDropdown<NextButtonVariant>(
                                label: 'Variant',
                                value: _buttonVariant,
                                items: NextButtonVariant.values,
                                itemBuilder: (variant) => variant.name,
                                onChanged: (value) {
                                  _buttonVariant = value!;
                                  _updateQueryParameters();
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Enabled',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Switch(
                                    value: _buttonEnabled,
                                    onChanged: (value) {
                                      _buttonEnabled = value;
                                      _updateQueryParameters();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (_widgetType == FlutterNextWidgetType.alert) ...[
                        _buildDropdown<NextVariant>(
                          label: 'Variant',
                          value: _alertVariant,
                          items: NextVariant.values
                              .where((v) => v != NextVariant.custom)
                              .toList(),
                          itemBuilder: (variant) => variant.name,
                          onChanged: (value) {
                            _alertVariant = value!;
                            _alertVisible = true;
                            _updateQueryParameters();
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'Visible',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(width: 16),
                            Switch(
                              value: _alertVisible,
                              onChanged: (value) {
                                _alertVisible = value;
                                _updateQueryParameters();
                              },
                            ),
                            const Spacer(),
                            if (!_alertVisible)
                              ElevatedButton(
                                onPressed: () {
                                  _alertVisible = true;
                                  _updateQueryParameters();
                                },
                                child: const Text('Show Alert'),
                              ),
                          ],
                        ),
                      ],
                      if (_widgetType == FlutterNextWidgetType.accordion) ...[
                        Row(
                          children: [
                            Text(
                              'Initially Expanded',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(width: 16),
                            Switch(
                              value: _accordionExpanded,
                              onChanged: (value) {
                                _accordionExpanded = value;
                                _updateQueryParameters();
                              },
                            ),
                          ],
                        ),
                      ],
                      if (_widgetType == FlutterNextWidgetType.breadcrumb) ...[
                        Text(
                          'Breadcrumb items are configured in code',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required void Function(T?) onChanged,
    String Function(T)? itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemBuilder?.call(item) ??
                    (item is Enum ? item.name : item.toString()),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required void Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              value.toInt().toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ],
    );
  }

  String _getCategoryName(PlaygroundCategory category) {
    switch (category) {
      case PlaygroundCategory.animation:
        return 'Animation';
      case PlaygroundCategory.flutterNext:
        return 'Flutter Next';
    }
  }

  String _getWidgetTypeName(FlutterNextWidgetType type) {
    switch (type) {
      case FlutterNextWidgetType.button:
        return 'Button';
      case FlutterNextWidgetType.alert:
        return 'Alert';
      case FlutterNextWidgetType.accordion:
        return 'Accordion';
      case FlutterNextWidgetType.breadcrumb:
        return 'Breadcrumb';
    }
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primaryContainer
                .withValues(alpha: 0.3),
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.2),
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.play_circle_filled,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Playground',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Next Animation & Flutter Next',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Navigation
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              _buildCategorySection(context, PlaygroundCategory.animation),
              _buildCategorySection(context, PlaygroundCategory.flutterNext),
              const Divider(height: 1),
              ListTile(
                leading: Icon(
                  Icons.grid_view,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                title: const Text('Grid Examples'),
                onTap: () {
                  context.go('/grid-examples');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.3),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.play_circle_filled,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Playground',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Next Animation & Flutter Next',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildCategorySection(context, PlaygroundCategory.animation),
                _buildCategorySection(context, PlaygroundCategory.flutterNext),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(
                    Icons.grid_view,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  title: const Text('Grid Examples'),
                  onTap: () {
                    context.go('/grid-examples');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(
      BuildContext context, PlaygroundCategory category) {
    final isSelected = _category == category;
    return ExpansionTile(
      leading: Icon(
        category == PlaygroundCategory.animation
            ? Icons.animation
            : Icons.widgets,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        _getCategoryName(category),
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      initiallyExpanded: isSelected,
      childrenPadding: const EdgeInsets.only(left: 8),
      children: category == PlaygroundCategory.animation
          ? _buildAnimationTypes(context)
          : _buildWidgetTypes(context),
    );
  }

  List<Widget> _buildAnimationTypes(BuildContext context) {
    return AnimationType.values.map((type) {
      final isSelectedType = _animationType == type;
      return ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        leading: Icon(
          Icons.tune,
          size: 20,
          color: isSelectedType
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        selected: isSelectedType,
        selectedTileColor: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withValues(alpha: 0.5),
        title: Text(
          type.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelectedType ? FontWeight.w500 : FontWeight.normal,
            color: isSelectedType
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        onTap: () {
          final variants = _getVariantsForType(type);
          final selectedVariant = variants.isNotEmpty ? variants.first : '';
          final params = <String, String>{
            'category': 'animation',
            'animationType': type.name,
            'variant': selectedVariant,
            'duration': _durationMs.toString(),
            'delay': _delayMs.toString(),
            'curve': _curveName,
          };
          final uri = Uri(path: '/playground', queryParameters: params);
          context.go(uri.toString());
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        },
      );
    }).toList();
  }

  List<Widget> _buildWidgetTypes(BuildContext context) {
    return FlutterNextWidgetType.values.map((type) {
      final isSelected = _widgetType == type;
      return ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        selected: isSelected,
        selectedTileColor: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withValues(alpha: 0.5),
        title: Text(
          _getWidgetTypeName(type),
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        onTap: () {
          final params = <String, String>{
            'category': 'flutterNext',
            'widgetType': type.name,
          };
          if (type == FlutterNextWidgetType.button) {
            params.addAll({
              'buttonVariant': _buttonVariant.name,
              'buttonEnabled': _buttonEnabled.toString(),
            });
          } else if (type == FlutterNextWidgetType.alert) {
            params.addAll({
              'alertVariant': _alertVariant.name,
              'alertVisible': _alertVisible.toString(),
            });
          } else if (type == FlutterNextWidgetType.accordion) {
            params['accordionExpanded'] = _accordionExpanded.toString();
          }
          final uri = Uri(path: '/playground', queryParameters: params);
          context.go(uri.toString());
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        },
      );
    }).toList();
  }
}
