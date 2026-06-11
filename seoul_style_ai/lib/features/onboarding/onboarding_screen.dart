import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../l10n/app_localizations.dart';
import '../../core/widgets/app_primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = [
      _OnboardingPageData(
        title: l10n.discoverKoreanFashion,
        description: l10n.discoverKoreanFashionDesc,
        icon: Icons.explore_outlined,
        bgColor: AppColors.accentLight,
        accentColor: AppColors.accent,
      ),
      _OnboardingPageData(
        title: l10n.aiPicksYourStyle,
        description: l10n.aiPicksYourStyleDesc,
        icon: Icons.auto_awesome_outlined,
        bgColor: const Color(0xFFF7F3FF),
        accentColor: AppColors.aiBadge,
      ),
      _OnboardingPageData(
        title: l10n.shopFasterEasier,
        description: l10n.shopFasterEasierDesc,
        icon: Icons.shopping_bag_outlined,
        bgColor: AppColors.cream,
        accentColor: const Color(0xFFE2B49A),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_currentPage < pages.length - 1)
            TextButton(
              onPressed: _completeOnboarding,
              child: Text(
                l10n.skip,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return _buildPage(page);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => _buildDot(index),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppPrimaryButton(
                text: _currentPage == pages.length - 1
                    ? l10n.getStarted
                    : l10n.continueBtn,
                onPressed: () {
                  if (_currentPage == pages.length - 1) {
                    _completeOnboarding();
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(_OnboardingPageData page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: page.bgColor,
            borderRadius: AppRadius.xlBorderRadius,
          ),
          child: Icon(
            page.icon,
            size: 80.0,
            color: page.accentColor,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          page.title,
          textAlign: TextAlign.center,
          style: AppTextStyles.headlineLarge.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          page.description,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.secondaryText,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int index) {
    final isSelected = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isSelected ? 24.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.border,
        borderRadius: AppRadius.pillBorderRadius,
      ),
    );
  }
}

class _OnboardingPageData {
  final String title;
  final String description;
  final IconData icon;
  final Color bgColor;
  final Color accentColor;

  const _OnboardingPageData({
    required this.title,
    required this.description,
    required this.icon,
    required this.bgColor,
    required this.accentColor,
  });
}
