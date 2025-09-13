import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/Settings/manger/state.dart';
class togellcubit extends Cubit<togellstate>{
  togellcubit():super(intitialstate());
  static togellcubit get(context)=>BlocProvider.of(context);
  String selectedLang = "EN";
  void changeLanguage(String lang)  {
    selectedLang = lang;
    emit(changetostate());
  }
}