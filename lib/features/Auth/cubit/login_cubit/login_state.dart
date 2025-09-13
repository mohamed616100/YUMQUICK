


import 'package:yumquick/features/Auth/data/models/login_response_model.dart';

abstract class LoginState {}
class InitialState extends LoginState{}
class ChangePasswordVisibilityState extends LoginState{}
class LoginLoading  extends LoginState{}
class LoginSuccess  extends LoginState
{
  UserModel userModel;
  LoginSuccess({required this.userModel});
}
class LoginError extends LoginState {
  String error;

  LoginError({required this.error});
}