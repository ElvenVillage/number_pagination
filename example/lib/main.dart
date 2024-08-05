import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:number_pagination/page_number_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumberPagenation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedPageNumber = 3;

  final _pageService = NumberPageService(1);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Container(
            alignment: Alignment.center,
            height: 100,
            color: Colors.yellow[200],
            child: Text('PAGE INFO $selectedPageNumber'), //do manage state
          ),
        ),
        NumberPagination(
          pageService: _pageService,
          onPageChanged: (int pageNumber) {
            //To optimize further, use a package that supports partial updates instead of setState (e.g. riverpod)
            setState(() {
              selectedPageNumber = pageNumber;
            });
          },
          threshold: 15,
          pageTotal: 100,
          pageInit: selectedPageNumber, // picked number when init page
          colorPrimary: Colors.red,
          colorSub: Colors.yellow,
        ),
      ],
    );
  }
}
