
import 'package:yumquick/features/menu/data/models/CatgoryResonseModel.dart';

abstract class CatgoryState{}

class CatgoryInitial extends CatgoryState{}

class CatgoryLoading extends CatgoryState{}

class CatgoryError extends CatgoryState{
  final String error;
  CatgoryError({required this.error});
}

class CatgorySuccess extends CatgoryState{
  final List<Categories> data;
  CatgorySuccess({required this.data});
}