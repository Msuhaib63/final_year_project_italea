import 'package:flutter/material.dart';

import '../../Constant/color.dart';
import '../../Module/Quran/Juz.dart';
import '../../Service/api_service.dart';
import '../../Widget/Quran_Widget/CustomTIle/Juz_customtile.dart';

class JuzScreen extends StatefulWidget {

  final int index;

  const JuzScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<JuzScreen> createState() => _JuzScreenState();
}

class _JuzScreenState extends State<JuzScreen> {
  //static const String id = 'juz_screen';

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: background,
          appBar: _appBar(context: context, index: widget.index),
          body: FutureBuilder<JuzModel>(
            future: _apiService.getJuzz(ApiService.juzIndex!),
            builder: (context, AsyncSnapshot<JuzModel> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              } else if (snapshot.hasData){
                print("${snapshot.data!.juzAyahs.length} length");
                return ListView.builder(
                  itemCount: snapshot.data!.juzAyahs.length,
                    itemBuilder: (context, index) {
                      return JuzCustomTile(
                        list: snapshot.data!.juzAyahs, index: index
                      );
                    }
                );
              } else {
                return Center(child: Text('Data not found'));
              }
            },
          ),
        )
    );
  }

  AppBar _appBar({required BuildContext context, required int index}) =>
      AppBar(
        flexibleSpace: Container(
            decoration: colorBackground1(context)
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: 75,
        title: Row(children: [
          IconButton(
            onPressed: (() => Navigator.of(context).pop()),
            icon: Icon(Icons.arrow_back),color: Colors.white,),
          const SizedBox(
            width: 24,
          ),
          Text(
            "Juz ${index}",
            style:
            TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ]),
      );

}
