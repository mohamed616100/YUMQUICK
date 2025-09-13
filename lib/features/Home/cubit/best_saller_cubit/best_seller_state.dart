

import 'package:yumquick/features/Home/data/models/best_seller_model.dart';

abstract class BestSellerState{}

class BestSellerInitial extends BestSellerState{}

class BestSellerLoading extends BestSellerState{}

class BestSellerError extends BestSellerState{
  final String error;
  BestSellerError({required this.error});
}

class BestSellerSuccess extends BestSellerState{
  final List<BestSellerProducts> data;
  BestSellerSuccess({required this.data});
}