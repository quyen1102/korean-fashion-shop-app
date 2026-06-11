import 'package:equatable/equatable.dart';

class WishlistState extends Equatable {
  final Set<String> productIds;

  const WishlistState(this.productIds);

  @override
  List<Object?> get props => [productIds];
}
