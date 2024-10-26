
// Base class for all events related to GolfBloc
import 'package:equatable/equatable.dart';

abstract class GolfEvent extends Equatable {
  const GolfEvent();

  @override
  List<Object?> get props => [];
}

// Event to load golf data
class LoadGolfData extends GolfEvent {
  const LoadGolfData();

  @override
  List<Object?> get props => [];
}
