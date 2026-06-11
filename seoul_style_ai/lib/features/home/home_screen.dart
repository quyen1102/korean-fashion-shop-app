import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/product_card.dart';
import '../../data/models/product.dart';
import '../../l10n/app_localizations.dart';
import '../auth/cubit/auth_cubit.dart';
import '../auth/cubit/auth_state.dart';
import '../profile/cubit/preference_cubit.dart';
import '../profile/cubit/preference_state.dart';
import '../recommendation/cubit/recommendation_cubit.dart';
import '../recommendation/cubit/recommendation_state.dart';
import 'cubit/product_cubit.dart';
import 'cubit/product_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _bannerController = PageController();
  int _currentBannerPage = 0;
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();
    _startBannerTimer();
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(milliseconds: 3500), (timer) {
      if (!mounted) return;
      setState(() {
        _currentBannerPage = (_currentBannerPage + 1) % 3;
      });
      _bannerController.animateToPage(
        _currentBannerPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  void _triggerAIRecommendations() {
    final prefState = context.read<PreferenceCubit>().state;
    final productState = context.read<ProductCubit>().state;

    if (prefState is PreferenceLoaded && productState is ProductLoaded) {
      context.read<RecommendationCubit>().generateRecommendations(
            preference: prefState.preference,
            allProducts: productState.allProducts,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    // Trigger recommendations when data is available
    _triggerAIRecommendations();

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, productState) {
            if (productState is ProductLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            if (productState is ProductError) {
              return Center(child: Text(productState.message));
            }
            if (productState is ProductLoaded) {
              final allProducts = productState.allProducts;
              final trendingProducts = allProducts.where((p) => p.isTrending).take(6).toList();
              final saleProducts = allProducts.where((p) => p.isSale).take(4).toList();

              return CustomScrollView(
                slivers: [
                  // SliverAppBar: Greeting & Search Bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          const SizedBox(height: AppSpacing.md),
                          _buildSearchBar(),
                        ],
                      ),
                    ),
                  ),

                  // SliverToBoxAdapter: Banner
                  SliverToBoxAdapter(
                    child: _buildBannerCarousel(l10n),
                  ),

                  // SliverToBoxAdapter: Categories Horizontal Chips
                  SliverToBoxAdapter(
                    child: _buildCategories(l10n),
                  ),

                  // SliverToBoxAdapter: AI Picks for You
                  SliverToBoxAdapter(
                    child: _buildAiPicksSection(l10n),
                  ),

                  // SliverToBoxAdapter: Trending in Korea
                  SliverToBoxAdapter(
                    child: _buildSection(
                      title: l10n.trendingInKorea,
                      products: trendingProducts,
                    ),
                  ),

                  // SliverToBoxAdapter: Discount Today
                  SliverToBoxAdapter(
                    child: _buildGridSection(
                      title: l10n.discountToday,
                      products: saleProducts,
                    ),
                  ),
                  
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.xxl),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        String displayName = 'Guest';
        if (state is AuthAuthenticated) {
          displayName = state.email.split('@')[0];
          if (displayName.length > 1) {
            displayName = displayName[0].toUpperCase() + displayName.substring(1);
          }
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.homeGreeting(displayName),
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
                ),
                Text(
                  AppLocalizations.of(context)!.homeTitle,
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            const CircleAvatar(
              backgroundColor: AppColors.border,
              child: Icon(Icons.person_outline, color: AppColors.primaryText),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => context.go('/search'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm + 2),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: AppRadius.largeBorderRadius,
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.secondaryText),
            const SizedBox(width: AppSpacing.sm),
            Text(
              AppLocalizations.of(context)!.searchHint,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.disabledText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel(AppLocalizations l10n) {
    final bannerColors = [AppColors.accentLight, const Color(0xFFF7F3FF), AppColors.cream];
    final bannerTitles = ['Seoul Spring\nCollection', 'AI Personalised\nStyle Picks', 'Summer Sale\nUp to 50% Off'];
    final bannerTags = ['TRENDING', 'AI STYLE', 'SPECIAL OFFER'];

    return Container(
      height: 160.0,
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: PageView.builder(
        controller: _bannerController,
        onPageChanged: (page) {
          setState(() {
            _currentBannerPage = page;
          });
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            decoration: BoxDecoration(
              color: bannerColors[index],
              borderRadius: AppRadius.largeBorderRadius,
            ),
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          bannerTags[index],
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 9.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.surface,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        bannerTitles[index],
                        style: AppTextStyles.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 40.0,
                  color: AppColors.primary,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories(AppLocalizations l10n) {
    final categories = ['All', 'Tops', 'Pants', 'Dresses', 'Shoes', 'Bags', 'Accessories'];
    return Container(
      height: 40.0,
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final catName = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: ActionChip(
              label: Text(catName),
              backgroundColor: const Color(0xFFF5F5F5),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.pillBorderRadius,
              ),
              onPressed: () {
                context.read<ProductCubit>().setCategory(catName);
                context.go('/search');
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAiPicksSection(AppLocalizations l10n) {
    return BlocBuilder<RecommendationCubit, RecommendationState>(
      builder: (context, state) {
        if (state is RecommendationLoaded && state.recommendedProducts.isNotEmpty) {
          final products = state.recommendedProducts.take(4).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.aiPicksForYou,
                      style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () => context.go('/ai-picks'),
                      child: Text(
                        l10n.viewAll,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.aiBadge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Container(
                height: 310.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final rec = products[index];
                    return Container(
                      width: 160.0,
                      margin: const EdgeInsets.only(right: AppSpacing.md),
                      child: ProductCard(product: rec.product, showAiBadge: true),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSection({required String title, required List<Product> products}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => context.go('/search'),
                child: Text(
                  AppLocalizations.of(context)!.viewAll,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: 310.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                width: 160.0,
                margin: const EdgeInsets.only(right: AppSpacing.md),
                child: ProductCard(product: product),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }

  Widget _buildGridSection({required String title, required List<Product> products}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => context.go('/search'),
                child: Text(
                  AppLocalizations.of(context)!.viewAll,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.54,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ],
    );
  }
}
