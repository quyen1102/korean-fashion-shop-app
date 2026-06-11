import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/cubit/language_cubit.dart';
import '../../core/cubit/language_state.dart';
import '../../l10n/app_localizations.dart';
import '../auth/cubit/auth_cubit.dart';
import '../auth/cubit/auth_state.dart';
import '../cart/cubit/cart_cubit.dart';
import '../cart/cubit/cart_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLanguageBottomSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (ctx) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            final currentLang = state.locale.languageCode;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Text(
                        l10n.chooseLanguage,
                        style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(),
                    _buildLanguageTile(context, 'vi', l10n.tiengViet, currentLang),
                    _buildLanguageTile(context, 'ko', l10n.hanQuoc, currentLang),
                    _buildLanguageTile(context, 'en', l10n.tiengAnh, currentLang),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageTile(BuildContext context, String code, String label, String currentLang) {
    final isSelected = code == currentLang;
    return ListTile(
      title: Text(
        label,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () {
        context.read<LanguageCubit>().setLanguage(code);
        Navigator.pop(context);
      },
    );
  }

  void _showLogoutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.logout),
          content: Text(l10n.logoutConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancel, style: const TextStyle(color: AppColors.secondaryText)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.read<AuthCubit>().logout();
              },
              child: Text(l10n.logout, style: const TextStyle(color: AppColors.sale, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(l10n.aboutApp),
          content: Text(l10n.aboutDesc),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.close, style: const TextStyle(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated || state is AuthInitial) {
          context.go('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.profileTitle),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          children: [
            // User info card
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final String email = state is AuthAuthenticated ? state.email : 'guest@seoulstyle.ai';
                final String username = email.split('@')[0];
                final String displayUsername = username.isEmpty 
                    ? 'Guest' 
                    : username[0].toUpperCase() + username.substring(1);
                final String initials = username.isNotEmpty ? username[0].toUpperCase() : 'G';

                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppRadius.largeBorderRadius,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundColor: AppColors.accentLight,
                        child: Text(
                          initials,
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayUsername,
                              style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: AppSpacing.xxs),
                            Text(
                              email,
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: AppSpacing.xl),
            
            // My Shopping Section
            _buildSectionHeader(l10n.myShopping),
            const SizedBox(height: AppSpacing.xs),
            _buildMenuItem(
              icon: Icons.receipt_long_outlined,
              title: l10n.myOrders,
              onTap: () => context.push('/order-history'),
            ),
            _buildMenuItem(
              icon: Icons.favorite_border_outlined,
              title: l10n.wishlistTitle,
              onTap: () => context.push('/wishlist'),
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                final count = state.items.length;
                return _buildMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  title: l10n.myCart,
                  onTap: () => context.push('/cart'),
                  trailing: count > 0
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: AppSpacing.xxs),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: AppRadius.smallBorderRadius,
                          ),
                          child: Text(
                            '$count',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.surface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                );
              },
            ),
            
            const SizedBox(height: AppSpacing.xl),

            // Preferences Section
            _buildSectionHeader(l10n.preferences),
            const SizedBox(height: AppSpacing.xs),
            _buildMenuItem(
              icon: Icons.style_outlined,
              title: l10n.stylePreferences,
              onTap: () => context.push('/style-preference'),
            ),
            _buildMenuItem(
              icon: Icons.language_outlined,
              title: l10n.language,
              onTap: () => _showLanguageBottomSheet(context, l10n),
            ),
            
            const SizedBox(height: AppSpacing.xl),

            // App Section
            _buildSectionHeader(l10n.appSection),
            const SizedBox(height: AppSpacing.xs),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: l10n.aboutApp,
              onTap: () => _showAboutDialog(context, l10n),
            ),
            _buildMenuItem(
              icon: Icons.logout_outlined,
              title: l10n.logout,
              onTap: () => _showLogoutDialog(context, l10n),
              textColor: AppColors.sale,
              iconColor: AppColors.sale,
            ),

            const SizedBox(height: AppSpacing.xxl),
            
            Text(
              l10n.appVersion,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(color: AppColors.disabledText),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.caption.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.secondaryText,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.largeBorderRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? AppColors.primaryText),
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            color: textColor ?? AppColors.primaryText,
          ),
        ),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 14.0, color: AppColors.secondaryText),
        onTap: onTap,
      ),
    );
  }
}
