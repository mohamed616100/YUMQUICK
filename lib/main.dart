import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yumquick/core/widgets/image_manger/cubit/image_manager_cubit.dart';
import 'package:yumquick/features/Home/cubit/best_saller_cubit/best_seller_cubit.dart';
import 'package:yumquick/features/Home/cubit/slider_cubit/slider_cubit.dart';
import 'package:yumquick/features/Home/cubit/top_rated_cubit/top_rated_cubit.dart';
import 'package:yumquick/features/Home/cubit/user_cubit/user_cubit.dart';
import 'package:yumquick/features/MyOrders/manager/cubit_canceld/cubit_canceld.dart';
import 'package:yumquick/features/onbordingAndSplach/views/Launch_First_View.dart';
import 'package:yumquick/features/profile/Cubit/Update_cubit/Update_cubit.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sharedPref = await SharedPreferences.getInstance();
  var accessToken = sharedPref.getString('access_token');
  runApp(MyApp(screen:LaunchFirstView(AccessToken: accessToken)));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.screen});
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return MultiBlocProvider(
  providers: [
    BlocProvider(
  create: (context) => ImageManagerCubit(),
),
    BlocProvider(
      create: (context) => UpdateProfileCubit(),
    ),
    BlocProvider(
      create: (context) =>
      UserCubit()
        ..getUser(),
    ),
    BlocProvider(create:
        (context) => CanceldCubit() ,
    ),
    BlocProvider(
      create: (context) => BestSellerCubit()..getBestSeller(),
    ),
    BlocProvider(
      create: (context) => SeliderCubit()..getSlider(),
    ),
    BlocProvider(
      create: (context) => TopRatedCubit()..getToRated(),
    ),
  ],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: screen,
        ),
);
      },
    );
  }
}
