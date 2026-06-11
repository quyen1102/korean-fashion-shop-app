import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../data/models/product.dart';
import '../../features/wishlist/cubit/wishlist_cubit.dart';
import '../../features/wishlist/cubit/wishlist_state.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool showAiBadge;

  const ProductCard({
    super.key,
    required this.product,
    this.showAiBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    final discountPrice = product.price;
    final hasDiscount = product.discountPercent > 0;

    return GestureDetector(
      onTap: () => context.push('/product/${product.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.largeBorderRadius,
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.network(
                    product.imageUrls.isNotEmpty ? product.imageUrls[0] : '',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFFF5F5F5),
                        child: const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2.0),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFF5F5F5),
                        child: const Center(
                          child: Icon(Icons.broken_image_outlined, color: AppColors.secondaryText),
                        ),
                      );
                    },
                  ),
                ),
                // Badges
                Positioned(
                  top: AppSpacing.xs,
                  left: AppSpacing.xs,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showAiBadge)
                        _buildBadge(
                          text: 'AI PICK',
                          bgColor: AppColors.aiBadge,
                          textColor: AppColors.surface,
                        ),
                      if (product.isSale)
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: _buildBadge(
                            text: 'SALE',
                            bgColor: AppColors.sale,
                            textColor: AppColors.surface,
                          ),
                        ),
                      if (product.isNew && !showAiBadge)
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: _buildBadge(
                            text: 'NEW',
                            bgColor: AppColors.primary,
                            textColor: AppColors.surface,
                          ),
                        ),
                    ],
                  ),
                ),
                // Wishlist Heart Icon
                Positioned(
                  top: AppSpacing.xs,
                  right: AppSpacing.xs,
                  child: BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      final isLiked = state.productIds.contains(product.id);
                      return GestureDetector(
                        onTap: () {
                          context.read<WishlistCubit>().toggleWishlist(product.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.xxs + 2),
                          decoration: const BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? AppColors.sale : AppColors.secondaryText,
                            size: 18.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xs - 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brand.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          _formatPrice(discountPrice),
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: hasDiscount ? AppColors.sale : AppColors.primaryText,
                          ),
                        ),
                        if (hasDiscount) ...[
                          const SizedBox(width: 4.0),
                          Flexible(
                            child: Text(
                              _formatPrice(product.originalPrice),
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.disabledText,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge({required String text, required Color bgColor, required Color textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          fontSize: 9.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    // Return formatted price, e.g., 35,000
    final val = price.toInt();
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return '${val.toString().replaceAllMapped(reg, (Match m) => '${m[1]},')}';
  }
}
