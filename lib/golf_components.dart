import 'package:flutter/material.dart';
import 'golf_data_model.dart'; // Adjust import based on your project structure

class GolfTableComponents {
  List<PlayerDetail>? playerDetails = [];
  List<ScoreCardDetail>? scoreDetails =[];
  List<SlopeRatingAndSss>? sloapSss =[];
  GolfTableComponents({this.scoreDetails,this.playerDetails,this.sloapSss});

  Widget buildGolfTable(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount:  playerDetails!.length,
              itemBuilder: (context, index) {
                var player = playerDetails![index];
                String initials = String.fromCharCode(65 + index);
                return _buildPlayerHeader(
                    player.memberName!, player.handycaptype!, initials, context);
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFixedColumn(context),
                _buildDynamicTable(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerHeader(
      String name, String handycap, String initials, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(),
        color: const Color(0xffDAF0D9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            initials,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            handycap,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeaderRow(['HOLE', 'PAR', 'INDEX', 'TIME\nTAKEN'], 0, context),
        for (var i = 1; i <= 9; i++) _buildFixedDataRow(i, i, context),
        _buildFixedInRow(true, context),
        for (var i = 10; i <= 18; i++) _buildFixedDataRow(i, i, context),
        _buildFixedInRow(false, context),
        _buildTotalFixedInRow(false, context),
        _buildSloapFixedInRow(false, context),
        _buildSSSFixedInRow(false, context),
      ],
    );
  }

  Widget _buildFixedDataRow(int holeNo, int rowIndex, BuildContext context) {
    var scoreDataList = scoreDetails!
        .where((detail) => detail.holeno == holeNo)
        .toList();

    if (scoreDataList.isEmpty) {
      return _buildEmptyRow(holeNo, rowIndex, context);
    }

    var scoreData = scoreDataList.first;
    return _buildDataRow([
      scoreData.holeno.toString(),
      scoreData.par.toString(),
      scoreData.indexnumber.toString(),
      scoreData.timetaken!,
    ], rowIndex, context);
  }

  Widget _buildEmptyRow(int holeNo, int rowIndex, BuildContext context) {
    return _buildDataRow([
      holeNo.toString(),
      ' ',
      ' ',
      ' ',
    ], rowIndex, context);
  }

  Widget _buildDataRow(
      List<String> values, int rowIndex, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var value in values)
            Expanded(child: _buildCell(value, rowIndex)),
        ],
      ),
    );
  }

  Widget _buildDynamicTable(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeaderRow(
           playerDetails!.asMap().entries.map((entry) {
              int index = entry.key;
              return String.fromCharCode(65 + index);
            }).toList(),
            0,
            context),
        for (var i = 1; i <= 9; i++) _buildDynamicDataRow(i, i, context),
        _buildDynamicInRow(true, context),
        for (var i = 10; i <= 18; i++) _buildDynamicDataRow(i, i, context),
        _buildDynamicInRow(false, context),
        _buildTotalInRow(false, context),
        _buildSloapInRow(false, context),
        _buildSSSInRow(false, context),
      ],
    );
  }

  Widget _buildDynamicDataRow(int holeNo, int rowIndex, BuildContext context) {
    List<String> scores = [];

    for (var player in  playerDetails!) {
      var scoreData =  scoreDetails!.firstWhere(
        (detail) =>
            detail.holeno == holeNo &&
            detail.handycaptype == player.handycaptype,
        orElse: () {
          return ScoreCardDetail(
            gamedate:  "",
            handycaptype: player.handycaptype,
            holeno: holeNo,
            indexnumber: 0,
            memberId: '',
            membershipId: '',
            par: 0,
            score: 0,
            scorecardId: '',
            teestartname: '',
            timetaken: '0',
          );
        },
      );

      scores.add(scoreData.score!.toString());
    }

    return _buildDataRow(scores, rowIndex, context);
  }

  Widget _buildDynamicInRow(bool isFirstHalf, BuildContext context) {
    List<String> totalScores = [];

    for (var player in playerDetails!) {
      int totalScore = 0;

      for (var i = isFirstHalf ? 1 : 10; i <= (isFirstHalf ? 9 : 18); i++) {
        var scoreData =  scoreDetails!.firstWhere(
          (detail) =>
              detail.holeno == i && detail.handycaptype == player.handycaptype,
          orElse: () {
            return ScoreCardDetail(
              gamedate:  "",
              handycaptype: player.handycaptype,
              holeno: 0,
              indexnumber: 0,
              memberId: '',
              membershipId: '',
              par: 0,
              score: 0,
              scorecardId: '',
              teestartname: '',
              timetaken: '0',
            );
          },
        );
        totalScore += scoreData.score!;
      }

      totalScores.add(totalScore.toString());
    }

    return _buildDataRow(
        totalScores, isFirstHalf ? 1 : 2, context); // Using a dummy index
  }

  Widget _buildTotalInRow(bool isFirstHalf, BuildContext context) {
    List<String> totalScores = [];

    for (var player in  playerDetails!) {
      int totalScore = 0;

      for (var i = 1; i <= 18; i++) {
        var scoreData =  scoreDetails!.firstWhere(
          (detail) =>
              detail.holeno == i && detail.handycaptype == player.handycaptype,
          orElse: () {
            return ScoreCardDetail(
              gamedate: "",
              handycaptype: player.handycaptype,
              holeno: 0,
              indexnumber: 0,
              memberId: '',
              membershipId: '',
              par: 0,
              score: 0,
              scorecardId: '',
              teestartname: '',
              timetaken: '0',
            );
          },
        );
        totalScore += scoreData.score!;
      }

      totalScores.add(totalScore.toString());
    }

    return _buildDataRow(
        totalScores, 1, context); // Using a dummy index
  }

  Widget _buildSloapInRow(bool isFirstHalf, BuildContext context) {
    List<String> sloapValues = [];

    for (var player in  playerDetails!) {
      var slopeData =  sloapSss!.firstWhere(
        (detail) => detail.handicaptype == player.handycaptype,
        orElse: () {
          return SlopeRatingAndSss(
              handicaptype: player.handycaptype, sloperating: 0, sss: 1.0);
        },
      );

      double sloap = slopeData.sloperating!.toDouble();

      sloapValues.add(sloap.toString());
    }

    return _buildDataRow(sloapValues, 2, context);
  }

  Widget _buildSSSInRow(bool isFirstHalf, BuildContext context) {
    List<String> sssValues = [];

    for (var player in playerDetails!) {
      var slopeData =  sloapSss!.firstWhere(
        (detail) => detail.handicaptype == player.handycaptype,
        orElse: () {
          return SlopeRatingAndSss(
              handicaptype: player.handycaptype, sloperating: 0, sss: 1.0);
        },
      );

      double sss = slopeData.sss!.toDouble();

      sssValues.add(sss.toString());
    }

    return _buildDataRow(sssValues, 1, context);
  }

  Widget _buildCell(String value, int rowIndex, {bool isHeader = false}) {
    return Container(
      height: isHeader ? 40 : 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        color: isHeader
            ? const Color(0xffC1B795)
            : (rowIndex % 2 == 0)
                ? const Color(0xffA8DCA7)
                : const Color(0xffDAF0D9),
      ),
      child: Text(
        value,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: TextStyle(
          fontSize: isHeader ? 13 : 11,
          fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildHeaderRow(
      List<String> headers, int rowIndex, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: headers
            .map((header) =>
                Expanded(child: _buildCell(header, rowIndex, isHeader: true)))
            .toList(),
      ),
    );
  }

  Widget _buildFixedInRow(bool isFirstHalf, BuildContext context) {
    double totalPar = 0;
    double totalIndex = 0;
    double totalTimeTaken = 0;

    for (var i = isFirstHalf ? 1 : 10; i <= (isFirstHalf ? 9 : 18); i++) {
      var scoreData =  scoreDetails!.firstWhere(
        (detail) => detail.holeno == i,
        orElse: () {
          return ScoreCardDetail(
            gamedate:  "",
            handycaptype: '',
             holeno: 0,
            indexnumber: 0,
            memberId: '',
            membershipId: '',
            par: 0,
            score: 0,
            scorecardId: '',
            teestartname: '',
            timetaken: '0',
          );
        },
      );

      totalPar += scoreData.par!;
      totalIndex += scoreData.indexnumber!;
      totalTimeTaken += int.tryParse(scoreData.timetaken!!) ?? 0;
    }

    return _buildDataRow([
      'IN',
      totalPar.toString(),
      totalIndex.toString(),
      totalTimeTaken.toString()
    ], isFirstHalf ? 1 : 2, context); // Use 1 or 2 as a dummy index
  }

  Widget _buildTotalFixedInRow(bool isFirstHalf, BuildContext context) {
    double totalPar = 0;
    double totalIndex = 0;
    double totalTimeTaken = 0;

    for (var i = 1; i <= 18; i++) {
      var scoreData =  scoreDetails!.firstWhere(
        (detail) => detail.holeno == i,
        orElse: () {
          return ScoreCardDetail(
            gamedate: " ",
            handycaptype: '',
            holeno: i,
            indexnumber: 0,
            memberId: '',
            membershipId: '',
            par: 0,
            score: 0,
            scorecardId: '',
            teestartname: '',
            timetaken: '0',
          );
        },
      );

      totalPar += scoreData.par!.toDouble();
      totalIndex += scoreData.indexnumber!;
      totalTimeTaken += int.tryParse(scoreData.timetaken!) ?? 0;
    }

    return _buildDataRow([
      'Total',
      totalPar.toString(),
      totalIndex.toString(),
      totalTimeTaken.toString()
    ],  1, context);
  }

  Widget _buildSloapFixedInRow(bool isFirstHalf, BuildContext context) {
    return _buildDataRow(['Sloap', "", "", ""],  2, context);
  }

  Widget _buildSSSFixedInRow(bool isFirstHalf, BuildContext context) {
    return _buildDataRow(['SSS', "", "", ""],  1, context);
  }
}
