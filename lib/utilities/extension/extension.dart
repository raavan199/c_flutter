import '../../exports/constants.dart';

extension ToString on MessageType {
  String get string => toString().split('.').last;
}
