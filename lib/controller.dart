// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart';
//
// import 'golf_data_model.dart';
//
//
// class GolfController extends GetxController {
//   // Observable lists for player details and score details
//   RxList<PlayerDetail> playerDetails = <PlayerDetail>[].obs;
//   RxList<ScoreCardDetail> scoreDetails = <ScoreCardDetail>[].obs;
//   RxList<SlopeRatingAndSss> sloap_sss = <SlopeRatingAndSss>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadGolfData(); // Load data when controller is initialized
//   }
//
//   // Method to load local JSON
//   Future<void> loadGolfData() async {
//     try {
//       // Load JSON data from assets
//       final String response = await rootBundle.loadString('assets/sample.json');
//       final Map<String, dynamic> jsonData = jsonDecode(response);
//
//       // Parse the player details
//       playerDetails.value = (jsonData['entity']['PlayerDetail'] as List)
//           .map((player) => PlayerDetail.fromJson(player))
//           .toList();
//
//       // Parse the score card details
//       scoreDetails.value = (jsonData['entity']['scoreCardDetail'] as List)
//           .map((score) => ScoreCardDetail.fromJson(score))
//           .toList();
//       sloap_sss.value = (jsonData['entity']['slopeRatingAndSSS'] as List)
//           .map((sss) => SlopeRatingAndSss .fromJson(sss))
//           .toList();
//
//       // Optionally, you can print the data to verify it is loaded correctly
//       print('Player Details: ${playerDetails.toString()}');
//       print('Score Details: ${scoreDetails.toString()}');
//     } catch (error) {
//       // Handle errors, such as JSON parsing errors
//       print('Error loading golf data: $error');
//     }
//   }
// }
