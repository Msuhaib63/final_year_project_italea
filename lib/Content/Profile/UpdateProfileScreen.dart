import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project_italea/Widget/SecNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../../Constant/color.dart';
import '../../Service/FireStore_service.dart';
import '../../Sub_Page/Log_Register/Login_page.dart';
import '../../Theme/theme_provider.dart';

import '../../Constant/icons.dart';
import '../../Widget/Custom_backicon.dart';
import '../../Widget/Profile_Widget/Logout_button.dart';
import '../../Widget/Profile_Widget/utils.dart';
import 'package:final_year_project_italea/Widget/Profile_Widget/Text_box.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  Uint8List? _image;

  // Function to select image from the gallery
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    String downloadUrl = await FireStoreDB().uploadImageToFirebaseStorage(img);
    setState(() {
      _image = img;
      FireStoreDB().updatePhotoUrl(downloadUrl);
    });
  }

  // Function to get current user's data from Firestore
  void getCurrentUserData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection("Users").doc(currentUser.uid).get();

    setState(() {
      // Assign fetched username and rank to the widget's properties
      String newPhotoUrl = snapshot.data()?['photoUrl'] ?? "";
    });
  }

  final currentUser = FirebaseAuth.instance.currentUser!;

  final usersCollection = FirebaseFirestore.instance.collection("Users");

  // Function to edit user details (username, bio)
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(
            "Edit $field",
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Enter new $field",
                hintStyle: TextStyle(color: Colors.grey)
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),

          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                )
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(newValue),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                )
            )
          ],
        )
    );

    //update in firebase
    if(newValue.trim().length > 0){
      await usersCollection.doc(currentUser.uid).update({field : newValue});
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        /*floatingActionButton: FloatingActionButton(
          onPressed: (){
            Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
          },
        ),*/
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.uid).snapshots(),
          builder: (context, snapshot){
            if (snapshot.hasData){
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                    top: 40
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //TopBar
                      SecNavBar(title: "Setting"),
                      const SizedBox(height: 15),

                      SizedBox(height: MediaQuery.of(context).size.height*0.03),
                      // Section for user's profile picture
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
                                backgroundColor: hexStringToColor("03045E"),
                                radius: 65,
                                backgroundImage: NetworkImage(userData['photoUrl']),
                              ),
                            ),
                            Positioned(
                              child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(Icons.add_photo_alternate),
                              ),
                              bottom: -10,
                              left: 80,
                            )
                          ]
                      ),
                      const SizedBox(height: 10),
                      // Section for editing user details
                      Center(
                        child: Text(
                          'My Details',
                          style: TextStyle(
                              color: hexStringToColor("03045E"),
                              fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // TextBox for username
                      TextBox(
                        text: userData['username'],
                        sectionName: 'Username',
                        onPressed: () => editField('username'),
                      ),
                      const SizedBox(height: 15),

                      // TextBox for bio
                      TextBox(
                        text: userData['bio'],
                        sectionName: 'bio',
                        onPressed: () => editField('bio'),
                      ),
                      const SizedBox(height: 20),
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
                    ]
                ),
              );
            } else if(snapshot.hasError){
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
