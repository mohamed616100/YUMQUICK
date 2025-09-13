import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/helper/app_pop_up.dart';
import 'package:yumquick/core/helper/app_validators.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/core/widgets/Custom_bottom.dart';
import 'package:yumquick/core/widgets/Custom_textformfaild.dart';
import 'package:yumquick/core/widgets/image_manger/image_manger_view.dart';
import 'package:yumquick/features/Auth/cubit/signup_cubit/signup_cubit.dart';
import 'package:yumquick/features/Auth/cubit/signup_cubit/signup_states.dart';
import 'package:yumquick/features/Auth/views/Login_view.dart';
import 'package:yumquick/features/Auth/views/widgets/Custom_Auth_image.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Appcolors.primarycolor,
            body: BaseBody(
              height: 162.h,
              childcontiner: CustomAppbar(
                addimage:ImageManagerView(
                  onImagePicked: (image)=> RegisterCubit.get(context).image = image,
                  imageBuilder:(image){
                    return CustomAuthImage(image: FileImage(File(image.path)),);
                  },
                  defaultBuilder: CustomAuthImage(),
                ),
                title: "New Account",
                icon: AppIcons.BackiconArrow,
                onTap: () => MyNavigator.goBack(context),
              ),
              body: BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    MyNavigator.goTo(context, LoginView(),type: NavigatorType.push);
                    AppPopUp.showSnackBar(state.message, context);
                  } else if (state is RegisterError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  RegisterCubit cubit = RegisterCubit.get(context);
                  return Form(
                    key: cubit.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 34.h),
                          CustomTextformfaild(
                            validator: AppValidator.requiredValidator,
                            labeltext: 'Full name',
                            obscureText: false,
                            controller: cubit.nameController,
                            keyboardType: TextInputType.name,
                            hintText: 'Enter Full name here',
                            maxLines: 1,
                          ),
                          SizedBox(height: 17.h),
                          CustomTextformfaild(
                            labeltext: 'Email',
                            validator: AppValidator.emailValidator,
                            obscureText: false,
                            controller: cubit.emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Enter email here',
                            maxLines: 1,
                          ),
                          SizedBox(height: 17.h),
                          CustomTextformfaild(
                            labeltext: 'Mobile Number',
                            validator: AppValidator.phoneValidator,
                            controller: cubit.phoneController,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            hintText: 'Enter phone number here',
                            maxLines: 1,
                          ),
                          SizedBox(height: 17.h),
                          CustomTextformfaild(
                            labeltext: 'Password',
                            validator: AppValidator.passwordValidator,
                            controller: cubit.passwordController,
                            obscureText: cubit.isPassword,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: 'Enter password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              icon: Icon(
                                cubit.isPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Appcolors.secondarycolor,
                                size: 24.sp,
                              ),
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(height: 17.h),
                          CustomTextformfaild(
                            validator:
                                (value) => AppValidator.confirmPasswordValidator(
                                  value,
                                  cubit.passwordController.text,
                                ),
                            controller: cubit.confirmPasswordController,
                            labeltext: 'Confirm Password',
                            obscureText: cubit.isConfirmPassword,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: 'Enter Confirm password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeConfirmPasswordVisibility();
                              },
                              icon: Icon(
                                cubit.isConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Appcolors.secondarycolor,
                                size: 24.sp,
                              ),
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(height: 41.h),
                          state is RegisterLoading?
                          const Center(child: CircularProgressIndicator())
                          : Center(
                            child: CustomBottom(
                              onTap: () {
                                cubit.onRegister();
                              },
                              width: 207.w,
                              height: 45.h,
                              backgroundColor: Appcolors.secondarycolor,
                              reduis: 30.r,
                              text: 'Sign Up',
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              letterspacing: 0,
                              lineheight: 1,
                            ),
                          ),
                      
                          SizedBox(height: 32.h),
                          Center(
                            child: Text(
                              'By continuing, you agree to ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                color: Appcolors.textcolorblack,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Terms of Use and Privacy Policy.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                color: Appcolors.secondarycolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      ),
    );
  }
}
