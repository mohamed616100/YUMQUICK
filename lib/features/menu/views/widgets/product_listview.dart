import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';
import 'package:yumquick/features/item/views/item_view.dart';
import 'package:yumquick/features/menu/cubit_Ctagory/pro_cubit/cubit.dart';
import 'package:yumquick/features/menu/cubit_Ctagory/pro_cubit/states.dart';
import 'package:yumquick/features/menu/views/widgets/prouduct_item.dart';


class ProductListview extends StatelessWidget {
  const ProductListview({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return SliverList.builder(itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                MyNavigator.goTo(context, ItemView(
                  data: state.products[index] as Products,
                ));
              },
              child: ProuductItem(
                products: state.products[index],
              ),
            );
          }, itemCount: state.products.length);
        }else{
          return SliverToBoxAdapter(child: Container());
        }
        },
    );
        } }

