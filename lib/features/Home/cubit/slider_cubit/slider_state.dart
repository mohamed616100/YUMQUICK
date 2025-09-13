

import 'package:yumquick/features/Home/data/models/slider_response_model.dart';

abstract class SliderState{}

class SliderInitial extends SliderState{}

class SliderLoading extends SliderState{}

class SliderError extends SliderState{
  final String error;
  SliderError({required this.error});
}

class SliderSuccess extends SliderState{
  final List<Sliders> data;
  SliderSuccess({required this.data});
}
