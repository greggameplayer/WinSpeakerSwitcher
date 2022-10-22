import 'package:json_annotation/json_annotation.dart';
import 'package:win32audio/win32audio.dart';

part 'process_volume_extended.g.dart';

@JsonSerializable()
class ProcessVolumeExtended extends ProcessVolume {
  String? processName;

  ProcessVolumeExtended({
    int? processId,
    String? processPath,
    double? maxVolume,
    double? peakVolume,
  }) {
    if (processId != null) {
      this.processId = processId;
    } else {
      this.processId = 0;
    }

    if (processPath != null) {
      this.processPath = processPath;
    } else {
      this.processPath = "";
    }

    if (maxVolume != null) {
      this.maxVolume = maxVolume;
    } else {
      this.maxVolume = 1.0;
    }

    if (peakVolume != null) {
      this.peakVolume = peakVolume;
    } else {
      this.peakVolume = 0.0;
    }
  }

  @override
  String toString() {
    return 'ProcessVolumeExtended{processId: $processId, processPath: $processPath, maxVolume: $maxVolume, peakVolume: $peakVolume, processName: $processName}';
  }

  // tomap
  @override
  Map<String, dynamic> toMap() {
    return {
      'processId': processId,
      'processPath': processPath,
      'maxVolume': maxVolume,
      'peakVolume': peakVolume,
      'processName': processName,
    };
  }

  factory ProcessVolumeExtended.fromJson(Map<String, dynamic> map) =>
      _$ProcessVolumeExtendedFromJson(map);

  Map<String, dynamic> toJson() => _$ProcessVolumeExtendedToJson(this);
}
