import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bangunkebun_dev/models/product.dart';
import 'package:bangunkebun_dev/providers/productProvider.dart';
import 'package:bangunkebun_dev/providers/otherProvider.dart';
import 'package:bangunkebun_dev/widgets/button.dart';
import 'package:bangunkebun_dev/widgets/inputForm.dart';

class CreateProductPage extends StatefulWidget {
  static const routeName = '/addArticlePage';

  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final ProductProvider _contentProvider = ProductProvider();

  List? jenisProduk;
  int? selectedJenisProduk;
  int? selectedStatusKetahanan;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? _imageUrl;

  TextEditingController judulProdukController = TextEditingController();
  CustomFormField hargaProdukController = TextEditingController();
  TextEditingController stokProdukController = TextEditingController();
  TextEditingController deskripsiProdukController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final otherProvider = Provider.of<OtherProvider>(context, listen: false);

      if (otherProvider.dataJenisKonten == null) {
        showDialog(
          context: context,
          barrierDismissible: false, // Tidak bisa ditutup klik di luar
          builder:
              (context) => const Center(child: CircularProgressIndicator()),
        );
        await otherProvider.getJenisProduk();
        Navigator.pop(context);
      }

      setState(() {
        jenisProduk = otherProvider.dataJenisKonten;
      });
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
        print(selectedImage);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
    }
  }

  Future<void> _uploadImage() async {
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/dx5muldq0/image/upload',
    );
    final request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'BangunKebun';
    request.files.add(
      await http.MultipartFile.fromPath('file', selectedImage!.path),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      final url = jsonMap['url'];

      setState(() {
        _imageUrl = url;
      });

      print(url);
    } else {
      final responseString = await response.stream.bytesToString();
      print('Upload failed with status: ${response.statusCode}');
      print('Response: $responseString');
    }
  }

  Future<void> _addProduct(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id_user = prefs.getInt('id_user');

    if (selectedJenisProduk == 2) {
      try {
        await _uploadImage();
        Product product = Product(
          namaProduk: judulProdukController.text
          harga: double.parse(hargaProdukController),
          idJenisProduk: selectedJenisProduk,
          idStatusKetahanan: selectedStatusKetahanan,
          gambarProduk: _imageUrl,
          isiDeskripsi: deskripsiProdukController.text,
          id_user: id_user,
        );
        bool isSuccess = await _contentProvider.addProduct(product);
        if (isSuccess) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Produk Berhasil Ditambahkan');
        } else {
          Fluttertoast.showToast(msg: 'Produk Gagal Ditambahkan');
        }
      } catch (e) {
        print(e);
      }
      Navigator.pop(context);
    } else {
      try {
        Product product = Product(
          namaProduk: judulProdukController.text,
          idJenisProduk: selectedJenisProduk,
          idStatusKetahanan: selectedStatusKetahanan,
          gambarProduk: _imageUrl,
          isiDeskripsi: deskripsiProdukController.text,
          id_user: id_user,
        );
        bool isSuccess = await _contentProvider.addProduct(product);
        if (isSuccess) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Produk Berhasil Ditambahkan');
        } else {
          Fluttertoast.showToast(msg: 'Produk Gagal Ditambahkan');
        }
      } catch (e) {
        print(e);
      }
      Navigator.pop(context);
    }
  }

  bool isComplete() {
    return selectedJenisProduk != null &&
            judulProdukController.text.isNotEmpty &&
            deskripsiProdukController.text.isNotEmpty &&

        selectedImage != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white),
        body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tambah baru',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 30.sp,
                  ),
                ),
                Text(
                  'Masukkan isi konten anda',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Color(0xFF828282),
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  'Judul Konten',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                InputFormWithHintText(
                  type: TextInputType.text,
                  text: 'Masukkan Judul Konten',
                  controller: judulKontenController,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Jenis Konten',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 233, 233, 233),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<int>(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    isExpanded: true,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    underline: Container(),
                    disabledHint: const Text(
                      'Jenis Konten',
                      style: TextStyle(
                        color: Colors.black12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: selectedJenisKonten,
                    hint: const Text(
                      'Pilih jenis konten',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black26,
                      ),
                    ),
                    items:
                        jenisKonten == null
                            ? []
                            : jenisKonten!.map<DropdownMenuItem<int>>((jenis) {
                              return DropdownMenuItem<int>(
                                value: jenis['id_jenis_konten'],
                                child: Text(jenis['jenis_konten']),
                              );
                            }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedJenisKonten = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                selectedJenisKonten == 2
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gambar Artikel',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        selectedImage == null
                            ? GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 233, 233, 233),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: Center(
                                  child: Icon(
                                    Icons.add_photo_alternate_rounded,
                                    size: 50,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                              onTap: () {
                                _pickImage();
                              },
                            )
                            : Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              alignment: Alignment.bottomRight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: FileImage(selectedImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: CircleAvatar(
                                    backgroundColor: Color.fromARGB(
                                      255,
                                      233,
                                      233,
                                      233,
                                    ).withOpacity(0.8),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _pickImage();
                                },
                              ),
                            ),

                        SizedBox(height: 10.h),
                        Text(
                          'Konten Artikel',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        InputFormWithHintTextMaxlines(
                          type: TextInputType.emailAddress,
                          text: 'Masukkan Konten Artikel',
                          controller: deskripsiKontenController,
                          maxlines: 10,
                        ),
                      ],
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Link Video',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        InputFormWithHintText(
                          type: TextInputType.emailAddress,
                          text: 'Masukkan Link Video',
                          controller: linkVideoController,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Deskripsi Video',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        InputFormWithHintTextMaxlines(
                          type: TextInputType.emailAddress,
                          text: 'Masukkan Deskripsi Video',
                          controller: deskripsiKontenController,
                          maxlines: 10,
                        ),
                      ],
                    ),
                SizedBox(height: 40.h),
                LongButton(
                  text: 'Posting Konten',
                  color: '007B29',
                  colorText: 'FFFFFF',
                  onPressed: () async {
                    if (!isComplete()) {
                      Fluttertoast.showToast(
                        msg: "Data belum lengkap",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                        fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
                      );
                    } else {
                      await _addArticle(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
