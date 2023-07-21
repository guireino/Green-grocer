import 'package:freezed_annotation/freezed_annotation.dart';

//part vai criar arquivo com comando terminal flutter pub run build_runner watch
part 'home_result.freezed.dart';

//<T> deixar list generica
@freezed
class HomeResult<T> with _$HomeResult<T> {
  factory HomeResult.success(List<T> data) = Success;
  factory HomeResult.error(String data) = Error;
}
