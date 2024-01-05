import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:final_year_project_italea/Constant/color.dart';
import 'package:final_year_project_italea/Module/Belajar/Category.dart';
import 'package:final_year_project_italea/Widget/Belajar_Widget/Search_field.dart';



class BelajarTopBar extends StatelessWidget {

  HijriCalendar _hijri = HijriCalendar.now();
  final String name;

  BelajarTopBar({
    Key? key,
    required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 185,
      width: double.infinity,

      decoration: colorBackground5(context),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Set to min so that the column only takes the necessary space
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum,\nApa Khabar ${name.length >= 12 ? "${name.substring(0, 12)}..." : name}",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white,),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 15),
          RichText(text:
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                    //style: Theme.of(context).textTheme.titleLarge,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${_hijri.hDay.toString()}  ${_hijri.longMonthName}  ${_hijri.hYear} AH",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                  )
                ),
              ]
            ),
          ),
          //const SearchTextField()
        ],
      ),
    );
  }
}

