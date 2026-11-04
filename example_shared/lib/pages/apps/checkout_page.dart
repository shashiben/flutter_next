import 'package:flutter/material.dart';
import 'package:flutter_next/flutter_next.dart';

import '../../data/demo_data.dart';
import '../../widgets/app/app_card.dart';
import '../../widgets/app/app_space.dart';
import '../../widgets/app/app_top_bar.dart';

/// A checkout flow built with the layout kit.
///
/// The summary moves above the form on phones through [NextTrack.order], so
/// the running total is always one scroll away.
class CheckoutView extends StatefulWidget {
  /// Creates the checkout.
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  static const _shippingOptions =
      <({String label, String detail, String price})>[
        (
          label: 'Express · 2 days',
          detail: 'Delivered by Tuesday',
          price: r'$12',
        ),
        (
          label: 'Standard · 5 days',
          detail: 'Delivered by Friday',
          price: 'Free',
        ),
        (label: 'Pickup · today', detail: 'Ready in 3 hours', price: 'Free'),
      ];

  bool _promoApplied = false;
  bool _giftWrap = false;
  String _shipping = _shippingOptions.first.label;

  double get _subtotal {
    var total = 0.0;
    for (final line in kDemoCartLines) {
      total += line.price * line.quantity;
    }
    return total;
  }

  double get _shippingCost => _shipping.startsWith('Express') ? 12 : 0;

  double get _discount => _promoApplied ? _subtotal * 0.1 : 0;

  double get _total =>
      _subtotal + _shippingCost - _discount + (_giftWrap ? 4 : 0);

  @override
  Widget build(BuildContext context) {
    final gap = context.gap;
    return Column(
      children: [
        const AppTopBar(
          brand: 'Northwind Supply',
          subtitle: 'Checkout · order #4821',
          actions: <Widget>[_SecureBadge()],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: NextContainer(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              padding: context.pagePadding,
              children: [
                const _CheckoutSteps(),
                SizedBox(height: gap),
                NextRow(
                  gutter: gap,
                  children: [
                    NextCol(
                      span: const NextSpan(lg: 7),
                      order: const NextTrack(xs: 2, lg: 1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const _ContactCard(),
                          SizedBox(height: gap),
                          _ShippingCard(
                            shipping: _shipping,
                            onShipping: (value) =>
                                setState(() => _shipping = value),
                          ),
                          SizedBox(height: gap),
                          const _PaymentCard(),
                          SizedBox(height: gap),
                          _PromoCard(
                            applied: _promoApplied,
                            onApply: () => setState(() => _promoApplied = true),
                          ),
                        ],
                      ),
                    ),
                    NextCol(
                      span: const NextSpan(lg: 5),
                      order: const NextTrack(xs: 1, lg: 2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _SummaryCard(
                            subtotal: _subtotal,
                            shipping: _shippingCost,
                            discount: _discount,
                            giftWrap: _giftWrap,
                            total: _total,
                            onGiftWrap: (value) =>
                                setState(() => _giftWrap = value),
                          ),
                          SizedBox(height: gap),
                          const _DeliveryCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SecureBadge extends StatelessWidget {
  const _SecureBadge();

  @override
  Widget build(BuildContext context) {
    return const NextShow(
      from: Breakpoint.sm,
      fallback: SizedBox.shrink(),
      child: _SecureBadgeLabel(),
    );
  }
}

class _SecureBadgeLabel extends StatelessWidget {
  const _SecureBadgeLabel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock_outline_rounded,
          size: 16,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Text(
          'Encrypted payment',
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _CheckoutSteps extends StatelessWidget {
  const _CheckoutSteps();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NextBreadcrumb(
      variant: NextBreadcrumbVariant.scroll,
      children: <NextBreadcrumbItem>[
        _step(theme, 'Cart'),
        _step(theme, 'Shipping'),
        _step(theme, 'Payment', active: true),
        _step(theme, 'Confirmation'),
      ],
    );
  }

  NextBreadcrumbItem _step(
    ThemeData theme,
    String label, {
    bool active = false,
  }) {
    return NextBreadcrumbItem(
      hoverBuilder: (context, isHovered) => Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: active
              ? theme.colorScheme.primary
              : isHovered
              ? theme.colorScheme.onSurface
              : theme.colorScheme.onSurfaceVariant,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeading(
            title: 'Contact',
            subtitle: 'We only use this to send the order updates',
          ),
          SizedBox(height: 16),
          _Field(
            label: 'Email',
            hint: 'you@company.com',
            icon: Icons.mail_outline_rounded,
          ),
          SizedBox(height: 12),
          _Field(
            label: 'Phone',
            hint: '+1 555 0134',
            icon: Icons.phone_outlined,
          ),
        ],
      ),
    );
  }
}

class _ShippingCard extends StatelessWidget {
  const _ShippingCard({required this.shipping, required this.onShipping});

  final String shipping;
  final ValueChanged<String> onShipping;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(
            title: 'Shipping',
            subtitle: 'Where should the order go?',
          ),
          const SizedBox(height: 12),
          RadioGroup<String>(
            groupValue: shipping,
            onChanged: (value) {
              if (value != null) {
                onShipping(value);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final option in _CheckoutViewState._shippingOptions)
                  RadioListTile<String>(
                    value: option.label,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(option.label),
                    subtitle: Text(option.detail),
                    secondary: Text(option.price),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const _Field(
            label: 'Address',
            hint: '14 Harbour Road, Lisbon',
            icon: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeading(
            title: 'Payment',
            subtitle: 'All transactions are encrypted',
          ),
          SizedBox(height: 16),
          NextAccordion(
            title: Text('Card'),
            subtitle: Text('Visa, Mastercard, Amex'),
            leading: Icon(Icons.credit_card_rounded),
            initiallyExpanded: true,
            children: <Widget>[
              _Field(
                label: 'Card number',
                hint: '4242 4242 4242 4242',
                icon: Icons.credit_card_outlined,
              ),
              SizedBox(height: 12),
              NextRow(
                children: [
                  NextCol(
                    span: NextSpan(xs: 6),
                    child: _Field(label: 'Expiry', hint: '04/28'),
                  ),
                  NextCol(
                    span: NextSpan(xs: 6),
                    child: _Field(label: 'CVC', hint: '123'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          NextAccordion(
            title: Text('Invoice'),
            subtitle: Text('Pay by bank transfer'),
            leading: Icon(Icons.receipt_outlined),
            children: <Widget>[
              _Field(label: 'IBAN', hint: 'PT50 0002 0123 1234 5678 9015 4'),
            ],
          ),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard({required this.applied, required this.onApply});

  final bool applied;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(
            title: 'Promo code',
            subtitle: 'Team orders get 10% off',
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Expanded(
                child: _Field(label: 'Code', hint: 'TEAM10'),
              ),
              const SizedBox(width: 12),
              NextButton(
                margin: EdgeInsets.zero,
                variant: NextButtonVariant.outlined,
                onPressed: onApply,
                child: const AppButtonLabel('Apply'),
              ),
            ],
          ),
          if (applied) ...[
            const SizedBox(height: 14),
            const NextAlert(
              variant: NextVariant.success,
              title: Text('TEAM10 applied'),
              child: Text('10% off the order total.'),
            ),
          ],
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.giftWrap,
    required this.total,
    required this.onGiftWrap,
  });

  final double subtotal;
  final double shipping;
  final double discount;
  final bool giftWrap;
  final double total;
  final ValueChanged<bool> onGiftWrap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(
            title: 'Order summary',
            subtitle: '3 items · order #4821',
          ),
          const SizedBox(height: 16),
          for (final line in kDemoCartLines) ...[
            _SummaryLine(line: line),
            const SizedBox(height: 14),
          ],
          const Divider(height: 24),
          _PriceRow(label: 'Subtotal', value: subtotal),
          const SizedBox(height: 8),
          _PriceRow(label: 'Shipping', value: shipping),
          if (discount > 0) ...[
            const SizedBox(height: 8),
            _PriceRow(
              label: 'Promo TEAM10',
              value: -discount,
              tone: theme.colorScheme.primary,
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: Text('Gift wrap')),
              Switch(value: giftWrap, onChanged: onGiftWrap),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Total',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          NextButton(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(vertical: 16),
            onPressed: () {},
            child: AppButtonLabel('Pay \$${total.toStringAsFixed(2)}'),
          ),
          const SizedBox(height: 12),
          Text(
            'You can cancel or edit the order until it ships.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeading(
            title: 'Delivery',
            subtitle: 'Live carrier estimates',
          ),
          const SizedBox(height: 14),
          for (final leg in const <({String label, String value})>[
            (label: 'Picked up', value: 'Today, 6 pm'),
            (label: 'In transit', value: 'Tomorrow, 9 am'),
            (label: 'Delivered', value: 'Tuesday, by 6 pm'),
          ]) ...[
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    leg.label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  leg.value,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({required this.line});

  final DemoCartLine line;

  @override
  Widget build(BuildContext context) {
    return SampleProductTile(
      name: line.name,
      price: '\$${(line.price * line.quantity).toStringAsFixed(0)}',
      detail: '${line.detail} · qty ${line.quantity}',
      icon: line.icon,
      accent: line.accent,
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value, this.tone});

  final String label;
  final double value;
  final Color? tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: tone,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, this.hint, this.icon});

  final String label;
  final String? hint;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        prefixIcon: icon == null
            ? null
            : Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        isDense: true,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.45,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
    );
  }
}

/// The checkout demo page.
class CheckoutPage extends StatelessWidget {
  /// Creates the checkout page.
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NextScope(
      containerMaxWidths: <Breakpoint, double?>{
        Breakpoint.sm: 640,
        Breakpoint.md: 900,
        Breakpoint.lg: 1200,
        Breakpoint.xl: 1400,
        Breakpoint.xxl: 1600,
      },
      child: CheckoutView(),
    );
  }
}
