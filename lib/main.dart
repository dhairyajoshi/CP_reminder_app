// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable
import 'package:clist/models/Contest.dart';
import 'package:clist/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ScrollController _controller = ScrollController();

  // _scrollListener() {
  //   if (_controller.offset >= _controller.position.maxScrollExtent &&
  //       !_controller.position.outOfRange) {
  //     setState(() {
  //       print("reach the bottom");
  //     });
  //   }
  //   if (_controller.offset <= _controller.position.minScrollExtent &&
  //       !_controller.position.outOfRange) {
  //     setState(() {
  //       print("reach the top");
  //     });
  //   }
  // }

  // @override
  // void initState() {

  //   _controller.addListener(_scrollListener);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Clist')),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              FutureBuilder(
                  future: Api().getContests(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Contest contest = snapshot.data[index];
                            return ConCard(contest: contest);
                          },
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ConCard extends StatelessWidget {
  Contest contest;
  ConCard({Key? key, required this.contest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).secondaryHeaderColor,
        ),
        // width: double.infinity,
        // width: MediaQuery.of(context).size.width*0.5,
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Text(
                  contest.host,
                  style: TextStyle(
                      fontSize: 12 * 32 / (contest.host.length) > 32
                          ? 32
                          : 12 * 32 / (contest.host.length),
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 15,
            ),
            Align(
              child: Text(
                contest.event,
                style: TextStyle(
                    fontSize: 20 * 24 / (contest.event.length) > 25
                        ? 24
                        : 20 * 24 / (contest.event.length)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  contest.start,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(contest.end, style: TextStyle(fontSize: 20))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
                child: ElevatedButton(
              onPressed: () async{
                await launchUrl(Uri.parse(contest.link));
              },
              child: Text('Visit Page'),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor),
            ))
          ],
        ),
      ),
    );
  }
}
