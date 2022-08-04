// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison, avoid_returning_null_for_void, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/Core/Constant/string.dart';
import '../../../../Logic/Modules/userData_model.dart';
import '../../../../Logic/Providers/sign_in_provider.dart';
import '../../../../Logic/Services/auth_services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Drawer/drawer.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class HomeDash extends StatefulWidget {
  const HomeDash({Key? key}) : super(key: key);

  @override
  State<HomeDash> createState() => _HomeDashState();
}

class _HomeDashState extends State<HomeDash> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService>(context);
    // User user = authService.getcurrentUser();
    // List<UserData> userDataList = [];
    // final userDataListRaw = Provider.of<List<UserData>?>(context);
    // userDataListRaw?.forEach((element) {
    //   if (user.uid == element.id) {
    //     userDataList.add(element);
    //   } else {
    //     return null;
    //   }
    // });
    final sp = context.watch<SignInProvider>();

    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good Morning';
      }
      if (hour < 17) {
        return 'Good Afternoon';
      }
      return 'Good Evening';
    }

    return Scaffold(
      backgroundColor: Colors.white30,
      drawer: const MyDrawer(),
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (() {}),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: WidgetCircularAnimator(
              innerColor: Colors.blue,
              singleRing: true,
              size: 55,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  backgroundImage: NetworkImage("${sp.imageUrl}"),
                  radius: 70,
                ),
              ),
            ),
          ),
        ),
        elevation: 0,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Image.asset(
                    "assets/images/menu.png",
                    height: 30,
                    width: 30,
                  ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Hello, ", style: TextStyle(fontSize: 25)),
                Text(
                  "${sp.name}!",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "${greeting()}, ",
                  style: const TextStyle(color: Colors.grey),
                ),
                const Text(
                  "Welcome back.",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, bedroomScreenRoute);
                      },
                      child: const RoomsListViewModel());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomsListViewModel extends StatelessWidget {
  const RoomsListViewModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      height: 190,
      child: Stack(children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/bedroommain.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 190,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.2), Colors.black12]),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Living room",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "4 Devices",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
