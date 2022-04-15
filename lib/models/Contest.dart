import 'package:intl/intl.dart';
class Contest {
  String id;
  String event;
  String host;
  String link;
  String start;
  String end;

  Contest(
      {required this.id,
      required this.event,
      required this.host,
      required this.start,
      required this.end,
      required this.link});

  factory Contest.fromJson(Map<String, dynamic> json) {
    final format = DateFormat.yMd('en_us');
    return Contest(
        id: json['id'].toString(),
        event: json['event'],
        host: json['host'],
        start:json['start'] ,
        end: json['end'],
        link: json['href']);
  }
}
