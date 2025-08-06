import 'dart:convert';
import 'dart:io';

import 'package:bangunkebun_dev/widgets/button.dart';
import 'package:bangunkebun_dev/widgets/inputForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddCommunityPage extends StatefulWidget {
  static const routeName = '/addCommunityPage';
  const AddCommunityPage({super.key});

  @override
  State<AddCommunityPage> createState() => _AddCommunityPageState();
}

class _AddCommunityPageState extends State<AddCommunityPage> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? _imageUrl;

  TextEditingController namaGrupController = TextEditingController();
  TextEditingController deskripsiGrupController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buat Grup')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:
                    selectedImage == null
                        ? CircleAvatar(
                          radius: 80,
                          child: GestureDetector(
                            onTap: () => _pickImage(),
                            child: Center(
                              child: Icon(Icons.add_photo_alternate_rounded),
                            ),
                          ),
                        )
                        : CircleAvatar(
                          radius: 80,
                          child: Image(
                            image: FileImage(selectedImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Nama Grup',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 10.h),
              InputFormWithHintText(
                type: TextInputType.text,
                text: 'Masukkan Nama Grup',
                controller: namaGrupController,
              ),
              SizedBox(height: 20.h),
              Text(
                'Deskripsi Grup',
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
                controller: deskripsiGrupController,
                maxlines: 10,
              ),
              SizedBox(height: 40.h),
              LongButton(
                text: 'Posting Konten',
                color: '007B29',
                colorText: 'FFFFFF',
                onPressed: () async {
                  // if (!isComplete()) {
                  //   Fluttertoast.showToast(
                  //     msg: "Data belum lengkap",
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.BOTTOM,
                  //     timeInSecForIosWeb: 1,
                  //     backgroundColor: Colors.red,
                  //     textColor: Colors.white,
                  //     fontSize: 16.0,
                  //     fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
                  //   );
                  // } else {
                  //   await _addArticle(context);
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
