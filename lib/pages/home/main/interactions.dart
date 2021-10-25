import 'package:flutter/material.dart';
import 'package:panchat_plus/pages/home/subtab/people.dart';
import 'package:panchat_plus/pages/home/subtab/requests.dart';
import 'package:panchat_plus/shared/styles/styles.dart';

class Interactions extends StatefulWidget {
  const Interactions({Key? key}) : super(key: key);

  @override
  _InteractionsState createState() => _InteractionsState();
}

class _InteractionsState extends State<Interactions> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: mainColor,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.email),),
                Tab(icon: Icon(Icons.people),),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Requests(),
            People(),
          ],
        ),
      ),
    );
  }
}
