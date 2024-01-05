import 'package:flutter/material.dart';

import '../../Constant/color.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1)
        ),
        child: Icon(icon, color: hexStringToColor("03045E"), size: 20,),
      ),
      title: Text(title, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: hexStringToColor("03045E"),) ,),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.withOpacity(0.1)
        ),
        child: const Icon(Icons.arrow_right_rounded, size: 40,),
      ),
    );
  }
}
