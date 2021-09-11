import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/model/hadist.dart';
import 'package:quran/services/api_service.dart';
import 'package:quran/utils/text_style.dart';
import 'package:quran/view/detail_hadist_page.dart';

class HadistTab extends StatelessWidget {
  const HadistTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HadistBook>>(
      future: ApiService.getHadistsBook(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var hadist = snapshot.data![index];
              return ListTile(
                onTap: () => Get.to(() => DetailHadistPage(
                      id: hadist.id,
                      name: hadist.name,
                      initialScrollIndex: 0,
                    )),
                title: Text(hadist.name, style: AppTextStyle.titleListTile),
                subtitle: Text('Kumpulan hadist ${hadist.name}'),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
