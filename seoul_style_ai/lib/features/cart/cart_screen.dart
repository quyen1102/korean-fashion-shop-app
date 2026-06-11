import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../l10n/app_localizations.dart';
import '../cart/cubit/cart_cubit.dart';
import '../cart/cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myCart),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return _buildEmptyState(context, l10n);
          }

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: state.items.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return _buildCartItemRow(context, item);
                    },
                  ),
                ),
                
                // Summary block
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: const Border(
                      top: BorderSide(color: AppColors.border, width: 1.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSummaryRow(l10n.subtotal, _formatPrice(state.subtotal)),
                      const SizedBox(height: AppSpacing.xs),
                      if (state.discount > 0) ...[
                        _buildSummaryRow(
                          l10n.discount + ' (10%)',
                          '-${_formatPrice(state.discount)}',
                          isDiscount: true,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                      ],
                      _buildSummaryRow(
                        l10n.shippingFee,
                        state.shippingFee == 0.0 ? 'FREE' : _formatPrice(state.shippingFee),
                      ),
                      const Divider(height: AppSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.total,
                            style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _formatPrice(state.total),
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/checkout');
                        },
                        child: Text(l10n.checkout),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 72.0,
              color: AppColors.disabledText,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.cartEmpty,
              style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.exploreFashionNow,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: () {
                context.go('/search');
              },
              child: const Text('Start Shopping'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemRow(BuildContext context, dynamic item) {
    final product = item.product;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.largeBorderRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: AppRadius.mediumBorderRadius,
            child: Image.network(
              product.imageUrls[0],
              width: 80.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          
          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.brand.toUpperCase(),
                  style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    _buildAttributeBadge('${item.selectedSize}'),
                    const SizedBox(width: 4.0),
                    _buildAttributeBadge('${item.selectedColor}'),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatPrice(product.price),
                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    
                    // Quantity Controller
                    Row(
                      children: [
                        _buildQtyBtn(
                          icon: Icons.remove,
                          onPressed: () {
                            context.read<CartCubit>().updateQuantity(
                                  product,
                                  item.selectedSize,
                                  item.selectedColor,
                                  item.quantity - 1,
                                );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                          child: Text(
                            '${item.quantity}',
                            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        _buildQtyBtn(
                          icon: Icons.add,
                          onPressed: () {
                            context.read<CartCubit>().updateQuantity(
                                  product,
                                  item.selectedSize,
                                  item.selectedColor,
                                  item.quantity + 1,
                                );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(fontSize: 10.0),
      ),
    );
  }

  Widget _buildQtyBtn({required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Icon(icon, size: 14.0, color: AppColors.primaryText),
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
