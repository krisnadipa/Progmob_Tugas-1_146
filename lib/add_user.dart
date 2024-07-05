import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/list_user.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final Dio dio = Dio();
  final GetStorage myStorage = GetStorage();
  final String apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController noIndukController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  TextEditingController teleponController = TextEditingController();

  DateTime selectedDate =
      DateTime.now(); // Untuk menyimpan tanggal yang dipilih

  // Method untuk menampilkan date picker dan menyimpan tanggal yang dipilih
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        tglLahirController.text = picked.toString().split(
            ' ')[0]; // Menampilkan tanggal yang dipilih dalam format yyyy-MM-dd
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Anggota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: noIndukController,
              decoration: InputDecoration(
                labelText: 'Nomor Induk',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () =>
                  _selectDate(context), // Panggil _selectDate saat tombol tap
              child: IgnorePointer(
                child: TextFormField(
                  controller: tglLahirController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    labelStyle: const TextStyle(color: Colors.black),
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: teleponController,
              decoration: InputDecoration(
                labelText: 'Telephone',
                labelStyle: const TextStyle(color: Colors.black),
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.bottomSlide,
                  title: 'Konfirmasi',
                  desc: 'Apakah Anda yakin ingin menyimpan?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    addUser(
                      context,
                      dio,
                      myStorage,
                      apiUrl,
                      noIndukController.text,
                      namaController.text,
                      alamatController.text,
                      tglLahirController.text,
                      teleponController.text,
                    );
                  },
                ).show();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 14, 95, 161),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              child: const Text(
                'Simpan',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

void addUser(
  BuildContext context,
  Dio dio,
  GetStorage myStorage,
  String apiUrl,
  String noInduk,
  String nama,
  String alamat,
  String tglLahir,
  String telepon,
) async {
  try {
    final response = await dio.post(
      '$apiUrl/anggota',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
      data: {
        'nomor_induk': noInduk,
        'nama': nama,
        'alamat': alamat,
        'tgl_lahir': tglLahir,
        'telepon': telepon,
      },
    );
    print(response.data);

    // Pindah halaman ke list user jika berhasil menambahkan anggota
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ListUser()),
    );
  } on DioError catch (e) {
    if (e.response != null) {
      print('${e.response} - ${e.response!.statusCode}');
    } else {
      print(e.message);
    }
  }
}
