part of 'slider_bloc.dart';

abstract class SliderEvent extends Equatable {
  const SliderEvent();

  @override
  List<Object> get props => [];
}

class FetchSlider extends SliderEvent {}
