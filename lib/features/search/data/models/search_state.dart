
import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';

abstract class SearchState{}

class SearchInitial extends  SearchState{}

class SearchLoading extends SearchState{}

class SearchError extends SearchState{
  final String error;
  SearchError({required this.error});
}

class SearchSuccess extends SearchState{
  final List<Products> data;
  SearchSuccess({required this.data});
}
