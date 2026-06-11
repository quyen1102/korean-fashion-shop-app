import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/cubit/language_cubit.dart';
import 'data/repositories/local/local_order_repository.dart';
import 'data/repositories/local/local_preference_repository.dart';
import 'data/repositories/mock/mock_product_repository.dart';
import 'data/repositories/order_repository.dart';
import 'data/repositories/preference_repository.dart';
import 'data/repositories/product_repository.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/checkout/cubit/checkout_cubit.dart';
import 'features/home/cubit/product_cubit.dart';
import 'features/profile/cubit/preference_cubit.dart';
import 'features/recommendation/cubit/recommendation_cubit.dart';
import 'features/wishlist/cubit/wishlist_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(
          create: (context) => MockProductRepository(),
        ),
        RepositoryProvider<PreferenceRepository>(
          create: (context) => LocalPreferenceRepository(sharedPreferences),
        ),
        RepositoryProvider<OrderRepository>(
          create: (context) => LocalOrderRepository(sharedPreferences),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LanguageCubit>(
            create: (context) => LanguageCubit(sharedPreferences),
          ),
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<PreferenceCubit>(
            create: (context) => PreferenceCubit(
              RepositoryProvider.of<PreferenceRepository>(context),
            )..loadPreference(),
          ),
          BlocProvider<ProductCubit>(
            create: (context) => ProductCubit(
              RepositoryProvider.of<ProductRepository>(context),
            )..loadProducts(),
          ),
          BlocProvider<CartCubit>(
            create: (context) => CartCubit(),
          ),
          BlocProvider<WishlistCubit>(
            create: (context) => WishlistCubit(
              RepositoryProvider.of<PreferenceRepository>(context),
            )..loadWishlist(),
          ),
          BlocProvider<RecommendationCubit>(
            create: (context) => RecommendationCubit(),
          ),
          BlocProvider<CheckoutCubit>(
            create: (context) => CheckoutCubit(
              RepositoryProvider.of<OrderRepository>(context),
            ),
          ),
        ],
        child: const SeoulStyleApp(),
      ),
    ),
  );
}
