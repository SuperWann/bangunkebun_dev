import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bangunkebun_dev/models/KontenPengguna.dart';
import 'package:bangunkebun_dev/providers/contentProvider.dart';
import 'package:bangunkebun_dev/widgets/youtubeVideo.dart';

class ListContentPage extends StatefulWidget {
  const ListContentPage({super.key});

  @override
  State<ListContentPage> createState() => _ListContentPageState();
}

class _ListContentPageState extends State<ListContentPage> {
  final ContentProvider _contentProvider = ContentProvider();

  List<KontenPengguna> dataArticles = [];
  List<KontenPengguna> dataVideos = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _contentProvider.getDataArticles();
      await _contentProvider.getDataVideos();
      setState(() {
        dataArticles = _contentProvider.dataArticles!;
        dataVideos = _contentProvider.dataVideos!;
      });

      print(dataArticles);
    });
  }

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays >= 1) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} menit yang lalu';
    } else {
      return 'baru saja';
    }
  }

  List<Widget> tabBar = [Text('Artikel'), Text('Video')];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBar.length,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            bottom: TabBar(
              tabs: tabBar,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 4,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF007B29),
              ),
              unselectedLabelStyle: TextStyle(
                color: Color(0xFF828282),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
              labelColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20),
              labelPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              TabBarView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 100, top: 10),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await _contentProvider.getDataArticles();
                        setState(() {
                          dataArticles = _contentProvider.dataArticles ?? [];
                        });
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        itemCount: dataArticles.length,
                        itemBuilder: (context, index) {
                          final article = dataArticles[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detailContentPage',
                                arguments: article,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 12.sp,
                                                backgroundImage:
                                                    Image.network(
                                                      article.fotoProfile!,
                                                    ).image,
                                              ),
                                              SizedBox(width: 5.sp),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    article.username!,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                  Text(
                                                    article.email!,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF828282),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            article.judul!,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Montserrat',
                                            ),
                                            maxLines: 2,
                                          ),
                                          Text(
                                            article.isiDeskripsi!,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF828282),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 7,
                                            textAlign: TextAlign.justify,
                                          ),
                                          Text(
                                            timeAgo(
                                              DateTime.parse(
                                                article.timestamp!
                                                    .toIso8601String(),
                                              ),
                                            ),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      flex: 3,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          article.gambarVideo!,
                                          height: double.infinity,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await _contentProvider.getDataVideos();
                            setState(() {
                              dataVideos = _contentProvider.dataVideos!;
                            });
                          },
                          child: ListView.builder(
                            itemCount: dataVideos.length,
                            itemBuilder: (context, index) {
                              final video = dataVideos[index];
                              return VideoWithDescription(
                                videoUrl: video.gambarVideo!,
                                title: video.judul!,
                                description: video.isiDeskripsi!,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.16,
                right: 10.w,
                child: FloatingActionButton(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.transparent),
                  ),
                  elevation: 2,
                  heroTag: 'addarticlebutton',
                  backgroundColor: Color(0xFFF7AB0A),
                  onPressed: () {
                    Navigator.pushNamed(context, '/addArticlePage');
                  },
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
