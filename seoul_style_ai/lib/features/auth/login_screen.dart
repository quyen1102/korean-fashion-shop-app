import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_primary_button.dart';
import '../../core/widgets/app_secondary_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../l10n/app_localizations.dart';
import '../profile/cubit/preference_cubit.dart';
import '../profile/cubit/preference_state.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(AppLocalizations l10n) {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        _emailError = l10n.emailError;
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        _passwordError = l10n.passwordError;
      });
      return;
    }

    context.read<AuthCubit>().loginDemo(email, password);
  }

  void _handleAuthSuccess() {
    final prefState = context.read<PreferenceCubit>().state;
    if (prefState is PreferenceLoaded && prefState.preference.favoriteStyles.isNotEmpty) {
      context.go('/home');
    } else {
      context.go('/style-preference');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            _handleAuthSuccess();
          } else if (state is AuthError) {
            final errorMsg = state.message == 'invalid_email' 
                ? l10n.emailError 
                : (state.message == 'invalid_password' ? l10n.passwordError : state.message);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMsg)),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    l10n.welcomeBack,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headlineLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.loginSubtitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl * 1.5),
                  AppTextField(
                    controller: _emailController,
                    labelText: l10n.email,
                    hintText: 'yourname@example.com',
                    errorText: _emailError,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _passwordController,
                    labelText: l10n.password,
                    isPassword: true,
                    errorText: _passwordError,
                  ),
                  const SizedBox(height: AppSpacing.lg * 1.5),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return AppPrimaryButton(
                        text: l10n.login,
                        isLoading: state is AuthLoading,
                        onPressed: () => _onLoginPressed(l10n),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        child: Text(
                          l10n.or,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.disabledText,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppSecondaryButton(
                    text: l10n.continueAsGuest,
                    onPressed: () {
                      context.read<AuthCubit>().loginAsGuest();
                    },
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        icon: Icons.g_mobiledata,
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.comingSoon)),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      _buildSocialButton(
                        icon: Icons.chat_bubble_outline,
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.comingSoon)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 24.0, color: AppColors.primaryText),
      ),
    );
  }
}
