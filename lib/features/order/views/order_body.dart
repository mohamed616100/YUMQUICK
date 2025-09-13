import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/features/Auth/data/models/login_response_model.dart';
import 'package:yumquick/features/Home/cubit/user_cubit/user_cubit.dart';
import 'package:yumquick/features/Home/cubit/user_cubit/user_state.dart';
import 'package:yumquick/features/MyOrders/view/My_Order_View.dart';
import 'package:yumquick/features/Settings/views/settings_view.dart';
import 'package:yumquick/features/fav/views/fav_view.dart';
import 'package:yumquick/features/order/views/widgets/Custom_appbar_oder.dart';
import 'package:yumquick/features/order/views/widgets/logout_widget.dart';
import 'package:yumquick/features/order/views/widgets/tap_widgets.dart';
import 'package:yumquick/features/profile/views/profile_view.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({super.key, this.datauser});

  final UserModel? datauser;

  @override
  Widget build(BuildContext context) {
    return BaseBody(
        height: 129.h,
        childcontiner: CustomAppbarOder(),
        body: Padding(
          padding: AppPaddings.Appbarhorizontalsymatric,
          child: Column(
            children: [
              SizedBox(height: 38.h,),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserSuccess) {
                    return TapWidgets(
                      icon: AppIcons.UserIcon,
                      text: 'My Profile',
                      OnTap: () {
                        MyNavigator.goTo(
                          context,
                          ProfileView(user: state.user),
                          type: NavigatorType.push,
                        );
                      },
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              SizedBox(height: 40.h),
              TapWidgets(
                icon: AppIcons.ordericon,
                text: 'My Orders',
                OnTap: (){
                  MyNavigator.goTo(context, MyOrderView(),
                      type: NavigatorType.push);
                },
              ),
              SizedBox(height: 40.h),
              TapWidgets(
                icon: AppIcons.hearticon,
                text: 'My Favorites',
                OnTap: (){
                  MyNavigator.goTo(context, FavView(),
                      type: NavigatorType.push);
                },
              ),
              SizedBox(height: 40.h),
              TapWidgets(
                icon: AppIcons.Sittingicon,
                text: 'Settings',
                OnTap: (){
                  MyNavigator.goTo(context,
                      SettingsView(),type: NavigatorType.push);
                },
              ),
              SizedBox(height: 30.h),
              Divider(
                height: 1,
                thickness: 1,
                color: Appcolors.secondarycolor,
              ),
              SizedBox(height: 40.h,),
              LogoutWidget()
            ],
          ),
        ),
    );
  }
}
