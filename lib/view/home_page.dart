import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:quran/controller/user_location_controller.dart';
import 'package:quran/model/salah_time.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/detail_surah_page.dart';
import 'package:quran/view/salah_schedule_page.dart';
import 'package:quran/view/search_page.dart';
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
  final locationController = Get.put(UserLocationController());

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

  DateTime convertTime(String time) {
    if (time != '-') {
      String date = DateTime.now().toString().substring(0, 10);
      return DateTime.parse('$date $time');
    }
    return DateTime.now();
  }

  String nextSalahTime(SalahTime salahTime) {
    if (DateTime.now().isBefore(convertTime(salahTime.fajr))) {
      return 'Subuh ${salahTime.fajr}';
    } else if (DateTime.now().isBefore(convertTime(salahTime.dhuhr))) {
      return 'Dzuhur ${salahTime.dhuhr}';
    } else if (DateTime.now().isBefore(convertTime(salahTime.asr))) {
      return 'Asar ${salahTime.asr}';
    } else if (DateTime.now().isBefore(convertTime(salahTime.maghrib))) {
      return 'Maghrib ${salahTime.maghrib}';
    } else if (DateTime.now().isAtSameMomentAs(convertTime(salahTime.isha)) ||
        DateTime.now().isAfter(convertTime(salahTime.isha))) {
      return 'Subuh ${salahTime.fajr}';
    } else {
      return 'Isya ${salahTime.isha}';
    }
  }

  var _todayHijri = HijriCalendar.now().toFormat('dd MMMM yyyy');
  var _today = DateFormat('d MMMM y').format(DateTime.now());

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
        actions: [
          IconButton(
              onPressed: () => Get.to(() => SearchPage()),
              icon: Icon(Icons.search))
        ],
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.secondaryColor, AppColor.thirdColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      GetBuilder<UserLocationController>(
                        builder: (controller) {
                          return controller.salahTime != null
                              ? Column(
                                  children: [
                                    Text(
                                      nextSalahTime(controller.salahTime!),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Jadwal solat selanjutnya',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                );
                        },
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white),
                          SizedBox(width: 5),
                          GetBuilder<UserLocationController>(
                            builder: (controller) {
                              return controller.currentAddress != null &&
                                      controller.currentPosition != null
                                  ? Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.currentAddress!.locality ??
                                              'Address',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          controller.currentAddress!
                                                  .subAdministrativeArea ??
                                              'Address',
                                          style: TextStyle(
                                              color: AppColor.subColor,
                                              fontSize: 18),
                                        ),
                                      ],
                                    )
                                  : Text('lokasi tidak aktif');
                            },
                          ),
                          IconButton(
                              onPressed: () =>
                                  locationController.determinePosition(),
                              icon: Icon(Icons.refresh, color: Colors.white))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _today,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                _todayHijri,
                                style: TextStyle(
                                    color: AppColor.subColor, fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () => Get.to(() => SalahSchedulePage()),
                          child: Container(
                            width: 140,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jadwal Sholat',
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
                      ),
                    ],
                  )),
            ),
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
                child: Column(
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
                          'Bacaan Terakhir',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getLastReadSurahName(),
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Ayat No: ' + getLastReadSurahVerse().toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffddc6f7),
                                  fontWeight: FontWeight.w500),
                            ),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
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
