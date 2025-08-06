import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:bangunkebun_dev/models/KontenPengguna.dart';

class DetailContentPage extends StatefulWidget {
  static const routeName = '/detailContentPage';
  const DetailContentPage({super.key});

  @override
  State<DetailContentPage> createState() => _DetailContentPageState();
}

class _DetailContentPageState extends State<DetailContentPage> {
  String timezone(DateTime date) {
    String formattedDate = DateFormat('d MMMM y', 'id_ID').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final KontenPengguna data =
        ModalRoute.of(context)?.settings.arguments as KontenPengguna;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(scrolledUnderElevation: 0, backgroundColor: Colors.white),
      body: Container(
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 15.sp,
                    backgroundImage: Image.network(data.fotoProfile!).image,
                  ),
                  SizedBox(width: 5.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.username!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        data.email!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          color: Color(0xFF828282),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                data.judul!,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    data.gambarVideo!,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                timezone(data.timestamp!),
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF828282),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data.isiDeskripsi!,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
