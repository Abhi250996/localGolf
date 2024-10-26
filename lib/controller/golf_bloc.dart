
import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../golf_data_model.dart';
import 'golf_event.dart';
import 'golf_state.dart';

class GolfBloc extends Bloc<GolfEvent, GolfState> {
  GolfBloc() : super(GolfInitial()) {
    // Register event handlers using `on` method
    on<LoadGolfData>(_onLoadGolfData);
  }

  Future<void> _onLoadGolfData(LoadGolfData event, Emitter<GolfState> emit) async {
    emit(GolfLoading());
    try {
      // Load JSON data from assets
      final String response = await rootBundle.loadString('assets/sample.json');
      final Map<String, dynamic> jsonData = jsonDecode(response);

      // Parse the player details
      List<PlayerDetail> playerDetails = (jsonData['entity']['PlayerDetail'] as List)
          .map((player) => PlayerDetail.fromJson(player))
          .toList();

      // Parse the score card details
      List<ScoreCardDetail> scoreDetails = (jsonData['entity']['scoreCardDetail'] as List)
          .map((score) => ScoreCardDetail.fromJson(score))
          .toList();

      // Parse the slope rating and SSS details
      List<SlopeRatingAndSss> slopeAndSSS = (jsonData['entity']['slopeRatingAndSSS'] as List)
          .map((sss) => SlopeRatingAndSss.fromJson(sss))
          .toList();

      // Emit the loaded state with the parsed data
      emit(GolfLoaded(
        playerDetails: playerDetails,
        scoreDetails: scoreDetails,
        slopeAndSSS: slopeAndSSS,
      ));
    } catch (error) {
      // Emit error state if loading fails
      emit(GolfError('Error loading golf data: $error'));
    }
  }
}
