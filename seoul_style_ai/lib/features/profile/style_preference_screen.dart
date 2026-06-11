import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/selectable_chip.dart';
import '../../core/widgets/app_primary_button.dart';
import '../../l10n/app_localizations.dart';
import '../profile/cubit/preference_cubit.dart';
import '../profile/cubit/preference_state.dart';

class StylePreferenceScreen extends StatefulWidget {
  const StylePreferenceScreen({super.key});

  @override
  State<StylePreferenceScreen> createState() => _StylePreferenceScreenState();
}

class _StylePreferenceScreenState extends State<StylePreferenceScreen> {
  final List<String> _selectedStyles = [];
  final List<String> _selectedCategories = [];
  String _selectedPrice = 'medium';

  @override
  void initState() {
    super.initState();
    // Pre-populate if preference is already loaded (Edit mode from Profile)
    final state = context.read<PreferenceCubit>().state;
    if (state is PreferenceLoaded) {
      _selectedStyles.addAll(state.preference.favoriteStyles);
      _selectedCategories.addAll(state.preference.favoriteCategories);
      _selectedPrice = state.preference.pricePreference;
    }
  }

  void _onSavePressed() {
    context.read<PreferenceCubit>().savePreference(
          favoriteStyles: _selectedStyles,
          favoriteCategories: _selectedCategories,
          pricePreference: _selectedPrice,
        );
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final styles = ['minimal', 'casual', 'streetwear', 'office', 'luxury', 'korean'];
    final categories = ['tops', 'pants', 'dresses', 'shoes', 'bags', 'accessories'];

    final bool canSave = _selectedStyles.isNotEmpty && _selectedCategories.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.stylePreferences),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.stylePrefTitle,
                      style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.stylePrefSubtitle,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: styles.map((style) {
                        final isSelected = _selectedStyles.contains(style);
                        return SelectableChip(
                          label: style.toUpperCase(),
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedStyles.remove(style);
                              } else {
                                _selectedStyles.add(style);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      l10n.itemsPrefTitle,
                      style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: categories.map((cat) {
                        final isSelected = _selectedCategories.contains(cat);
                        return SelectableChip(
                          label: cat.toUpperCase(),
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedCategories.remove(cat);
                              } else {
                                _selectedCategories.add(cat);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      l10n.pricePrefTitle,
                      style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: Text(l10n.priceBudget),
                            selected: _selectedPrice == 'budget',
                            onSelected: (selected) {
                              if (selected) setState(() => _selectedPrice = 'budget');
                            },
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: ChoiceChip(
                            label: Text(l10n.priceMedium),
                            selected: _selectedPrice == 'medium',
                            onSelected: (selected) {
                              if (selected) setState(() => _selectedPrice = 'medium');
                            },
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: ChoiceChip(
                            label: Text(l10n.pricePremium),
                            selected: _selectedPrice == 'premium',
                            onSelected: (selected) {
                              if (selected) setState(() => _selectedPrice = 'premium');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: AppPrimaryButton(
                text: l10n.saveAndContinue,
                onPressed: canSave ? _onSavePressed : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
