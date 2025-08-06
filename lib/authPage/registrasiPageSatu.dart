import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:bangunkebun_dev/providers/otherProvider.dart';
import 'package:bangunkebun_dev/widgets/button.dart';
import 'package:bangunkebun_dev/widgets/inputForm.dart';

class RegistrasiPageSatu extends StatefulWidget {
  static const routeName = '/registrasiPageSatu';
  const RegistrasiPageSatu({super.key});

  @override
  State<RegistrasiPageSatu> createState() => _RegistrasiPageSatuState();
}

class _RegistrasiPageSatuState extends State<RegistrasiPageSatu> {
  int? idProvinsiSelected;
  int? idKabupatenSelected;
  int? idKecamatanSelected;

  List? dataProvinsi;
  List? dataKabupaten;
  List? dataKecamatan;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      final otherProvider = Provider.of<OtherProvider>(context, listen: false);
      await otherProvider.getProvinsi();
      setState(() {
        dataProvinsi = otherProvider.dataProvinsi;
      });
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final otherProvider = Provider.of<OtherProvider>(context, listen: false);
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dimana anda berada?',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 30.sp,
                ),
              ),
              Text(
                'Masukkan data lokasi',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Color(0xFF828282),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Provinsi',
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
                    'Provinsi',
                    style: TextStyle(
                      color: Colors.black12,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: idProvinsiSelected,
                  hint: const Text(
                    'Pilih provinsi',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                  items:
                      dataProvinsi == null
                          ? []
                          : dataProvinsi!.map<DropdownMenuItem<int>>((jenis) {
                            return DropdownMenuItem<int>(
                              value: jenis['id_provinsi'],
                              child: Text(jenis['nama_provinsi']),
                            );
                          }).toList(),
                  onChanged: (value) async {
                    showDialog(
                      context: context,
                      builder:
                          (context) =>
                              const Center(child: CircularProgressIndicator()),
                    );
                    await otherProvider.getKabupatenByProvinsi(value!);
                    setState(() {
                      idProvinsiSelected = value;
                      dataKabupaten = otherProvider.dataKabupatenByProvinsi;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),

              idProvinsiSelected != null
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        'Kabupaten',
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
                            'Kabupaten',
                            style: TextStyle(
                              color: Colors.black12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: idKabupatenSelected,
                          hint: const Text(
                            'Pilih kabupaten',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.black26,
                            ),
                          ),
                          items:
                              dataKabupaten == null
                                  ? []
                                  : dataKabupaten?.map<DropdownMenuItem<int>>((
                                    jenis,
                                  ) {
                                    return DropdownMenuItem<int>(
                                      value: jenis['id_kabupaten'],
                                      child: Text(jenis['nama_kabupaten']),
                                    );
                                  }).toList(),
                          onChanged: (value) async {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                            );
                            await otherProvider.getKecamatanByKabupaten(value!);
                            setState(() {
                              dataKecamatan =
                                  otherProvider.dataKecamatanByKabupaten;
                              idKabupatenSelected = value;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),

                      idKabupatenSelected != null
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kecamatan',
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
                                    'Kecamatan',
                                    style: TextStyle(
                                      color: Colors.black12,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  value: idKecamatanSelected,
                                  hint: const Text(
                                    'Pilih Kecamatan',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black26,
                                    ),
                                  ),
                                  items:
                                      dataKecamatan == null
                                          ? []
                                          : dataKecamatan
                                              ?.map<DropdownMenuItem<int>>((
                                                jenis,
                                              ) {
                                                return DropdownMenuItem<int>(
                                                  value: jenis['id_kecamatan'],
                                                  child: Text(
                                                    jenis['nama_kecamatan'],
                                                  ),
                                                );
                                              })
                                              .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      idKecamatanSelected = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                          : Container(),
                    ],
                  )
                  : Container(),

              SizedBox(height: 40.h),
              LongButton(
                text: 'Lanjutkan',
                color: '007B29',
                colorText: 'FFFFFF',
                onPressed: () {
                  if (idKecamatanSelected == null) {
                    Fluttertoast.showToast(
                      msg: "Data belum dipilih",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      '/registrasiPageDua',
                      arguments: {
                        'email': args['email'],
                        'telepon': args['telepon'],
                        'namaLengkap': args['namaLengkap'],
                        'idKecamatan': idKecamatanSelected,
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
