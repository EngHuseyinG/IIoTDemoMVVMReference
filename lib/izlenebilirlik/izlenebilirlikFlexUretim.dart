import 'dart:async';
import 'dart:html' as html;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class FlexUretim extends StatefulWidget {
  const FlexUretim({super.key});

  @override
  State<FlexUretim> createState() => _FlexUretimState();
}

class _FlexUretimState extends State<FlexUretim> {
  ScrollController _controller = ScrollController();
  Map<dynamic, dynamic> _kullanicibilgileriMap = <dynamic, dynamic>{};
  List<dynamic> _kullanicibilgileriList = [];
  bool _loadedCache = false;
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
  double x = 0.0;
  double y = 0.0;
  double xLastValue = 0.0;
  double yLastValue = 0.0;

  @override
  void initState() {
    super.initState();
   _getCurrentUser();
    Future.delayed(Duration(milliseconds: 100), () {
      didChangeDependencies();
    } );

/*    Timer.periodic(Duration(seconds:500),(timer) {
      if(x == xLastValue){
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushNamedAndRemoveUntil('/loginPage',  (Route<dynamic> route) => false);
      }
      else {
        setState(() {
          xLastValue = x;
          yLastValue = y;
        });
      }
    } );*/

  }

  void _updateLocation(PointerEvent details) {
    setState(() {

      x = details.position.dx;

      y = details.position.dy;
    });
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
          return IconButton(onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/izlenebilirlik/FlexMain',  (Route<dynamic> route) => false) , icon: Icon(Icons.arrow_back_ios , color: Colors.white, size: 35,),);
        }),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: ListView(
          children: [
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('${x.toStringAsFixed(2)}'),
                // Text('${y.toStringAsFixed(2)}'),
                // Text('${xLastValue.toStringAsFixed(2)}'),
                // Text('${yLastValue.toStringAsFixed(2)}'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Aktif',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () => html.window.open('/#/izlenebilirlik/FlexUretim/Detay', '_blank') ,
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-2.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS1',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Arızada',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS2',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Molada',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS3',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Bakımda',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS4',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('${x.toStringAsFixed(2)}'),
                // Text('${y.toStringAsFixed(2)}'),
                // Text('${xLastValue.toStringAsFixed(2)}'),
                // Text('${yLastValue.toStringAsFixed(2)}'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Aktif',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS5',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Arızada',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS6',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Molada',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS7',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Bakımda',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS8',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('${x.toStringAsFixed(2)}'),
                // Text('${y.toStringAsFixed(2)}'),
                // Text('${xLastValue.toStringAsFixed(2)}'),
                // Text('${yLastValue.toStringAsFixed(2)}'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Aktif',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS9',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Arızada',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS10',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Molada',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS11',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width:5,),
                        Text('Bakımda',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text('Bölüm : Flex',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Ürün : 7X89A',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Üretim : 30',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Sorumlu : Ahmet Akar',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Text('Yönetici : Ali Atakan',style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 5,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.info_outline,color: Colors.black,),
                            SizedBox(width: 10,),
                            Text('Detaylar',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/images/machines/machine-1.png',),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child:
                      Container(
                        height: 50,
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 30,),
                            Text('Makine : CNV1_PS12',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
