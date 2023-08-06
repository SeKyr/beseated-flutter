import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_series_request.freezed.dart';
part 'create_series_request.g.dart';

@freezed
class CreateSeriesRequest with _$CreateSeriesRequest {
  factory CreateSeriesRequest({
    required DateTime startdate,
    required DateTime enddate,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'roomId') required int floorDistributionId,
    required String email,
    required String cronPattern,
  }) = _CreateSeriesRequest;

  factory CreateSeriesRequest.fromJson(Map<String, dynamic> json) => _$CreateSeriesRequestFromJson(json);

}