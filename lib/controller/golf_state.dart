// golf_state.dart
import '../golf_data_model.dart';

abstract class GolfState {}

class GolfInitial extends GolfState {}

class GolfLoading extends GolfState {}

class GolfLoaded extends GolfState {
  final List<PlayerDetail> playerDetails;
  final List<ScoreCardDetail> scoreDetails;
  final List<SlopeRatingAndSss> slopeAndSSS;

  GolfLoaded({
    required this.playerDetails,
    required this.scoreDetails,
    required this.slopeAndSSS,
  });
}

class GolfError extends GolfState {
  final String error;

  GolfError(this.error);
}
