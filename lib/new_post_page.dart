import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rent_and_go/main.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  String _rentName = '';
  String _rentDescript = '';
  String _rentCost = '';
  String _rentCity = '';
  String _rentPhone = '';
  int _isStar = 0;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 72),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      obscureText: false,
                      maxLength: 35,
                      decoration: const InputDecoration(
                        hintText: 'Оглавление',
                        contentPadding: EdgeInsets.only(right: 16, top: 8, bottom: 8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.grey, width: 2)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Color.fromARGB(255, 18, 63, 237), width: 2)
                        ),
                        prefixIcon: Icon(Icons.text_fields)
                      ),
                      onChanged: (String value) {
                        _rentName = value;
                      },
                    ),
                    const SizedBox(height: 8,),
                    TextField(
                      obscureText: false,
                      maxLength: 1000,
                      minLines: 1,
                      maxLines: 30,
                      decoration: const InputDecoration(
                          hintText: 'Описание',
                          contentPadding: EdgeInsets.only(right: 16, top: 8, bottom: 8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.grey, width: 2)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Color.fromARGB(255, 18, 63, 237), width: 2)
                          ),
                          prefixIcon: Icon(Icons.text_fields)
                      ),
                      onChanged: (String value) {
                        _rentDescript = value;
                      },
                    ),
                    const SizedBox(height: 8,),
                    TextField(
                      maxLength: 20,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Стоимость (₽/мес.)',
                          contentPadding: EdgeInsets.only(right: 16, top: 8, bottom: 8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.grey, width: 2)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Color.fromARGB(255, 18, 63, 237), width: 2)
                          ),
                          prefixIcon: Icon(Icons.account_balance_wallet)
                      ),
                      onChanged: (String value) {
                        _rentCost = value;
                      },
                    ),
                    const SizedBox(height: 8,),
                    TextField(
                      obscureText: false,
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Город',
                          contentPadding: EdgeInsets.only(right: 16, top: 8, bottom: 8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.grey, width: 2)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Color.fromARGB(255, 18, 63, 237), width: 2)
                          ),
                          prefixIcon: Icon(Icons.location_city)
                      ),
                      onChanged: (String value) {
                        _rentCity = value;
                      },
                    ),
                    TextField(
                      obscureText: false,
                      maxLength: 11,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          hintText: 'Контактный номер',
                          contentPadding: EdgeInsets.only(right: 16, top: 8, bottom: 8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.grey, width: 2)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Color.fromARGB(255, 18, 63, 237), width: 2)
                          ),
                          prefixIcon: Icon(Icons.phone)
                      ),
                      onChanged: (String value) {
                        _rentPhone = value;
                      },
                    ),
                    const SizedBox(height: 8,),
                    Container(
                      height: imageFileList!.isEmpty ? 0 : 118,
                      child: GridView.builder(
                          itemCount: imageFileList!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Image.file(File(imageFileList![index].path), fit: BoxFit.cover,),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        imageFileList?.removeAt(index);
                                      });
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      foregroundColor: MaterialStateProperty.all(Colors.red),
                                      maximumSize: MaterialStateProperty.all(Size(24, 24)),
                                      minimumSize: MaterialStateProperty.all(Size(24, 24)),
                                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                                    ),
                                    child: Icon(Icons.clear, size: 18),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isStar = index;
                                      });
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      foregroundColor: MaterialStateProperty.all(Colors.blue),
                                      maximumSize: MaterialStateProperty.all(Size(24, 24)),
                                      minimumSize: MaterialStateProperty.all(Size(24, 24)),
                                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                                    ),
                                    child: (_isStar == index) ? Icon(Icons.star, size: 18) : Icon(Icons.star_border, size: 18),
                                  ),
                                ),
                              ],
                            );
                          }
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          selectImages();
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 18, 63, 237)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Прикрепить фото',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40,),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            allRentsList.add([_rentName, _rentDescript, _rentCost, _rentCity, _rentPhone, imageFileList, _isStar]);
                          });
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 18, 63, 237)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(const Size(100, 50)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: const Text('Разместить', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
                    ),
                  ],
                ),
              )
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
