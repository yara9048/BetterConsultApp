// To parse this JSON data, do
//
//     final qualityData = qualityDataFromJson(jsonString);

import 'dart:convert';

QualityData qualityDataFromJson(String str) => QualityData.fromJson(json.decode(str));

String qualityDataToJson(QualityData data) => json.encode(data.toJson());

class QualityData {
  String status;
  Results results;

  QualityData({
    required this.status,
    required this.results,
  });

  factory QualityData.fromJson(Map<String, dynamic> json) => QualityData(
    status: json["status"],
    results: Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": results.toJson(),
  };
}

class Results {
  AudioLoudness audioLoudness;
  Snr snr;
  AudioIssues audioIssues;
  Silence silence;
  BlackScreen blackScreen;
  Blurriness blurriness;
  Resolution resolution;
  FrameRate frameRate;
  FaceConsistency faceConsistency;

  Results({
    required this.audioLoudness,
    required this.snr,
    required this.audioIssues,
    required this.silence,
    required this.blackScreen,
    required this.blurriness,
    required this.resolution,
    required this.frameRate,
    required this.faceConsistency,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    audioLoudness: AudioLoudness.fromJson(json["audio_loudness"]),
    snr: Snr.fromJson(json["snr"]),
    audioIssues: AudioIssues.fromJson(json["audio_issues"]),
    silence: Silence.fromJson(json["silence"]),
    blackScreen: BlackScreen.fromJson(json["black_screen"]),
    blurriness: Blurriness.fromJson(json["blurriness"]),
    resolution: Resolution.fromJson(json["resolution"]),
    frameRate: FrameRate.fromJson(json["frame_rate"]),
    faceConsistency: FaceConsistency.fromJson(json["face_consistency"]),
  );

  Map<String, dynamic> toJson() => {
    "audio_loudness": audioLoudness.toJson(),
    "snr": snr.toJson(),
    "audio_issues": audioIssues.toJson(),
    "silence": silence.toJson(),
    "black_screen": blackScreen.toJson(),
    "blurriness": blurriness.toJson(),
    "resolution": resolution.toJson(),
    "frame_rate": frameRate.toJson(),
    "face_consistency": faceConsistency.toJson(),
  };
}

class AudioIssues {
  int clipRatio;
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

class AudioLoudness {
  String status;
  double valueDbfs;

  AudioLoudness({
    required this.status,
    required this.valueDbfs,
  });

  factory AudioLoudness.fromJson(Map<String, dynamic> json) => AudioLoudness(
    status: json["status"],
    valueDbfs: json["value_dbfs"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "value_dbfs": valueDbfs,
  };
}

class BlackScreen {
  int blackFrameRatio;
  String status;

  BlackScreen({
    required this.blackFrameRatio,
    required this.status,
  });

  factory BlackScreen.fromJson(Map<String, dynamic> json) => BlackScreen(
    blackFrameRatio: json["black_frame_ratio"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "black_frame_ratio": blackFrameRatio,
    "status": status,
  };
}

class Blurriness {
  int blurryFrameRatio;
  String status;

  Blurriness({
    required this.blurryFrameRatio,
    required this.status,
  });

  factory Blurriness.fromJson(Map<String, dynamic> json) => Blurriness(
    blurryFrameRatio: json["blurry_frame_ratio"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "blurry_frame_ratio": blurryFrameRatio,
    "status": status,
  };
}

class FaceConsistency {
  String error;

  FaceConsistency({
    required this.error,
  });

  factory FaceConsistency.fromJson(Map<String, dynamic> json) => FaceConsistency(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}

class FrameRate {
  double fps;
  String status;

  FrameRate({
    required this.fps,
    required this.status,
  });

  factory FrameRate.fromJson(Map<String, dynamic> json) => FrameRate(
    fps: json["fps"]?.toDouble(),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "fps": fps,
    "status": status,
  };
}

class Resolution {
  String resolution;
  String status;

  Resolution({
    required this.resolution,
    required this.status,
  });

  factory Resolution.fromJson(Map<String, dynamic> json) => Resolution(
    resolution: json["resolution"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "resolution": resolution,
    "status": status,
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
