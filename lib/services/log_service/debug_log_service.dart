import 'package:boilerplate/services/log_service/log_service.dart';

import 'package:talker_flutter/talker_flutter.dart';

class DebugLogService implements LogService {
  DebugLogService({TalkerLogger? logger}) {
    _logger = logger ?? TalkerLogger();
  }
  late final TalkerLogger _logger;

  @override
  void e(String message, dynamic e, StackTrace? stack) {
    _logger.error(message);
  }

  @override
  void i(String message) {
    _logger.info(message);
  }

  @override
  void w(String message, [dynamic e, StackTrace? stack]) {
    _logger.warning(message);
  }
}
