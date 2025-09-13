import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yumquick/features/profile/Cubit/Update_cubit/Update_state.dart' show UpdateProfileFailure, UpdateProfileInitial, UpdateProfileLoading, UpdateProfileState, UpdateProfileSuccess;
import 'package:yumquick/features/profile/data/models/Update_response.dart';
import 'package:yumquick/features/profile/data/repos/Update_Profile_repo/Update_Profile_repo.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState>{
  UpdateProfileCubit():super(UpdateProfileInitial());
  static UpdateProfileCubit get(context)=>BlocProvider.of(context);
  XFile? image;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  void updateProfile()async{
    if(!formKey.currentState!.validate()) return;
    emit(UpdateProfileLoading());
    var updateResponse = await UpdateProfileRepo().updateProfile(
      name: nameController.text,
      phone: phoneController.text,
      image: image,
    );
    updateResponse.fold(
          (String error)=> emit(UpdateProfileFailure(error)),
          (UpdateResponse response)=> emit(UpdateProfileSuccess(response.message!)),
    );
  }


}