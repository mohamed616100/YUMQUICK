import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/Home/cubit/best_saller_cubit/best_seller_cubit.dart';
import 'package:yumquick/features/Home/cubit/best_saller_cubit/best_seller_state.dart';
import 'package:yumquick/features/best_seller_alll/views/widgets/best_seller_grad.dart';

class BestSellerGradView extends StatelessWidget {
  const BestSellerGradView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BestSellerCubit()..getBestSeller(),
      child: BlocBuilder<BestSellerCubit, BestSellerState>(
        builder: (context, state) {
          if (state is BestSellerLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BestSellerError) {
            return Center(child: Text(state.error));
          } else if (state is BestSellerSuccess) {
            return Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return BestSellerGrad(
                  bestSellerProducts: state.data[index],
                );
              }, itemCount: state.data.length,),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
