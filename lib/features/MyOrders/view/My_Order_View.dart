// features/MyOrders/view/my_order_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/features/MyOrders/manager/Order_cubit.dart';
import 'package:yumquick/features/MyOrders/manager/Order_state.dart';
import 'package:yumquick/features/MyOrders/view/widgets/Empty%20Orders%20Widget.dart';
import 'package:yumquick/features/MyOrders/view/widgets/OrderCardActive.dart';
import 'package:yumquick/features/MyOrders/view/widgets/OrderCardCancelled.dart';
import 'package:yumquick/features/MyOrders/view/widgets/OrderCardCompleted.dart';

class MyOrderView extends StatelessWidget {
  const MyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderCubit>(
      create: (context) => OrderCubit()..getOrders(),
      child: Scaffold(
        backgroundColor: Appcolors.primarycolor,
        body: BaseBody(
          height: 129.h,
          childcontiner: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: CustomAppbar(
              title: 'My Orders',
              icon: AppIcons.BackiconArrow,
              onTap: () => MyNavigator.goBack(context),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  // 🔹 Tabs
                  TabBar(
                    indicatorColor: Colors.red,
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: "Active"),
                      Tab(text: "Completed"),
                      Tab(text: "Cancelled"),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  Expanded(
                    child: BlocBuilder<OrderCubit,OrderState>(
                      builder: (context, state) {
                        if (state is OrderLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is OrderError) {
                          return Center(child: Text(state.message));
                        } else if (state is OrderSuccess) {
                          final orders = state.order.orders;

                          return TabBarView(
                            children: [
                              // Active
                              // Active
                              (orders!.active ?? []).isEmpty
                                  ? const EmptyOrdersWidget(text: "No active orders yet.")
                                  : ListView.builder(
                                itemCount: orders.active!.length,
                                itemBuilder: (_, i) {
                                  final order = orders.active![i];
                                  final firstItem = order.items!.isNotEmpty ? order.items!.first : null;

                                  if (firstItem == null) {
                                    return const SizedBox();
                                  }

                                  return OrderCardActive(

                                    order: order,
                                    items: firstItem,
                                  );
                                },
                              ),


                              // Completed
                              (orders.completed ?? []).isEmpty
                                  ? const EmptyOrdersWidget(text: " completed orders yet.")
                                  : ListView.builder(
                                itemCount: orders.completed!.length,
                                itemBuilder: (_, i) => OrderCardCompleted(
                                    items: orders.completed![i].items!.first,
                                    order: orders.completed![i]),
                              ),

                              // Cancelled
                              (orders.canceled ?? []).isEmpty
                                  ? const EmptyOrdersWidget(text: "No cancelled orders yet.")
                                  : ListView.builder(
                                itemCount: orders.canceled!.length,
                                itemBuilder: (_, i) => OrderCardCancelled(
                                    items: orders.canceled![i].items!.first,
                                    order: orders.canceled![i]),
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
