import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rent_and_go/main.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments??[]) as List;
    final children = <Widget>[];
    for (var i = 0; i < arguments[5].length; i++) {
      children.add(Padding(
        padding: const EdgeInsets.only(right: 4, left: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(File(arguments[5][i].path)),
        ),
      )
      );
    };
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 72),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(arguments[0], style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),),
                  const SizedBox(height: 20,),
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: children,
                    ),
                  ),
                  const SizedBox(height: 35,),
                  Text('Описание', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 6,),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(arguments[1], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  ),
                  const SizedBox(height: 35,),
                  Text('Стоимость', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 6,),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(arguments[2] + ' ₽/мес.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  ),
                  const SizedBox(height: 35,),
                  Text('Город', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 6,),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(arguments[3], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  ),
                  const SizedBox(height: 35,),
                  Text('Контактный номер', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 6,),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(arguments[4], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 18, 63, 237),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back, size: 30,),
      ),
    );
  }
}
