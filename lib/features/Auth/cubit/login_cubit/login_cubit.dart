
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/Auth/cubit/login_cubit/login_state.dart';
import 'package:yumquick/features/Auth/data/repos/Auth_repo.dart';
import 'package:yumquick/features/Home/cubit/user_cubit/user_cubit.dart';



class LoginCubit extends Cubit<LoginState>{
  bool isPassword=true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  static LoginCubit get(context)=>BlocProvider.of(context);
  LoginCubit():super(InitialState());

  void changePasswordVisibility(){
    isPassword=!isPassword;
    emit(ChangePasswordVisibilityState());
  }
  final AuthRepo repo = AuthRepo();


  void onlogin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    emit(LoginLoading());

    var loginResponse = await repo.login(
      email: emailController.text,
      password: passwordController.text,
    );

    loginResponse.fold(
          (String error) => emit(LoginError(error: error)),
          (loginResponseModel) async {
        context.read<UserCubit>().controlUser(loginResponseModel.user);
        emit(LoginSuccess(userModel: loginResponseModel.user!));
      },
    );
  }



}