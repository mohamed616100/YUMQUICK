import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yumquick/features/Auth/cubit/signup_cubit/signup_states.dart';
import 'package:yumquick/features/Auth/data/repos/Auth_repo.dart';


class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(RegisterInitial());
  bool isPassword = true;
  bool isConfirmPassword = true;
  XFile? image;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  static RegisterCubit get(context) => BlocProvider.of(context);
  void changePasswordVisibility(){
    isPassword = !isPassword;
    emit(RegisterChangePasswordVisibility());
  }
  void changeConfirmPasswordVisibility(){
    isConfirmPassword = !isConfirmPassword;
    emit(RegisterChangeConfirmPasswordVisibility());
  }
  onRegister()async{
    if(!formKey.currentState!.validate()) return;
    emit(RegisterLoading());
    AuthRepo repo = AuthRepo();
    var registerResponse = await repo.register(
        phone: phoneController.text,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        image: image
    );
    registerResponse.fold(
            (String error)=> emit(RegisterError(error: error)),
            (String message)=> emit(RegisterSuccess(message: message))
    );

  }


}