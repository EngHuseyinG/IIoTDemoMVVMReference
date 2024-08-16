import 'dart:async';
import 'package:demo/widgets/drawerMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class izlenebilirlikMainPage extends StatefulWidget {
  const izlenebilirlikMainPage({super.key});

  @override
  State<izlenebilirlikMainPage> createState() => _izlenebilirlikMainPageState();
}

class _izlenebilirlikMainPageState extends State<izlenebilirlikMainPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final ScrollController _controller = ScrollController();
  Map<dynamic, dynamic> _kullanicibilgileriMap = <dynamic, dynamic>{};
  final List<dynamic> _kullanicibilgileriList = [];
  bool _loadingIcon = true;
  var _currentUserUUID = '';
  var _currentUserName = '';
  var _currentUserLastName = '';
  var _currentUserPassword = '';
  var _currentUserQuest = '';
  var _currentUserCompany = '';
  var _currentUserCity = '';
  var _currentUserEmail = '';
  var _currentUserLicenceEndTimeDay = '';
  var _currentUserLicenceEndTimeMonth = '';
  var _currentUserLicenceEndTimeYear = '';




  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    Future.delayed(const Duration(milliseconds: 100), () {
      didChangeDependencies();
    } );


  }


  Future _getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.popAndPushNamed(context, '/giris');
    }
    else {
      setState(() {
        _currentUserEmail = user.email.toString();
        _getUserInfos();
      });
    }
  }

  Future _getUserInfos() async {
    DatabaseReference dbrefo = FirebaseDatabase.instance.ref("users");
    final event = await dbrefo
        .orderByChild("email")
        .equalTo(_currentUserEmail.toString())
        .once(DatabaseEventType.value);

    if (event.snapshot.exists) {
      setState(() {
        _kullanicibilgileriList.clear();
        _kullanicibilgileriMap = event.snapshot.value as dynamic;
        _kullanicibilgileriList.addAll(_kullanicibilgileriMap.values.toList());
        _currentUserUUID = _kullanicibilgileriList[0]['uuid'].toString();
        _currentUserName = _kullanicibilgileriList[0]['name'].toString();
        _currentUserLastName = _kullanicibilgileriList[0]['lastname'].toString();
        _currentUserPassword = _kullanicibilgileriList[0]['password'].toString();
        _currentUserQuest = _kullanicibilgileriList[0]['quest'].toString();
        _currentUserCompany = _kullanicibilgileriList[0]['company'].toString();
        _currentUserCity = _kullanicibilgileriList[0]['city'].toString();
        _currentUserLicenceEndTimeDay = _kullanicibilgileriList[0]['licenceendtimeday'].toString();
        _currentUserLicenceEndTimeMonth = _kullanicibilgileriList[0]['licenceendtimemonth'].toString();
        _currentUserLicenceEndTimeYear = _kullanicibilgileriList[0]['licenceendtimeyear'].toString();
        _loadingIcon = false;
      });
    }
    else {
      Navigator.popAndPushNamed(context, '/loginPage');
    }

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage("assets/images/logos/teleportal40_normal2_white.png"), context);
  }

  Widget _mobileBody() {
      return RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        strokeWidth: 4.0,
        onRefresh: () =>
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/izlenebilirlik/anasayfa', (
                Route<dynamic> route) => false),
        child: ListView(
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 30,),
            const Center(child: Text('İŞLETMELER', style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20),),),
            const SizedBox(height: 30,),
            Container(
              height: 50,
              width: 500,
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/izlenebilirlik/montaj/uretim', (
                        Route<dynamic> route) => false),
                child: const Text('Montaj', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),),),
            ),
            const SizedBox(height: 30,),
            Container(
              height: 50,
              width: 500,
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: const Text('Boyahane', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),),),
            ),
            const SizedBox(height: 30,),
            Container(
              height: 50,
              width: 500,
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {},
                child: const Text('Plastikhane', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),),),
            ),
            const SizedBox(height: 30,),
          ],
        ),
      );
  }

  Widget _pcBody() {
    return ListView(
      shrinkWrap: false,
      scrollDirection: Axis.vertical,
      children: [
        const SizedBox(height: 30,),
        const Center(child: Text('İŞLETMELER', style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20),),),
        const SizedBox(height: 30,),
        Container(
          height: 50,
          width: 500,
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(250, 50),
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () =>
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/izlenebilirlik/montaj/uretim', (
                    Route<dynamic> route) => false),
            child: const Text('Montaj', style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18),),),
        ),
        const SizedBox(height: 30,),
        Container(
          height: 50,
          width: 500,
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(250, 50),
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {},
            child: const Text('Boyahane', style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18),),),
        ),
        const SizedBox(height: 30,),
        Container(
          height: 50,
          width: 500,
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(250, 50),
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {},
            child: const Text('Plastikhane', style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18),),),
        ),
        const SizedBox(height: 30,),
      ],
    );

  }


  @override
  Widget build(BuildContext context) {
    if(_loadingIcon == true) {
      return const Center(
        child:
            CircularProgressIndicator(backgroundColor: Colors.white, color: Colors.blue,),
      );
    }
    else {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          primary: true,
          drawer: drawerMenu(),
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
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 25,
                    child: Image.asset('assets/images/logos/teleportal40_layout2_white.png',
                      filterQuality: FilterQuality.low,
                      fit:BoxFit.fitHeight,
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MediaQuery.of(context).size.width > 800 ? Text('${_kullanicibilgileriList[0]['company']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 12,),) : const SizedBox(width: 10 ,),
                      const SizedBox(width: 10 ,),
                      InkWell(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text('${_kullanicibilgileriList[0]['name'].toString()[0]}${_kullanicibilgileriList[0]['lastname'].toString()[0]}',style: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF141293),),),
                        ),
                        onTap: () {
                          // popUpKey.currentState?.showButtonMenu();
                          showMenu(
                              context: context,
                              position: const RelativeRect.fromLTRB(200, 75, 0, 0),
                              items: [
                                PopupMenuItem(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            minRadius: 25,
                                            maxRadius: 25,
                                            backgroundColor: Colors.white,
                                            child: Text('${_kullanicibilgileriList[0]['name'].toString()[0]}${_kullanicibilgileriList[0]['lastname'].toString()[0]}',style: const TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF141293),),),
                                          ),
                                          const SizedBox(width: 10,),
                                          Text('${_kullanicibilgileriList[0]['name'].toString()} ${_kullanicibilgileriList[0]['lastname'].toString()}'),
                                        ],
                                      ),
                                      const SizedBox(height: 25,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.location_city,color: Colors.black,size: 25,),
                                          const SizedBox(width: 10,),
                                          Text(_kullanicibilgileriList[0]['company'].toString()),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.mail,color: Colors.black,size: 25,),
                                          const SizedBox(width: 10,),
                                          Text(_kullanicibilgileriList[0]['email'].toString()),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.account_box_rounded,color: Colors.black,size: 25,),
                                          const SizedBox(width: 10,),
                                          Text(_kullanicibilgileriList[0]['quest'].toString()),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.location_on,color: Colors.black,size: 25,),
                                          const SizedBox(width: 10,),
                                          Text(_kullanicibilgileriList[0]['city'].toString()),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ]
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            leading: Builder(builder: (context){
              return IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu_open , color: Colors.white, size: 35,),);
            }),
          ),
          body: MediaQuery.of(context).size.width < 800 ? _mobileBody() : _pcBody() ,
      );
    }
  }
}
