import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginDemo(String email, String password) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 800));

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      emit(const AuthError('invalid_email'));
      return;
    }

    if (password.length < 6) {
      emit(const AuthError('invalid_password'));
      return;
    }

    emit(AuthAuthenticated(email: email));
  }

  Future<void> loginAsGuest() async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(const AuthAuthenticated(email: 'demo@seoulstyle.ai', isGuest: true));
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(AuthUnauthenticated());
  }
}
