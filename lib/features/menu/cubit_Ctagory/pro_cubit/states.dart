


import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';

abstract class ProductState{}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Products> products;
  ProductLoaded(this.products);
}
