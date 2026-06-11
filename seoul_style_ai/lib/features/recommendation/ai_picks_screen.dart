import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/product_card.dart';
import '../../l10n/app_localizations.dart';
import '../profile/cubit/preference_cubit.dart';
import '../profile/cubit/preference_state.dart';
import '../home/cubit/product_cubit.dart';
import '../home/cubit/product_state.dart';
import 'cubit/recommendation_cubit.dart';
import 'cubit/recommendation_state.dart';

class AiPicksScreen extends StatefulWidget {
  const AiPicksScreen({super.key});

  @override
  State<AiPicksScreen> createState() => _AiPicksScreenState();
}

class _AiPicksScreenState extends State<AiPicksScreen> {
  bool _isRefreshing = false;

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

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });
    
    // Simulate short network/AI processing delay for premium feel
    await Future.delayed(const Duration(milliseconds: 600));
    _triggerAIRecommendations();
    
    if (mounted) {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.auto_awesome,
              color: AppColors.aiBadge,
              size: 20.0,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(l10n.aiPicksTitle),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isRefreshing ? null : _handleRefresh,
          ),
        ],
      ),
      body: BlocBuilder<PreferenceCubit, PreferenceState>(
        builder: (context, prefState) {
          if (prefState is PreferenceLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (prefState is PreferenceLoaded) {
            final preference = prefState.preference;
            
            // If user hasn't selected any favorite styles or categories yet
            if (preference.favoriteStyles.isEmpty && preference.favoriteCategories.isEmpty) {
              return _buildEmptyPreferencesState(context, l10n);
            }

            return BlocBuilder<RecommendationCubit, RecommendationState>(
              builder: (context, recState) {
                // Trigger auto-generation if state is initial
                if (recState is RecommendationInitial) {
                  _triggerAIRecommendations();
                  return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                }

                if (recState is RecommendationLoading || _isRefreshing) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                }

                if (recState is RecommendationLoaded) {
                  final picks = recState.recommendedProducts;

                  return RefreshIndicator(
                    onRefresh: _handleRefresh,
                    color: AppColors.primary,
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        // Preference Summary Card
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
                            child: _buildPreferenceCard(context, preference, l10n),
                          ),
                        ),

                        // Explanation text
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                            child: Text(
                              l10n.discoverKoreanFashionDesc, // Or a suitable explanation text
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.secondaryText,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),

                        const SliverToBoxAdapter(
                          child: SizedBox(height: AppSpacing.sm),
                        ),

                        // Product Grid
                        if (picks.isEmpty)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.xl),
                              child: Center(
                                child: Text(
                                  l10n.noProductsFound,
                                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
                                ),
                              ),
                            ),
                          )
                        else
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                            sliver: SliverGrid(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.54,
                                crossAxisSpacing: AppSpacing.md,
                                mainAxisSpacing: AppSpacing.md,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final item = picks[index];
                                  return ProductCard(
                                    product: item.product,
                                    showAiBadge: true,
                                  );
                                },
                                childCount: picks.length,
                              ),
                            ),
                          ),
                          
                        // Bottom Spacing
                        const SliverToBoxAdapter(
                          child: SizedBox(height: AppSpacing.xl),
                        ),
                      ],
                    ),
                  );
                }

                if (recState is RecommendationError) {
                  return Center(
                    child: Text('Error: ${recState.message}'),
                  );
                }

                return const SizedBox.shrink();
              },
            );
          }

          if (prefState is PreferenceError) {
            return Center(
              child: Text('Error loading preferences: ${prefState.message}'),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPreferenceCard(BuildContext context, dynamic preference, AppLocalizations l10n) {
    String getPriceText(String level) {
      switch (level.toLowerCase()) {
        case 'budget':
          return l10n.priceBudget;
        case 'premium':
          return l10n.pricePremium;
        case 'medium':
        default:
          return l10n.priceMedium;
      }
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.aiCardBg,
        borderRadius: AppRadius.largeBorderRadius,
        border: Border.all(color: AppColors.aiBadge.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.style_outlined,
                color: AppColors.aiBadge,
                size: 20.0,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  l10n.aiPicksSubtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.aiBadge,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push('/style-preference');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppRadius.mediumBorderRadius,
                    border: Border.all(color: AppColors.aiBadge.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.edit,
                        size: 12.0,
                        color: AppColors.aiBadge,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        l10n.edit,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.aiBadge,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          
          // Favorite Styles
          if (preference.favoriteStyles.isNotEmpty) ...[
            Text(
              l10n.stylePrefTitle,
              style: AppTextStyles.caption.copyWith(color: AppColors.secondaryText, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: preference.favoriteStyles.map<Widget>((style) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppRadius.smallBorderRadius,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    '#${style.toUpperCase()}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryText,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          // Categories & Budget Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (preference.favoriteCategories.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.categories,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.secondaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        preference.favoriteCategories.map((c) => c.toUpperCase()).join(', '),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.budget,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
                    decoration: BoxDecoration(
                      color: AppColors.accentLight,
                      borderRadius: AppRadius.smallBorderRadius,
                    ),
                    child: Text(
                      getPriceText(preference.pricePreference),
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPreferencesState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.auto_awesome,
              size: 80.0,
              color: AppColors.aiBadge,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.stylePrefRequired,
              style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.stylePrefRequiredDesc,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                context.push('/style-preference');
              },
              child: Text(l10n.setupStyleProfile),
            ),
          ],
        ),
      ),
    );
  }
}
