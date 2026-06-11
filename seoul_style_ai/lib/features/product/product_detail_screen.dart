import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_primary_button.dart';
import '../../data/models/product.dart';
import '../../features/cart/cubit/cart_cubit.dart';
import '../../features/profile/cubit/preference_cubit.dart';
import '../../features/profile/cubit/preference_state.dart';
import '../../features/recommendation/service/recommendation_service.dart';
import '../../features/wishlist/cubit/wishlist_cubit.dart';
import '../../features/wishlist/cubit/wishlist_state.dart';
import '../../l10n/app_localizations.dart';
import '../home/cubit/product_cubit.dart';
import '../home/cubit/product_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _imageController = PageController();
  int _currentImagePage = 0;
  
  String? _selectedSize;
  String? _selectedColor;

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  void _onAddToCart(Product product, AppLocalizations l10n) {
    if (_selectedSize == null || _selectedColor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select size and color / Vui lòng chọn size và màu')),
      );
      return;
    }

    context.read<CartCubit>().addItem(product, _selectedSize!, _selectedColor!);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.addedToCart),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: l10n.viewCart,
          onPressed: () {
            context.go('/cart');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final productState = context.watch<ProductCubit>().state;

    if (productState is! ProductLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final product = productState.allProducts.firstWhere(
      (p) => p.id == widget.productId,
      orElse: () => productState.allProducts.first,
    );

    // Dynamic AI reason extraction
    final prefState = context.watch<PreferenceCubit>().state;
    RecommendedProduct? rec;
    if (prefState is PreferenceLoaded) {
      rec = RecommendationService.buildRecommendation(product, prefState.preference);
    }

    final discountPrice = product.price;
    final hasDiscount = product.discountPercent > 0;

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable Info
          CustomScrollView(
            slivers: [
              // Image Carousel Header
              SliverAppBar(
                expandedHeight: 400.0,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryText),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  BlocBuilder<WishlistCubit, WishlistState>(
                    builder: (context, state) {
                      final isLiked = state.productIds.contains(product.id);
                      return IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? AppColors.sale : AppColors.primaryText,
                        ),
                        onPressed: () {
                          context.read<WishlistCubit>().toggleWishlist(product.id);
                        },
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                        controller: _imageController,
                        onPageChanged: (page) {
                          setState(() {
                            _currentImagePage = page;
                          });
                        },
                        itemCount: product.imageUrls.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            product.imageUrls[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      if (product.imageUrls.length > 1)
                        Positioned(
                          bottom: AppSpacing.md,
                          child: Row(
                            children: List.generate(
                              product.imageUrls.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                width: _currentImagePage == index ? 12.0 : 8.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  color: _currentImagePage == index
                                      ? AppColors.primary
                                      : AppColors.border,
                                  borderRadius: AppRadius.pillBorderRadius,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Product details
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brand.toUpperCase(),
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        product.name,
                        style: AppTextStyles.headlineMedium.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      
                      // Price & discount
                      Row(
                        children: [
                          Text(
                            _formatPrice(discountPrice),
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: hasDiscount ? AppColors.sale : AppColors.primaryText,
                            ),
                          ),
                          if (hasDiscount) ...[
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              _formatPrice(product.originalPrice),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.disabledText,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                              decoration: const BoxDecoration(
                                color: AppColors.sale,
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              ),
                              child: Text(
                                '-${product.discountPercent}%',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.surface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // AI Reason Card
                      if (rec != null) _buildAiReasonCard(rec, l10n),
                      const SizedBox(height: AppSpacing.lg),

                      // Size Selector
                      Text(
                        l10n.size,
                        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: AppSpacing.xs,
                        children: product.sizes.map((size) {
                          final isSelected = _selectedSize == size;
                          return ChoiceChip(
                            label: Text(size),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedSize = selected ? size : null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Color Selector
                      Text(
                        l10n.color,
                        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: AppSpacing.xs,
                        children: product.colors.map((color) {
                          final isSelected = _selectedColor == color;
                          return ChoiceChip(
                            label: Text(color),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                _selectedColor = selected ? color : null;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Description
                      Text(
                        l10n.description,
                        style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        product.description,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.secondaryText,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 100.0), // Padding to avoid sticky bottom bar overlap
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky Bottom Add-to-Cart bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: const Border(
                  top: BorderSide(color: AppColors.border, width: 1.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  )
                ],
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: AppTextStyles.caption.copyWith(color: AppColors.secondaryText),
                      ),
                      Text(
                        _formatPrice(discountPrice),
                        style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: AppPrimaryButton(
                      text: l10n.addToCart,
                      onPressed: () => _onAddToCart(product, l10n),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiReasonCard(RecommendedProduct rec, AppLocalizations l10n) {
    String message = '';
    if (rec.reasonKey == 'aiReasonStyleMatch') {
      message = l10n.aiReasonStyleMatch(rec.reasonParam?.toUpperCase() ?? '');
    } else if (rec.reasonKey == 'aiReasonTrending') {
      message = l10n.aiReasonTrending;
    } else if (rec.reasonKey == 'aiReasonSale') {
      message = l10n.aiReasonSale;
    } else {
      message = l10n.aiReasonDefault;
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.aiCardBg,
        borderRadius: AppRadius.largeBorderRadius,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.auto_awesome,
            color: AppColors.aiBadge,
            size: 20.0,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SeoulStyle AI Pick',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.aiBadge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  message,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryText,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    final val = price.toInt();
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return '${val.toString().replaceAllMapped(reg, (Match m) => '${m[1]},')}';
  }
}
