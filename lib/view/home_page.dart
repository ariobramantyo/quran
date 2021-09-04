import 'package:flutter/material.dart';
import 'package:quran/model/list_surah.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';

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
                // color: Colors.red,
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
              FutureBuilder<List<ListSurah>>(
                future: ApiService.getListSurah(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var surah = snapshot.data![index];
                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 45,
                                  width: 45,
                                  // color: Colors.blueGrey,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/number_shape.png',
                                        color: AppColor.primaryColor
                                            .withOpacity(0.7),
                                      ),
                                      Text(
                                        // surah.number.toString(),
                                        '100',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                                title: Text(
                                  surah.nameIndo,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                    '${surah.revelation.toUpperCase()} - ${surah.numberOfVerses.toString()} AYAT'),
                                trailing: Text(
                                  surah.nameArab,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColor.primaryColor,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              if (index != snapshot.data!.length)
                                Divider(
                                  height: 8,
                                  thickness: 0.5,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              Container(
                height: 100,
                width: 100,
                child: Icon(Icons.home),
              )
            ],
          ),
        ),
      ),
    );
  }
}
