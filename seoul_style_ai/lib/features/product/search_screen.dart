import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/product_card.dart';
import '../../l10n/app_localizations.dart';
import '../home/cubit/product_cubit.dart';
import '../home/cubit/product_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controller if there is an existing query in cubit state
    final state = context.read<ProductCubit>().state;
    if (state is ProductLoaded) {
      _searchController.text = state.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSortBottomSheet(BuildContext context, ProductLoaded state, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (ctx) {
        final currentSort = state.selectedSortOrder;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSortTile(ctx, 'popular', 'Popular / Thịnh hành / 인기순', currentSort),
                _buildSortTile(ctx, 'newest', 'Newest / Mới nhất / 신상품순', currentSort),
                _buildSortTile(ctx, 'priceLow', 'Price: Low to High / Giá: Thấp đến Cao / 가격 낮은순', currentSort),
                _buildSortTile(ctx, 'discountHigh', 'Discount: High to Low / Giảm giá nhiều / 할인율 높은순', currentSort),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSortTile(BuildContext context, String value, String label, String currentSort) {
    final isSelected = value == currentSort;
    return ListTile(
      title: Text(
        label,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () {
        context.read<ProductCubit>().setSortOrder(value);
        Navigator.pop(context);
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context, ProductLoaded state, AppLocalizations l10n) {
    String? tempPriceLevel = state.priceLevelFilter;
    bool tempIsSaleOnly = state.isSaleFilter;
    String tempCategory = state.selectedCategory;

    final categories = ['All', 'Tops', 'Pants', 'Dresses', 'Shoes', 'Bags', 'Accessories'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.lg,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + AppSpacing.lg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.filter,
                    style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  
                  // Category filter
                  Text('Category', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    children: categories.map((cat) {
                      final isSelected = tempCategory.toLowerCase() == cat.toLowerCase();
                      return ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setModalState(() {
                              tempCategory = cat;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Price level filter
                  Text(l10n.pricePrefTitle, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      ChoiceChip(
                        label: Text(l10n.priceBudget),
                        selected: tempPriceLevel == 'budget',
                        onSelected: (selected) {
                          setModalState(() {
                            tempPriceLevel = selected ? 'budget' : null;
                          });
                        },
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      ChoiceChip(
                        label: Text(l10n.priceMedium),
                        selected: tempPriceLevel == 'medium',
                        onSelected: (selected) {
                          setModalState(() {
                            tempPriceLevel = selected ? 'medium' : null;
                          });
                        },
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      ChoiceChip(
                        label: Text(l10n.pricePremium),
                        selected: tempPriceLevel == 'premium',
                        onSelected: (selected) {
                          setModalState(() {
                            tempPriceLevel = selected ? 'premium' : null;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Sale filter switch
                  SwitchListTile(
                    title: Text(l10n.discountToday, style: AppTextStyles.bodyMedium),
                    value: tempIsSaleOnly,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) {
                      setModalState(() {
                        tempIsSaleOnly = val;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setModalState(() {
                              tempPriceLevel = null;
                              tempIsSaleOnly = false;
                              tempCategory = 'All';
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ProductCubit>().setCategory(tempCategory);
                            context.read<ProductCubit>().applyFilters(
                                  priceLevel: tempPriceLevel,
                                  isSaleOnly: tempIsSaleOnly,
                                );
                            Navigator.pop(context);
                          },
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.md),
              // Search Input field
              TextField(
                controller: _searchController,
                onChanged: (val) {
                  context.read<ProductCubit>().setSearchQuery(val);
                },
                decoration: InputDecoration(
                  hintText: l10n.searchHint,
                  prefixIcon: const Icon(Icons.search, color: AppColors.secondaryText),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: AppColors.secondaryText),
                          onPressed: () {
                            _searchController.clear();
                            context.read<ProductCubit>().setSearchQuery('');
                          },
                        )
                      : null,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Filter & Sort Row
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    final hasActiveFilters = state.priceLevelFilter != null ||
                        state.isSaleFilter ||
                        state.selectedCategory.toLowerCase() != 'all';

                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showFilterBottomSheet(context, state, l10n),
                            icon: Icon(
                              Icons.tune,
                              size: 16,
                              color: hasActiveFilters ? AppColors.aiBadge : AppColors.primaryText,
                            ),
                            label: Text(
                              l10n.filter,
                              style: TextStyle(
                                color: hasActiveFilters ? AppColors.aiBadge : AppColors.primaryText,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showSortBottomSheet(context, state, l10n),
                            icon: const Icon(Icons.sort, size: 16),
                            label: Text(l10n.sort),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Product Grid List
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                    }
                    if (state is ProductLoaded) {
                      final products = state.filteredProducts;

                      if (products.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search_off_outlined,
                                size: 64.0,
                                color: AppColors.disabledText,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                l10n.noProductsFound,
                                style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                l10n.tryAnotherKeyword,
                                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.productsFound(products.length),
                            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: AppSpacing.md,
                                mainAxisSpacing: AppSpacing.md,
                                childAspectRatio: 0.54,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                final isAiRecommended = state.selectedCategory.toLowerCase() == 'all' && 
                                    index % 3 == 0; // Simulate AI Picks inside general feed
                                return ProductCard(
                                  product: product,
                                  showAiBadge: isAiRecommended,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
