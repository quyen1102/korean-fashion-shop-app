import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_primary_button.dart';
import '../../core/widgets/app_secondary_button.dart';
import '../../l10n/app_localizations.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String fakeOrderId = 'SS2026${DateTime.now().millisecond}';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Center(
                child: Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 96.0,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.paymentSuccessful,
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineLarge.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.orderId(fakeOrderId),
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.secondaryText),
              ),
              const SizedBox(height: 4.0),
              Text(
                l10n.estimatedDelivery,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryText),
              ),
              const Spacer(),
              AppPrimaryButton(
                text: l10n.viewOrderDetails,
                onPressed: () {
                  context.go('/order-history');
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppSecondaryButton(
                text: l10n.backToHome,
                onPressed: () {
                  context.go('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
