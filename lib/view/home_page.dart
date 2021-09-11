import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/detail_surah_page.dart';
import 'package:quran/view/widgets/hadist_tab.dart';
import 'package:quran/view/widgets/navigation_drawer.dart';
import 'package:quran/view/widgets/surah_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String getLastReadSurahName() {
    final box = GetStorage();

    if (box.read('lastRead') != null) {
      var surahName = box.read('lastRead') as Map<String, dynamic>;
      print(surahName);

      return surahName['nameIndo'].toString();
    }

    return 'Al-Fatihah';
  }

  int getLastReadSurahVerse() {
    final box = GetStorage();

    if (box.read('lastRead') != null) {
      var surahName = box.read('lastRead') as Map<String, dynamic>;
      print(surahName);

      return surahName['numberInSurah'];
    }

    return 1;
  }

  int getLastReadSurahId() {
    final box = GetStorage();

    if (box.read('lastRead') != null) {
      var surahName = box.read('lastRead') as Map<String, dynamic>;
      print(surahName);

      return surahName['id'];
    }

    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Quran App',
          style: AppTextStyle.appBarStyle,
        ),
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // SliverToBoxAdapter(
            //   child: Container(
            //     height: 60,
            //     width: double.infinity,
            //     child: FutureBuilder<List<Verse>>(
            //       future: DatabaseHelper.instance.getVerse(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           return ListView.builder(
            //             itemCount: snapshot.data!.length,
            //             itemBuilder: (context, index) {
            //               var ayat = snapshot.data![index];
            //               return Text(ayat.textLatin);
            //             },
            //           );
            //         }
            //         return Text('list kosong');
            //       },
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: 150,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.secondaryColor, AppColor.thirdColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Last Read',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getLastReadSurahName(),
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Ayat No: ' + getLastReadSurahVerse().toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xffddc6f7),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () => Get.to(() => DetailSurahPage(
                              // surah: surah,
                              id: getLastReadSurahId(),
                              name: getLastReadSurahName(),
                              initialIndex: getLastReadSurahVerse(),
                            )),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lanjut baca',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  unselectedLabelColor: AppColor.subtitleColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: AppColor.primaryColor,
                  labelStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 4,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Surah',
                          )),
                    ),
                    Tab(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Hadist',
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TabBarView(
            controller: _tabController,
            children: [
              SurahTab(),
              HadistTab(),
            ],
          ),
        ),
      ),
    );
  }
}
