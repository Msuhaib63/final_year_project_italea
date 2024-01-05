import 'package:flutter/material.dart';

import '../../../Constant/color.dart';
import '../../../Service/api_service.dart';
import '../JuzScreen.dart';

class JuzTab extends StatefulWidget {
  const JuzTab({super.key});

  @override
  State<JuzTab> createState() => _JuzTabState();
}

class _JuzTabState extends State<JuzTab> {
  @override
  Widget build(BuildContext context) {

    final ApiService _apiService = ApiService();

    return SafeArea(
      child: Scaffold(
          body: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(8),

              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 30,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        setState((){
                          ApiService.juzIndex = (index + 1);
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> JuzScreen(index: (index+1))));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: colorBackground9(context),
                        child: Center(
                          child: Text('${index+1}', style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    );
                  }),
            ),
          )
      ),
    );
  }
}