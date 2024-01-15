import 'package:final_year_project_italea/Content/Profile/Information.dart';
import 'package:final_year_project_italea/Content/Profile/Leaderboard.dart';
import 'package:final_year_project_italea/Service/FireStore_service.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmore/readmore.dart';

import '../Constant/color.dart';
//import '../Constant/icons.dart';
import '../Content/Profile/Setting.dart';

import '../Content/Profile/UpdateProfileScreen.dart';
import '../Module/Quran/AyatADay.dart';
import '../Service/api_service.dart';

import '../Sub_Page/Log_Register/Login_page.dart';

import '../Widget/Profile_Widget/Logout_button.dart';
import '../Widget/Profile_Widget/ProfileMenu.dart';
import '../Widget/Profile_Widget/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _image;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> LeadersList = [];

  late String username = "";
  late String rank = "";
  late Map<String, dynamic> userData;


  // Function to select image from the gallery
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    String downloadUrl = await FireStoreDB().uploadImageToFirebaseStorage(img);
    setState(() {
      _image = img;
      FireStoreDB().updatePhotoUrl(downloadUrl);
    });
  }

  final currentUser = FirebaseAuth.instance.currentUser!;

  final ApiService _apiService = ApiService();
  AyahADay? data;

  void getCurrentUserData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection("Users").doc(currentUser.uid).get();

    setState(() {
      // Assign fetched user data to the 'userData' variable
      userData = snapshot.data() ?? {};
      // Dapatkan dan tetapkan username dan rank dari userData
      username = userData['username'] ?? "";
      rank = userData['rank'] ?? "";
    });
  }

  void getRank() async {
    await FirebaseFirestore.instance.collection("Users").orderBy("point", descending: true).get().then((value) {
      setState(() {
        LeadersList = value.docs;
        int userIndex = LeadersList.indexWhere((element) => element.data()["username"] == username && element.data()["position"] == "user");

        if (userIndex != -1) {
          rank = (userIndex + 1).toString();

          userData['rank'] = rank;

          // Check if the position is 'user' before updating rank
          if (userData['position'] == "user") {
            FirebaseFirestore.instance.collection("Users").doc(currentUser.uid).update({'rank': rank});
          }
        } else {
          rank = "N/A";
        }
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserData();
    getRank();
  }

  @override
  Widget build(BuildContext context) {
    _apiService.getAyahADay().then((value) => data = value);
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);


    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,

      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.uid).snapshots(),
          builder: (context, snapshot){
            if (snapshot.hasData){
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder<AyahADay>(
                        future: _apiService.getAyahADay(),
                        builder: (context,snapshot){
                          switch(snapshot.connectionState){
                            case ConnectionState.none:
                              return const Icon(Icons.sync_problem);
                            case ConnectionState.waiting:
                            case ConnectionState.active:
                              return const CircularProgressIndicator();
                            case ConnectionState.none:
                            default:
                              return Column(
                                children: [
                                  // Section for user's profile picture and edit
                                  Container(

                                    padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
                                    width: double.infinity,

                                    decoration: colorBackground6(context),

                                    child: Column(
                                      mainAxisSize: MainAxisSize.min, // Set to min so that the column only takes the necessary space
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            SizedBox(
                                              width: 190,
                                              child: Text(
                                                userData['email'] ,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.settings,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) {
                                                    return const UpdateProfileScreen();
                                                  }),
                                                );
                                              }
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height*0.02),
                                        Stack(
                                            children:[
                                              _image != null ? Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: hexStringToColor("03045E"), // Specify the border color
                                                    width: 3, // Specify the border width
                                                  ),
                                                ),
                                                child: CircleAvatar(
                                                  radius: 60,
                                                  backgroundImage: MemoryImage(_image!),
                                                  backgroundColor: hexStringToColor("03045E"),
                                                ),
                                              ) : Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: hexStringToColor("03045E"), // Specify the border color
                                                    width: 3, // Specify the border width
                                                  ),
                                                ),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white70,
                                                  radius: 65,
                                                  backgroundImage: NetworkImage(userData['photoUrl']),
                                                ),
                                              ),
                                              Positioned(
                                                child: IconButton(
                                                  onPressed: selectImage,
                                                  icon: Icon(Icons.add_photo_alternate, color: hexStringToColor('A19CC5'),),
                                                ),
                                                bottom: -10,
                                                left: 80,
                                              )
                                            ]
                                        ),
                                        SizedBox(height: 15),

                                        // Displaying user's username
                                        Text(
                                          capitalize(userData['username']),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: hexStringToColor("03045E"),
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        ReadMoreText(
                                          "Bio: ${userData['bio']}",
                                          trimLines: 2,
                                          textAlign: TextAlign.justify,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: "Show more",
                                          trimExpandedText: "Show less",
                                          lessStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.greenAccent
                                          ),
                                          moreStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.greenAccent
                                          ),
                                          style: TextStyle(
                                              color: hexStringToColor("03045E"),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),


                                        //const SizedBox(height: 7),

                                        //button edit profile
/*
                                        SizedBox(
                                          width: 200,
                                          child: ElevatedButton(
                                            onPressed: () => Get.to(() => const UpdateProfileScreen()),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: hexStringToColor("03045E"), side: BorderSide.none, shape: const StadiumBorder()
                                            ),
                                            child: const Text('Edit Profile', style: TextStyle(fontSize: 18, color: Colors.white)
                                            ),
                                          ),
                                        ),
*/

                                        const SizedBox(height: 15),
                                        const Divider(),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text("${userData['point']}", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w300, color: hexStringToColor("03045E"),),),
                                                Text("Point", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: hexStringToColor("03045E"),),)
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("${userData['rank']}", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w300, color: hexStringToColor("03045E"),),),
                                                Text("Rank", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: hexStringToColor("03045E"),),)
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),

                                  ),
                                  const SizedBox(height: 15),

                                  /*const Text("Leaderboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: Text("#${index+1}", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                          title: Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor: Colors.white70,
                                                //radius: 60,
                                                backgroundImage: AssetImage(picProfilebase),
                                              ),
                                              const SizedBox(width: 10),
                                              SizedBox(width: 215, child: Text(userData['email'], style: const TextStyle(fontSize: 18),)),
                                            ],
                                          ),
                                          trailing: Text("${(20000/(index+1)).toString().substring(0,6)}", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                        );
                                      },
                                      separatorBuilder: (context, index) => const Divider(thickness: 1, indent: 10, endIndent: 10,),
                                      itemCount: 10,
                                      shrinkWrap: true,
                                    ),
                                  ),

                                  const SizedBox(height: 15),*/

                                  // Section for Ayah of the Day
                                  Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: hexStringToColor("03045E"),
                                          width: 3, // You can change the border width here
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(.3),
                                            blurRadius: 4.0,
                                            spreadRadius: .05,
                                          ), //BoxShadow
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Text("Ayat Quran Hari ini",
                                            style: TextStyle(color: hexStringToColor("03045E"),fontWeight: FontWeight.bold, fontSize: 16),),
                                          Divider(color: hexStringToColor("03045E"), thickness: 2,),
                                          Text(snapshot.data!.arText!,
                                            style: TextStyle(color: hexStringToColor("03045E"), fontSize: 16),
                                            textAlign: TextAlign.center,),
                                          Text(snapshot.data!.enTran!,
                                            style: TextStyle(color: hexStringToColor("03045E"), fontSize: 16),
                                            textAlign: TextAlign.center,),
                                          RichText(text: TextSpan(
                                              children: <InlineSpan>[
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("${
                                                      snapshot.data!.surNumber!
                                                          .toString()
                                                    } :",
                                                        style: TextStyle(fontSize: 14, color: hexStringToColor("03045E"))),
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(snapshot.data!.surEnName!,
                                                        style: TextStyle(fontSize: 14, color: hexStringToColor("03045E"))),
                                                  ),
                                                )
                                              ]
                                          ))
                                        ],
                                      )
                                  ),
                                  const SizedBox(height: 15),

                                  const Divider(),
                                  const SizedBox(height: 10),


                                  ProfileMenu(
                                    title: 'Leaderboard',
                                    icon: Icons.leaderboard,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return LeaderBoard(name: userData["username"], point: userData["point"], curRank: userData["rank"]);
                                        }),
                                      );
                                    },
                                  ),
                                  /*ProfileMenu(title: 'Progress', icon: Icons.bubble_chart, onTap:  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return Setting();
                                      }),
                                    );
                                  },),*/
                                  ProfileMenu(
                                    title: 'Setting',
                                    icon: Icons.settings,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return const UpdateProfileScreen();
                                        }),
                                      );
                                    },
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 10,),
                                  ProfileMenu(title: 'Information', icon: Icons.info, onTap:  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return const Information();
                                      }),
                                    );
                                  },),
                                  // Logout button
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: logouButton(context, () =>
                                        Navigator.of(context, rootNavigator: true)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return const LoginPage();
                                            },
                                          ),
                                              (_) => false,
                                        ),
                                    ),
                                  ),
                                  Text("v1.0 Made By SUHAIB" , style: TextStyle(fontWeight: FontWeight.bold , color: hexStringToColor('A19CC5')),),
                                  const SizedBox(height: 10),
                                ],
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if(snapshot.hasError){
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}