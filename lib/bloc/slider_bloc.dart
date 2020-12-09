import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:johir_bhai_work/main.dart';
import 'package:johir_bhai_work/repository.dart';

part 'slider_event.dart';
part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final Repository repository;
  SliderBloc({this.repository}) : super(SliderInitial());

  @override
  Stream<SliderState> mapEventToState(
    SliderEvent event,
  ) async* {
    final currentState = state;
    if (event is FetchSlider) {
      if (currentState is SliderInitial) {
        final payload = await repository.getSponsorSlide();
        if (payload != null) {
          yield SliderLoaded(payload: payload);
        } else {
          yield SliderFailure(errorMessage: 'no more data');
        }
      }
    }
  }
}
