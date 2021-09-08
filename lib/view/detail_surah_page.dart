import 'package:flutter/material.dart';
import 'package:quran/model/spesific_surah.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/utils/color.dart';
import 'package:quran/utils/text_style.dart';

class DetailSurahPage extends StatelessWidget {
  final int number;
  final String name;

  DetailSurahPage({Key? key, required this.number, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            name,
            style: AppTextStyle.appBarStyle,
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey),
        ),
        body: Container(
          child: FutureBuilder<SpesificSurah?>(
            future: ApiService.getSpesificSurah(number),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var surah = snapshot.data;
                return ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColor.secondaryColor,
                            AppColor.thirdColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            surah!.nameIndo,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          Text(
                            surah.translation,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          Divider(
                            height: 40,
                            thickness: 0.6,
                            indent: 50,
                            endIndent: 50,
                            color: Colors.white,
                          ),
                          Text(
                            '${surah.revelation.toUpperCase()} - ${surah.numberOfVerses} AYAT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          if (number != 1) SizedBox(height: 10),
                          Text(surah.preBismillah,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    )
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
