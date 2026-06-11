import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../l10n/app_localizations.dart';
import '../cart/cubit/cart_cubit.dart';
import 'cubit/checkout_cubit.dart';
import 'cubit/checkout_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  void _onPayNowPressed(BuildContext context, dynamic cartState) {
    context.read<CheckoutCubit>().processPayment(
          items: cartState.items,
          totalAmount: cartState.total,
        );
  }

  void _showProcessingDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async => false, // Prevent back button dismissal
        child: Dialog(
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.largeBorderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl, horizontal: AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(color: AppColors.primary),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.processingPayment,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cartState = context.read<CartCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.checkout),
      ),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutProcessing) {
            _showProcessingDialog(context, l10n);
          } else if (state is CheckoutSuccess) {
            // Dismiss loading dialog first
            Navigator.of(context, rootNavigator: true).pop();
            // Clear cart
            context.read<CartCubit>().clearCart();
            // Go to payment success
            context.go('/payment-success');
          } else if (state is CheckoutFailure) {
            // Dismiss loading dialog
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment failed: ${state.message}')),
            );
          }
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Address Section
                      Text(
                        l10n.shippingAddress,
                        style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: AppRadius.largeBorderRadius,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_outlined, color: AppColors.primary),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kim Quyen',
                                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    '123 Gangnam-gu, Seoul, Korea',
                                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                                  ),
                                  Text(
                                    'Phone: +82 010-1234-5678',
                                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Payment Method Section
                      Text(
                        l10n.paymentMethod,
                        style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      BlocBuilder<CheckoutCubit, CheckoutState>(
                        builder: (context, state) {
                          final selectedMethod = state is CheckoutInitial
                              ? state.selectedPaymentMethod
                              : 'cod';
                          return Column(
                            children: [
                              _buildPaymentMethodTile('cod', '💵 Cash on Delivery', selectedMethod),
                              const SizedBox(height: AppSpacing.xs),
                              _buildPaymentMethodTile('card', '💳 Credit Card (Demo)', selectedMethod),
                              const SizedBox(height: AppSpacing.xs),
                              _buildPaymentMethodTile('kakaopay', '🟡 KakaoPay (Demo)', selectedMethod),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Summary Section
                      Text(
                        'Order Summary',
                        style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: AppRadius.largeBorderRadius,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            ...cartState.items.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${item.product.name} (x${item.quantity})',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.bodyMedium,
                                      ),
                                    ),
                                    Text(
                                      _formatPrice(item.product.price * item.quantity),
                                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            const Divider(height: AppSpacing.md),
                            _buildSummaryRow(l10n.subtotal, _formatPrice(cartState.subtotal)),
                            if (cartState.discount > 0) ...[
                              const SizedBox(height: AppSpacing.xs),
                              _buildSummaryRow(l10n.discount, '-${_formatPrice(cartState.discount)}', isDiscount: true),
                            ],
                            const SizedBox(height: AppSpacing.xs),
                            _buildSummaryRow(
                              l10n.shippingFee,
                              cartState.shippingFee == 0.0 ? 'FREE' : _formatPrice(cartState.shippingFee),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Pay Now sticky bar
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: const Border(
                    top: BorderSide(color: AppColors.border, width: 1.0),
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.total,
                          style: AppTextStyles.caption.copyWith(color: AppColors.secondaryText),
                        ),
                        Text(
                          _formatPrice(cartState.total),
                          style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _onPayNowPressed(context, cartState),
                        child: Text(l10n.payNow),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(String method, String label, String selectedMethod) {
    final isSelected = method == selectedMethod;
    return GestureDetector(
      onTap: () {
        context.read<CheckoutCubit>().selectPaymentMethod(method);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm + 4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.largeBorderRadius,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              const Icon(Icons.radio_button_checked, color: AppColors.primary)
            else
              const Icon(Icons.radio_button_off, color: AppColors.border),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: isDiscount ? AppColors.sale : AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  String _formatPrice(double price) {
    final val = price.toInt();
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return '${val.toString().replaceAllMapped(reg, (Match m) => '${m[1]},')}';
  }
}
