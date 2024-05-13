import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/add_user.dart';
import 'package:my_app/list_user.dart';
import 'package:my_app/widget/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  get adduser => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag), label: 'keranjang'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
      ]),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                color: Colors.deepPurple,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              height: 46,
                              width: 45,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/profile.jpg')),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 2)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Halo krisna, selamat datang !",
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                goUser(dio, myStorage, apiUrl);
                              },
                              child: const Text(
                                'Cek User',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.notifications_active,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        cursorHeight: 20,
                        autofocus: false,
                        decoration: InputDecoration(
                            hintText: "cari alat berkebun terbaik anda",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Category(
                          imagePath: "images/farmer.png",
                          title: "Farm",
                        ),
                        Category(
                            imagePath: "images/tractor.png", title: "Service"),
                        Category(imagePath: "images/skop.png", title: "Tools"),
                        Category(
                            imagePath: "images/planting.png", title: "Plant"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddUser()),
                      );
                    },
                    child: Text(
                      'Tambah User',
                      style: TextStyle(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListUser()),
                      );
                    },
                    child: Text(
                      'Lihat List User',
                      style: TextStyle(),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}

void goUser(dio, myStorage, apiUrl) async {
  try {
    final response = await dio.get(
      '$apiUrl/user',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
