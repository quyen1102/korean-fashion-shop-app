import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    
    // Check if language has been selected
    final hasLanguage = prefs.containsKey('app_language');
    if (!hasLanguage) {
      context.go('/language-select');
      return;
    }

    // Check if onboarding is complete
    final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;
    if (!onboardingComplete) {
      context.go('/onboarding');
      return;
    }

    // Since auth is simulated, we go to Login if onboarding is complete
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    // AppLocalizations might not be fully active yet on first frame of splash if locale is being resolved.
    // So we use a default fallback or try to read it safely.
    final l10n = AppLocalizations.of(context);
    final tagline = l10n?.discoverKoreanFashion ?? "Discover Korean Fashion";

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SeoulStyle AI',
              style: AppTextStyles.displayLarge.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              tagline,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.secondaryText,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 48.0),
            const SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
