import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:clist/models/Contest.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<List<Contest>> getContests() async {
    List<Contest> clist = <Contest>[];
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    final response = await http.get(Uri.parse(
        'https://clist.by/api/v2/contest/?username=coderr_&api_key=50782e56c2c92c88f7cd83e95e54924ae7971376&start__gt=${formatted}T00:00:00&order_by=end&limit=30&format_time=true'));

    if (response.statusCode == 200) {
      final contests = json.decode(response.body)['objects'];

      for (int i = 0; i < contests.length; i++) {
        clist.add(Contest.fromJson(contests[i]));
      }
    }

    return clist;
  }
}
