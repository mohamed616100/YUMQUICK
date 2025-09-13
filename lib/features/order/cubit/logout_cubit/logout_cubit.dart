import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/features/order/cubit/logout_cubit/logout_state.dart';
import 'package:restaurant/features/order/data/model_response_logout.dart';
import 'package:restaurant/features/order/data/repo/logout_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit():super(LogoutInitial());
  final repository = LogoutRepository();
  static LogoutCubit get(context) => BlocProvider.of(context);
 onlogout() async {
    emit(LogoutLoading());
    final Either<String, responslogout> result = await repository.logout();
    result.fold(
          (error) => emit(LogoutError(error)),
          (response) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('access_token');
        emit(LogoutSuccess(response.message??'Logout successful'));
      },    );
  }


}
