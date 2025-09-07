// To parse this JSON data, do
//
//     final uploadingVideoVoiceModel = uploadingVideoVoiceModelFromJson(jsonString);

import 'dart:convert';

UploadingVideoVoiceModel uploadingVideoVoiceModelFromJson(String str) => UploadingVideoVoiceModel.fromJson(json.decode(str));

String uploadingVideoVoiceModelToJson(UploadingVideoVoiceModel data) => json.encode(data.toJson());

class UploadingVideoVoiceModel {
  String status;
  int resourceId;
  int qualityCheckId;
  Results results;

  UploadingVideoVoiceModel({
    required this.status,
    required this.resourceId,
    required this.qualityCheckId,
    required this.results,
  });

  factory UploadingVideoVoiceModel.fromJson(Map<String, dynamic> json) => UploadingVideoVoiceModel(
    status: json["status"],
    resourceId: json["resource_id"],
    qualityCheckId: json["quality_check_id"],
    results: Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "resource_id": resourceId,
    "quality_check_id": qualityCheckId,
    "results": results.toJson(),
  };
}

class Results {
  Loudness loudness;
  Snr snr;
  Silence silence;
  AudioIssues audioIssues;

  Results({
    required this.loudness,
    required this.snr,
    required this.silence,
    required this.audioIssues,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    loudness: Loudness.fromJson(json["loudness"]),
    snr: Snr.fromJson(json["snr"]),
    silence: Silence.fromJson(json["silence"]),
    audioIssues: AudioIssues.fromJson(json["audio_issues"]),
  );

  Map<String, dynamic> toJson() => {
    "loudness": loudness.toJson(),
    "snr": snr.toJson(),
    "silence": silence.toJson(),
    "audio_issues": audioIssues.toJson(),
  };
}

class AudioIssues {
  double clipRatio;
  double avgSpectralFlatness;
  String status;

  AudioIssues({
    required this.clipRatio,
    required this.avgSpectralFlatness,
    required this.status,
  });

  factory AudioIssues.fromJson(Map<String, dynamic> json) => AudioIssues(
    clipRatio: json["clip_ratio"],
    avgSpectralFlatness: json["avg_spectral_flatness"]?.toDouble(),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "clip_ratio": clipRatio,
    "avg_spectral_flatness": avgSpectralFlatness,
    "status": status,
  };
}

class Loudness {
  String status;
  double valueDbfs;

  Loudness({
    required this.status,
    required this.valueDbfs,
  });

  factory Loudness.fromJson(Map<String, dynamic> json) => Loudness(
    status: json["status"],
    valueDbfs: json["value_dbfs"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "value_dbfs": valueDbfs,
  };
}

class Silence {
  int silentPeriods;
  int totalSilenceSeconds;
  String status;

  Silence({
    required this.silentPeriods,
    required this.totalSilenceSeconds,
    required this.status,
  });

  factory Silence.fromJson(Map<String, dynamic> json) => Silence(
    silentPeriods: json["silent_periods"],
    totalSilenceSeconds: json["total_silence_seconds"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "silent_periods": silentPeriods,
    "total_silence_seconds": totalSilenceSeconds,
    "status": status,
  };
}

class Snr {
  double snrDb;

  Snr({
    required this.snrDb,
  });

  factory Snr.fromJson(Map<String, dynamic> json) => Snr(
    snrDb: json["snr_db"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "snr_db": snrDb,
  };
}
