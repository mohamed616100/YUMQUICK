import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/helper/app_pop_up.dart';
import 'package:yumquick/core/helper/app_validators.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/core/widgets/Custom_bottom.dart';
import 'package:yumquick/core/widgets/Custom_textformfaild.dart';
import 'package:yumquick/features/Auth/cubit/login_cubit/login_cubit.dart';
import 'package:yumquick/features/Auth/cubit/login_cubit/login_state.dart';
import 'package:yumquick/features/Home/cubit/user_cubit/user_cubit.dart';
import 'package:yumquick/features/Home/views/main_home_view.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Appcolors.primarycolor,
        body: BaseBody(
          height: 162.h,
          childcontiner: CustomAppbar(
            title: "Hello!",
            icon: AppIcons.BackiconArrow,
            onTap: () => MyNavigator.goBack(context),
          ),
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                context.read<UserCubit>().controlUser(state.userModel);
                MyNavigator.goTo(
                    context, MainHomeView(datauser: state.userModel),
                    type: NavigatorType.pushAndRemoveUntil);
              }
              else if (state is LoginError) {
                AppPopUp.showSnackBar(state.error, context);
              }
            },
            builder: (context, state) {
              LoginCubit cubit = LoginCubit.get(context);
              return Form(
                key: cubit.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 34.h,),
                      Padding(
                        padding: AppPaddings.Appbarhorizontalonlyleft,
                        child: Text('Welcome', style: GoogleFonts.leagueSpartan(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.textcolorblack,
                        ),),
                      ),
                      SizedBox(height: 52.h,),
                      CustomTextformfaild(
                        labeltext: 'Email',
                        validator: AppValidator.emailValidator,
                        controller: cubit.emailController,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter email here',
                        maxLines: 1,
                      ),
                      SizedBox(height: 22.h,),
                      CustomTextformfaild(
                        labeltext: 'Password',
                        controller: cubit.passwordController,
                        obscureText: cubit.isPassword,
                        validator: AppValidator.passwordValidator,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Enter password here',
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          icon: Icon(cubit.isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                              color: Appcolors.secondarycolor, size: 24.sp),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 60.h,),
                      state is LoginLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Center(
                        child: CustomBottom(
                          onTap: () {
                            cubit.onlogin(
                                context
                            );
                          },
                          width: 207.w,
                          height: 45.h,
                          backgroundColor: Appcolors.secondarycolor,
                          reduis: 30.r,
                          text: 'Log In',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          letterspacing: 0,
                          lineheight: 1,
                        ),
                      )

                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
