import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/cubit/language_cubit.dart';
import '../../core/widgets/app_primary_button.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  String _selectedLang = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'Choose your language\nChọn ngôn ngữ của bạn\n언어를 선택해 주세요',
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Expanded(
                child: ListView(
                  children: [
                    _buildLanguageCard(
                      langCode: 'vi',
                      title: 'Tiếng Việt',
                      subtitle: 'Vietnamese',
                      flag: '🇻🇳',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildLanguageCard(
                      langCode: 'ko',
                      title: '한국어',
                      subtitle: 'Korean',
                      flag: '🇰🇷',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildLanguageCard(
                      langCode: 'en',
                      title: 'English',
                      subtitle: 'English',
                      flag: '🇺🇸',
                    ),
                  ],
                ),
              ),
              AppPrimaryButton(
                text: 'Continue / Tiếp tục / 계속하기',
                onPressed: () {
                  context.read<LanguageCubit>().setLanguage(_selectedLang);
                  context.go('/onboarding');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required String langCode,
    required String title,
    required String subtitle,
    required String flag,
  }) {
    final isSelected = _selectedLang == langCode;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLang = langCode;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md + 4.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.largeBorderRadius,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 28.0),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24.0,
              ),
          ],
        ),
      ),
    );
  }
}
