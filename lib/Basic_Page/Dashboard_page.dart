import 'package:final_year_project_italea/Widget/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../Constant/color.dart';
import '../Content/Chat/Chat_page.dart';
import '../Widget/SideDrawer.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(context, 'Murabbi Section', Icons.info),
      //drawer: SideDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              children: [
                //Text("Ustaz", ),
                Expanded(
                  child: _builderUserList(),
                ),
                /*Text("User", ),
                Expanded(
                  child: _builderUserList(),
                ),*/
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text("v1.0 Made By SUHAIB" , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.grey),),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Widget to build the list of users
  Widget _builderUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {

          // Check for errors
          if (snapshot.hasError){
            return const Text('Error');
          }

          // Check if data is still loading
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text('loading...');
          }

          // Build the list view with user items
          return ListView(
            children: [
              ...snapshot.data!.docs
                  .map<Widget>((doc) => _builderUserListItem(doc))
                  .toList()
            ],
          );
        }
    );
  }

  // Widget to build each user item
  Widget _builderUserListItem(DocumentSnapshot document){
    // Extract user data from the document
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Check if the current user is not the same as the user in the list
    if(FirebaseAuth.instance.currentUser!.email != data['email']) {
      return Column(
        children: [
          Card(
            elevation: 5,
            shadowColor: Colors.grey,
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white,
            child: ListTile(
              contentPadding: EdgeInsets.all(16), // Add padding to the content inside ListTile
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(data['photoUrl']),
              ),
              title: Text(data['username'], style: TextStyle(color: hexStringToColor("03045E"), fontWeight: FontWeight.bold,fontSize: 20),),
              subtitle: Text(data['email'],  style: TextStyle(color: hexStringToColor("A19CC5"), fontSize: 15),),
              onTap: () {
                // Navigate to the chat page with the selected user details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receiverUserEmail: data['email'],
                      receiverUserID: data['userID'],
                    ),
                  ),
                );
              },
            ),
          ),
        ],

      );
    } else {
      return Container();
    }
  }
}