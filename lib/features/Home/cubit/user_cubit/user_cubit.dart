import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/Auth/data/models/login_response_model.dart';
import 'package:yumquick/features/Home/cubit/user_cubit/user_state.dart';
import 'package:yumquick/features/Home/data/repos/home_repo.dart';


class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  void controlUser(UserModel? user) {
    if (user == null) {
      getUser();
    } else {
      emit(UserSuccess(user: user));
    }
  }
  Future<void> getUser() async {
    HomeRepo homeRepo = HomeRepo();
    emit(UserLoading());
    var response = await homeRepo.getUser();
    response.fold(
          (error) => emit(UserError(error: error)),
          (user) => emit(UserSuccess(user: user)),
    );
  }
  void updateUser(UserModel updatedUser) {
    emit(UserSuccess(user:updatedUser));
  }
}

