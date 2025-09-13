

import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';

abstract class TopRatedState{}

class TopRatedInitial extends  TopRatedState{}

class TopRatedLoading extends TopRatedState{}

class TopRatedError extends TopRatedState{
  final String error;
  TopRatedError({required this.error});
}

class TopRatedSuccess extends TopRatedState{
  final List<Products> data;
  TopRatedSuccess({required this.data});
}
