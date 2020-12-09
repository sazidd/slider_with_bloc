part of 'slider_bloc.dart';

abstract class SliderState extends Equatable {
  const SliderState();

  @override
  List<Object> get props => [];
}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderLoaded extends SliderState {
  final List<Payload> payload;

  SliderLoaded({this.payload});

  @override
  List<Object> get props => [payload];
}

class SliderFailure extends SliderState {
  final String errorMessage;
  SliderFailure({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
