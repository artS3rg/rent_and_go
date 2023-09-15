import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_and_go/new_post_page.dart';
import 'package:rent_and_go/rent_page.dart';

List allRentsList = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/newpost': (context) => const NewPostPage(),
        '/rent': (context) => const RentPage(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<dynamic> _foundList = [];
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Поиск";

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Поиск...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 18.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    List<dynamic> results = [];
    if (newQuery.isEmpty) {
      results = allRentsList;
    } else {
      results = allRentsList
          .where((user) =>
          user[3].toLowerCase().contains(newQuery.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundList = results;
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  Future<void> updateUI() async {
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _foundList = allRentsList;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Color.fromARGB(255, 18, 63, 237),
        shadowColor: const Color.fromARGB(0, 236, 236, 236),
        leading: _isSearching ? const BackButton() : Container(),
        title: _isSearching ? _buildSearchField() : Container(),
        actions: _buildActions(),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: updateUI,
          child: ListView.builder(
            itemCount: _foundList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/rent', arguments: [_foundList[index][0],
                        _foundList[index][1], _foundList[index][2], _foundList[index][3],
                        _foundList[index][4], _foundList[index][5], _foundList[index][6]]);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                      ),
                      elevation: MaterialStateProperty.all(5),
                      minimumSize: MaterialStateProperty.all(Size(400, 266)),
                      maximumSize: MaterialStateProperty.all(Size(600, 266)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 176,
                            color: Colors.grey,
                            child: Image.file(File(_foundList[index][5][_foundList[index][6]].path)),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _foundList[index][0],
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 18, 63, 237),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 16, top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _foundList[index][2] + ' ₽/мес.',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  Text(
                                    _foundList[index][3],
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 18, 63, 237),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/newpost');
        },
        child: const Icon(Icons.add, size: 30,),
      ),
    );
  }
}
