import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../utils/constants/event_constants.dart';

class ParseResp {
  int? id;
  List<ParseObject?> data;

  ParseResp(this.data, {this.id = EventConstants.noInternetConnection});
}
