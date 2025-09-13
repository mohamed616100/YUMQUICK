import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';
import 'package:yumquick/features/menu/cubit_Ctagory/pro_cubit/states.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  void loadProducts(List<Products> products) {
    emit(ProductLoaded(products));
  }
}
