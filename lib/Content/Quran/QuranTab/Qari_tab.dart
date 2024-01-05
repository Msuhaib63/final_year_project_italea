import 'package:flutter/material.dart';

import '../../../Module/Quran/Qari.dart';
import '../../../Service/api_service.dart';
import '../../../Widget/Quran_Widget/CustomTIle/Qari_customtile.dart';
import '../AudioSurahScreen.dart';

class QariTab extends StatefulWidget {
  const QariTab({super.key});

  @override
  State<QariTab> createState() => _QariTabState();
}

class _QariTabState extends State<QariTab> {

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 12,right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Expanded(
                  child: FutureBuilder(
                    future: _apiService.getQariList(),
                    builder: (BuildContext context, AsyncSnapshot<List<Qari>> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("Qari\'s data not found"));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return QariCustomTile(qari: snapshot.data![index],
                                ontap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => AudioSurahScreen(qari: snapshot.data![index]))
                                  );
                                });
                          }
                      );
                    },
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}