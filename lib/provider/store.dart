import 'package:flutter/services.dart';
import 'package:phone_number/phone_number.dart';

import '../provider/parse_result.dart';
import '../provider/region.dart';

class Store {
  final PhoneNumber mobilePhone;
  Store(this.mobilePhone);

  List<Region> _regions;

  Future<List<Region>> getRegions() async {
    if (_regions == null) {
      final data = await mobilePhone.allSupportedRegions();
      _regions = data.entries
          .where((e) => e.key.length <= 2)
          .map((e) => Region(e.key, e.value))
          .toList();
      _regions.sort();
    }
    return _regions;
  }

  Future<ParseResult> parse(String string, {String region}) async {
    try {
      final result = await mobilePhone.parse(string, region: region);
      return ParseResult(result);
    } on PlatformException catch (e) {
      return ParseResult.error(e.code);
    }
  }

  Future<String> format(String phone, String region) async {
    try {
      final result = await mobilePhone.format(phone, region);
      return result['formatted'];
    } on PlatformException catch (e) {
      return e.code;
    }
  }
}
