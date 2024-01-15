import 'package:final_year_project_italea/Widget/QuranNavBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Constant/color.dart';
import '../Content/Chat/Chat_Screen.dart';
import '../Widget/ChatNavBar.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatNavBar(context, 'Murabbi Section', Icons.info),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "Senarai Murabbi",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // You can change the color to your liking
                  ),
                ),
                SizedBox(height: 20),
                // Change here to set a fixed height for the admin section
                Container(
                  height: 130, // Set the desired height
                  child: _builderUserList('admin'),
                ),
                /*Divider(
                  thickness: 2,
                  color: hexStringToColor("03045E"),
                  indent: 10,
                  endIndent: 10,
                ),*/
                SizedBox(height: 10),
                Text(
                  "Senarai User",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green, // You can change the color to your liking
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: _builderUserList('user'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "v1.0 Made By SUHAIB",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _builderUserList(String position) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }

        List<Widget> userList = [];

        snapshot.data!.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

          if (FirebaseAuth.instance.currentUser!.email != data['email'] &&
              data['position'] == position) {
            if (position == 'admin') {
              userList.add(_builderAdminUserListItem(doc));
            } else {
              userList.add(_builderUserListItem(doc));
            }
          }
        });

        return position == 'admin'
            ? ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: userList[index],
            );
          },
        )
            : ListView(
          children: userList,
        );
      },
    );
  }


  Widget _builderUserListItem(DocumentSnapshot document) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return Column(
      children: [
        Card(
          elevation: 5,
          shadowColor: Colors.grey,
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.white,
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(data['photoUrl']),
            ),
            title: Text(
              capitalize(data['username']),
              style: TextStyle(
                color: hexStringToColor("03045E"),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              data['email'],
              style: TextStyle(
                color: hexStringToColor("A19CC5"),
                fontSize: 15,
              ),
            ),
            trailing: Text(
              data['point'].toString(),
              style: TextStyle(
                color: hexStringToColor("A19CC5"),
                fontSize: 15,
              ),
            ),
            onTap: () {
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
  }

  Widget _builderAdminUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Define the maximum length for the username
    int maxUsernameLength = 12;
    String username = data["username"];

    // Trim the username if it exceeds the maximum length
    if (username.length > maxUsernameLength) {
      username = username.substring(0, maxUsernameLength) + "...";
    }

    // Function to capitalize the first letter of a string
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          // Navigate to the chat page for admin users
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: hexStringToColor("03045E"), // Set the border color
                  width: 2.0, // Set the border width
                ),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(data["photoUrl"]),
                radius: 35,
              ),
            ),
            SizedBox(height: 4),
            Text(
              capitalize(username),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: hexStringToColor("03045E")),
            ),
          ],
        ),
      ),
    );
  }



}

