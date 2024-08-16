import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class cihazYonetimiMainPage extends StatefulWidget {
  const cihazYonetimiMainPage({super.key});

  @override
  State<cihazYonetimiMainPage> createState() => _cihazYonetimiMainPageState();
}

class _cihazYonetimiMainPageState extends State<cihazYonetimiMainPage> {
  Map<dynamic, dynamic> _kullanicibilgileriMap = <dynamic, dynamic>{};
  List<dynamic> _kullanicibilgileriList = [];
  var _currentUserUUID = '';
  var _currentUsername = '';
  var _currentUserpassword = '';
  var _currentUserquest = '';
  var _currentUsercompany = '';
  var _currentUsercity = '';
  var _currentUseremail = '';
  var _currentUserLicenceEndTimeDay = '';
  var _currentUserLicenceEndTimeMonth = '';
  var _currentUserLicenceEndTimeYear = '';

  @override
  void initState() {
    super.initState();
    _getCurrentUser();

  }

  Future _getCurrentUser() async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.popAndPushNamed(context, '/loginPage');
    }
    else {
      setState(() {
        _currentUseremail = user.email.toString();
        _getUserInfos();
      });

    }
  }

  Future _getUserInfos() async {
    DatabaseReference dbrefo = FirebaseDatabase.instance.ref("users");
    final event = await dbrefo
        .orderByChild("email")
        .equalTo(_currentUseremail.toString())
        .once(DatabaseEventType.value);

    if (event.snapshot.exists) {
      setState(() {
        _kullanicibilgileriList.clear();
        _kullanicibilgileriMap = event.snapshot.value as dynamic;
        _kullanicibilgileriList.addAll(_kullanicibilgileriMap.values.toList());
        _currentUserUUID = _kullanicibilgileriList[0]['uuid'].toString();
        _currentUsername = _kullanicibilgileriList[0]['name'].toString();
        _currentUserpassword = _kullanicibilgileriList[0]['password'].toString();
        _currentUserquest = _kullanicibilgileriList[0]['quest'].toString();
        _currentUsercompany = _kullanicibilgileriList[0]['company'].toString();
        _currentUsercity = _kullanicibilgileriList[0]['city'].toString();
        _currentUserLicenceEndTimeDay = _kullanicibilgileriList[0]['licenceendtimeday'].toString();
        _currentUserLicenceEndTimeMonth = _kullanicibilgileriList[0]['licenceendtimemonth'].toString();
        _currentUserLicenceEndTimeYear = _kullanicibilgileriList[0]['licenceendtimeyear'].toString();

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 250,
        backgroundColor: Colors.black,
        elevation: 5,
        surfaceTintColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DrawerHeader(child: Image.asset('assets/images/logos/Mirage2.png'),),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, '/mainPage'),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.home_outlined,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Anasayfa',style: TextStyle(color: Colors.white,fontSize: 12,),),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, '/uretim/main'),
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.precision_manufacturing,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Üretim',style: TextStyle(color: Colors.white,fontSize: 12,),),
                    ],
                  ),
                ),


                ListTile(
                  onTap: () => Navigator.pushNamed(context, '/enerji/main'),
                  title:   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.energy_savings_leaf_outlined,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Enerji',style: TextStyle(color: Colors.white,fontSize: 12,),),
                    ],
                  ),




                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, '/sensor/main'),
                  title:   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.earbuds,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Sensörler',style: TextStyle(color: Colors.white,fontSize: 12,),),
                    ],
                  ),
                ),

                ListTile(
                  tileColor: Colors.white,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.device_hub,color: Colors.black,),
                      SizedBox(width: 10,),
                      Text('Cihaz Yönetimi',style: TextStyle(color: Colors.black,fontSize: 12,),),
                    ],
                  ),
                ),

                ListTile(
                  title:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Hakkında',style: TextStyle(color: Colors.white,fontSize: 12,),),
                    ],
                  ),
                ),
                SizedBox(height: 75,),
                Text('IIoT Demo v1.0',style: TextStyle(fontSize: 12,color: Colors.white),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.white,),),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 75,
        primary: true,
        titleSpacing: 0.0,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 45,
                width: 175,
                child: Image.asset('assets/images/logos/logo_layout_white.png',
                  fit:BoxFit.fill,),
              ),
            ),

            Padding(padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MediaQuery.of(context).size.width > 750 ? Row(
                    children: [
                      Icon(Icons.call_to_action_outlined,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('KAYALAR PRES DÖKÜM',style: TextStyle(color: Colors.white,fontSize: 15,),),
                    ],
                  ) : SizedBox(width: 5,),
                  SizedBox(width: 40,),
                  Icon(Icons.settings,color: Colors.white,),
                  SizedBox(width: 10,),
                  Icon(Icons.person,color: Colors.white,),
                ],
              ),
            ),
          ],
        ),
        leading: Builder(builder: (context){
          return IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: Icon(Icons.menu_open , color: Colors.white, size: 35,),);
        }),
      ),
    );
  }
}
