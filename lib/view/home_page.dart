import 'package:flutter/material.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/widgets/hadist_tab.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Quran App',
          style: AppTextStyle.appBarStyle,
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
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
                          'Al-Fatihah',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Ayat No: 1',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xffddc6f7),
                              fontWeight: FontWeight.w500),
                        ),
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
