import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/product_card.dart';
import '../../l10n/app_localizations.dart';
import '../home/cubit/product_cubit.dart';
import '../home/cubit/product_state.dart';
import 'cubit/wishlist_cubit.dart';
import 'cubit/wishlist_state.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            final count = state.productIds.length;
            return Text(
              count > 0 ? '${l10n.wishlistTitle} ($count)' : l10n.wishlistTitle,
            );
          },
        ),
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, wishlistState) {
          if (wishlistState.productIds.isEmpty) {
            return _buildEmptyState(context, l10n);
          }

          return BlocBuilder<ProductCubit, ProductState>(
            builder: (context, productState) {
              if (productState is ProductLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              }

              if (productState is ProductLoaded) {
                final wishlistProducts = productState.allProducts
                    .where((p) => wishlistState.productIds.contains(p.id))
                    .toList();

                if (wishlistProducts.isEmpty) {
                  return _buildEmptyState(context, l10n);
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.54,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                  ),
                  itemCount: wishlistProducts.length,
                  itemBuilder: (context, index) {
                    final product = wishlistProducts[index];
                    return ProductCard(
                      product: product,
                      // We don't force show the AI badge on standard wishlist screen unless desired
                      showAiBadge: false,
                    );
                  },
                );
              }

              if (productState is ProductError) {
                return Center(
                  child: Text('Error loading products: ${productState.message}'),
                );
              }

              return const SizedBox.shrink();
            },
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
              Icons.favorite_border_outlined,
              size: 72.0,
              color: AppColors.disabledText,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.wishlistEmpty,
              style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.wishlistEmptyDesc,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: () {
                context.go('/search');
              },
              child: Text(l10n.exploreProducts),
            ),
          ],
        ),
      ),
    );
  }
}
