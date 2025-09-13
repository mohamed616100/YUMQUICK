import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:yumquick/features/Auth/data/models/login_response_model.dart';
import 'package:yumquick/features/Auth/views/widgets/Custom_Auth_image.dart';
import 'package:yumquick/features/Home/cubit/user_cubit/user_cubit.dart';
import 'package:yumquick/features/profile/Cubit/Update_cubit/Update_cubit.dart';
import 'package:yumquick/features/profile/Cubit/Update_cubit/Update_state.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.user});

  final UserModel user;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolors.primarycolor,
        body: BaseBody(
          height: 129.h,
          childcontiner: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: CustomAppbar(
              title: 'My Profile',
              icon: AppIcons.BackiconArrow,
              onTap: () {
                MyNavigator.goBack(context);
              },
            ),
          ),
          body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileSuccess) {
                final userdata = UpdateProfileCubit.get(context);

                final updatedUser = widget.user.copyWith(
                  name: userdata.nameController.text.isNotEmpty
                      ? userdata.nameController.text
                      : widget.user.name,
                  phone: userdata.phoneController.text.isNotEmpty
                      ? userdata.phoneController.text
                      : widget.user.phone,
                  imagePath: userdata.image?.path ?? widget.user.imagePath,
                );
                context.read<UserCubit>().updateUser(updatedUser);
                MyNavigator.goBack(context);
                AppPopUp.showSnackBar(state.message, context);
              } else if (state is UpdateProfileFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is UpdateProfileLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Dialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              } else {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            builder: (context, state) {
              final userdata =  UpdateProfileCubit.get(context);
              return Form(
                key: userdata.formKey,
                child: Column(
                  children: [
                    SizedBox(height: 34.h),
                    ImageManagerView(
                      onImagePicked: (image) {
                        userdata.image = image;
                      },
                      imageBuilder: (image) {
                        return CustomAuthImage(
                          image: FileImage(
                            File(image.path)),);
                      },
                      defaultBuilder: CustomAuthImage(
                        image: NetworkImage(widget.user.imagePath ?? ''),
                      ),
                    ),
                    SizedBox(height: 34.h),
                    CustomTextformfaild(
                        obscureText: false,
                        controller: userdata.nameController,
                        validator:  AppValidator.requiredValidator,
                        keyboardType: TextInputType.name,
                        hintText: widget.user.name!,
                        labeltext: 'Full name'
                    ),
                    SizedBox(height: 40.h),
                    CustomTextformfaild(
                        controller: userdata.phoneController,
                        validator:  AppValidator.phoneValidator,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        hintText: widget.user.phone!,
                        labeltext: 'Phone Number'
                    ),
                    SizedBox(height: 40.h),
                    CustomBottom(width: 142.w,
                        height: 36.h,
                        backgroundColor: Appcolors.secondarycolor,
                        reduis: 30.r,
                        text: 'Update Profile ',
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        letterspacing: 0,
                        lineheight: 0,
                      onTap: state is UpdateProfileLoading
                          ? null
                          : () {
                        userdata.updateProfile();
                      },

                    )
                  ],
                ),
              );
            },
          ),
        ),
    );
  }
}
