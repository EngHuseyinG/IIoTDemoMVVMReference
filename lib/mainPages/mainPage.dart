import 'dart:async';
import 'package:demo/cloudservices/database.dart';
import 'package:demo/widgets/drawerMenu.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Map<dynamic, dynamic> _kullanicibilgileriMap = <dynamic, dynamic>{};
   List<dynamic> _kullanicibilgileriList = [];
  bool _loadingIcon = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      didChangeDependencies();
    } );
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
              '/anasayfa', (
              Route<dynamic> route) => false),
        child: const Column(
          children: [
            Text('BODY'),
          ],
        ),
        );
  }

  Widget _pcBody() {
    return const Column(
      children: [
        Text('BODY'),
      ],
    );

  }


  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<database>(context);
   if(_loadingIcon == true) {
      return const Center(
        child:
        CircularProgressIndicator(backgroundColor: Colors.white, color: Colors.blue,),
      );
    }
    else {
     return Scaffold(
       resizeToAvoidBottomInset: false,
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
             Text(userViewModel.user[0].name.toString(), style: TextStyle(color: Colors.white),),
             Text(userViewModel.isLoading.toString(), style: TextStyle(color: Colors.white),),
             /* Padding(padding: const EdgeInsets.all(10),
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
                ),*/
           ],
         ),
         leading: Builder(builder: (context){
           return IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu_open , color: Colors.white, size: 35,),);
         }),
       ),
       body: MediaQuery.of(context).size.width < 800 ? _mobileBody() : _pcBody(),
     );
    }
  }
}
