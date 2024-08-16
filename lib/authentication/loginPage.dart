import 'package:demo/cloudservices/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final TextEditingController _useremail = TextEditingController();
  final TextEditingController _userpassword = TextEditingController();
  var _passwordvisible = true;
  bool _loadingIcon = false;


  @override
  void initState() {
    super.initState();
     FirebaseAuth.instance.signOut();
  }

  Widget _mobileBody() {
   return  RefreshIndicator(
      key: _refreshIndicatorKey,
      color: Colors.white,
      backgroundColor: Colors.blue,
      strokeWidth: 4.0,
      onRefresh: () =>
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/giris', (
              Route<dynamic> route) => false),
      child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(25),
                  child:
                  Container(
                    height: 250,
                    width: 500,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/logos/teleportal40_normal2_blue.png',height: 250,width: 500,),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Container(
                    width: 500,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      minLines: 1,
                      controller: _useremail,
                      decoration: const InputDecoration(
                        border:OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 6),),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF141293),width: 5),),
                        prefixIcon: Icon(Icons.email,color: Color(0xFF141293),),
                        prefixIconColor: Colors.red,
                        hintText: 'E-mail',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Container(
                    width: 500,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: _passwordvisible,
                      controller: _userpassword,
                      decoration: InputDecoration(
                        border:const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 6),),
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF141293),width: 5),),
                        suffixIcon: IconButton(icon: _passwordvisible == true ? const Icon(Icons.visibility, color: Color(0xFF141293),) : const Icon(Icons.visibility_off, color: Color(0xFF141293),), onPressed: () { setState(() {
                          _passwordvisible = !_passwordvisible;
                        }); },),
                        prefixIcon: const Icon(Icons.lock, color: Color(0xFF141293),),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Container(
                    width: 500,
                    height: 50,
                    child: _loadingIcon == true ? const Center( child: CircularProgressIndicator(),) :
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF141293),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () async {
                        setState(() {
                          _loadingIcon = true ;
                        });
                        await Authentication(context: context, email: _useremail.text.toString(), password: _userpassword.text.toString()).signInValidations();
                        setState(() {
                          _loadingIcon = false ;
                        });
                        },
                      child:
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.login,color: Colors.white,),
                          Text('Giriş Yap', style: TextStyle(color: Colors.white),),
                          SizedBox(width: 5,),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(25),
                  child: Container(
                    width: 500,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Teleportal 4.0 Demo v1.0',),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]
      ),
    );
  }

  Widget _pcBody() {
    return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(25),
                child:
                Container(
                  height: 250,
                  width: 500,
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/logos/teleportal40_normal2_blue.png',height: 250,width: 500,),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Container(
                  width: 500,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    minLines: 1,
                    controller: _useremail,
                    decoration: const InputDecoration(
                      border:OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 6),),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF141293),width: 5),),
                      prefixIcon: Icon(Icons.email,color: Color(0xFF141293),),
                      prefixIconColor: Colors.red,
                      hintText: 'E-mail',
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Container(
                  width: 500,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: _passwordvisible,
                    controller: _userpassword,
                    decoration: InputDecoration(
                      border:const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 6),),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF141293),width: 5),),
                      suffixIcon: IconButton(icon: _passwordvisible == true ? const Icon(Icons.visibility, color: Color(0xFF141293),) : const Icon(Icons.visibility_off, color: Color(0xFF141293),), onPressed: () { setState(() {
                        _passwordvisible = !_passwordvisible;
                      }); },),
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF141293),),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: Container(
                  width: 500,
                  height: 50,
                  child: _loadingIcon == true ? const Center( child: CircularProgressIndicator(),) :
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF141293),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () async {
                      setState(() {
                        _loadingIcon = true ;
                      });
                      await Authentication(context: context, email: _useremail.text.toString(), password: _userpassword.text.toString()).signInValidations();
                      setState(() {
                        _loadingIcon = false ;
                      });
                    },
                    child:
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.login,color: Colors.white,),
                        Text('Giriş Yap', style: TextStyle(color: Colors.white),),
                        SizedBox(width: 5,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(25),
                child: Container(
                  width: 500,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Teleportal 4.0 Demo v1.0',),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      primary: true,
      body: MediaQuery.of(context).size.width < 800 ? _mobileBody() : _pcBody(),
    );
  }
}
