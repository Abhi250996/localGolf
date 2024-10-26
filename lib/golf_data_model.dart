class Golfmodel {
  Entity? entity;
  String? message;
  int? status;

  Golfmodel({
    this.entity,
    this.message,
    this.status,
  });

  factory Golfmodel.fromJson(Map<String, dynamic> json) => Golfmodel(
    entity: json["entity"] != null ? Entity.fromJson(json["entity"]) : null,
    message: json["message"] ?? '', // Default to empty string if null
    status: json["status"] ?? 0, // Default to 0 if null
  );
}

class Entity {
  List<PlayerDetail>? playerDetail;
  List<ScoreCardDetail>? scoreCardDetail;
  List<SlopeRatingAndSss>? slopeRatingAndSss;

  Entity({
    this.playerDetail,
    this.scoreCardDetail,
    this.slopeRatingAndSss,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
    playerDetail: json["PlayerDetail"] != null
        ? List<PlayerDetail>.from(json["PlayerDetail"]
        .map((x) => PlayerDetail.fromJson(x)))
        : [],
    scoreCardDetail: json["scoreCardDetail"] != null
        ? List<ScoreCardDetail>.from(json["scoreCardDetail"]
        .map((x) => ScoreCardDetail.fromJson(x)))
        : [],
    slopeRatingAndSss: json["slopeRatingAndSSS"] != null
        ? List<SlopeRatingAndSss>.from(json["slopeRatingAndSSS"]
        .map((x) => SlopeRatingAndSss.fromJson(x)))
        : [],
  );
}

class PlayerDetail {
  String? gameDate;
  String? gameId;
  int? handycap;
  String? handycaptype;
  String? memberCode;
  String? memberId;
  String? memberName;
  String? membershipId;
  String? memberType;
  String? scorecardId;
  String? teamCode;

  PlayerDetail({
    this.gameDate,
    this.gameId,
    this.handycap,
    this.handycaptype,
    this.memberCode,
    this.memberId,
    this.memberName,
    this.membershipId,
    this.memberType,
    this.scorecardId,
    this.teamCode,
  });

  factory PlayerDetail.fromJson(Map<String, dynamic> json) => PlayerDetail(
    gameDate: json["gameDate"] ?? '', // Default to empty string if null
    gameId: json["gameId"] ?? '',
    handycap: json["handycap"] ?? 0, // Default to 0 if null
    handycaptype: json["handycaptype"] ?? '',
    memberCode: json["memberCode"] ?? '',
    memberId: json["memberId"] ?? '',
    memberName: json["memberName"] ?? '',
    membershipId: json["membershipId"] ?? '',
    memberType: json["memberType"] ?? '',
    scorecardId: json["scorecardId"] ?? '',
    teamCode: json["teamCode"] ?? '',
  );
}

class ScoreCardDetail {
  String? gamedate;
  String? handycaptype;
  int? holeno;
  int? indexnumber;
  String? memberId;
  String? membershipId;
  int? par;
  int? score;
  String? scorecardId;
  String? teestartname;
  String? timetaken;

  ScoreCardDetail({
    this.gamedate,
    this.handycaptype,
    this.holeno,
    this.indexnumber,
    this.memberId,
    this.membershipId,
    this.par,
    this.score,
    this.scorecardId,
    this.teestartname,
    this.timetaken,
  });

  factory ScoreCardDetail.fromJson(Map<String, dynamic> json) =>
      ScoreCardDetail(
        gamedate: json["gamedate"] != null
            ? json["gamedate"]
            :  "", // Default to current date if null
        handycaptype: json["handycaptype"] ?? '',
        holeno: json["holeno"] ?? 0,
        indexnumber: json["indexnumber"] ?? 0,
        memberId: json["memberId"] ?? '',
        membershipId: json["membershipId"] ?? '',
        par: json["par"] ?? 0,
        score: json["score"] ?? 0,
        scorecardId: json["scorecardId"] ?? '',
        teestartname: json["teestartname"] ?? '',
        timetaken: json["timetaken"] ?? '0',
      );
}

class SlopeRatingAndSss {
  String? handicaptype;
  int? sloperating;
  double? sss;

  SlopeRatingAndSss({
    this.handicaptype,
    this.sloperating,
    this.sss,
  });

  factory SlopeRatingAndSss.fromJson(Map<String, dynamic> json) =>
      SlopeRatingAndSss(
        handicaptype: json["handicaptype"] ?? '',
        sloperating: json["sloperating"] ?? 0,
        sss: json["sss"]?.toDouble() ?? 0.0,
      );
}
