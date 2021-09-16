import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/controller/slider_controller.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/search_page.dart';
import 'package:quran/view/widgets/hadist_tab.dart';
import 'package:quran/view/widgets/last_read_header.dart';
import 'package:quran/view/widgets/navigation_drawer.dart';
import 'package:quran/view/widgets/salah_time_header.dart';
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

  final _sliderController = Get.put(SliderController());
  final _headerItem = [LastReadHeader(), SalahTimeHeader()];

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
                height: 180,
                child: PageView.builder(
                  controller: _sliderController.pageController,
                  onPageChanged: (index) {
                    _sliderController.currentPage.value = index;
                  },
                  itemCount: _headerItem.length,
                  itemBuilder: (context, index) {
                    return _headerItem[index];
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(2, (int index) {
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 8,
                        width: 8,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:
                                (_sliderController.currentPage.value == index)
                                    ? AppColor.primaryColor
                                    : AppColor.thirdColor.withOpacity(0.5)));
                  }))),
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
