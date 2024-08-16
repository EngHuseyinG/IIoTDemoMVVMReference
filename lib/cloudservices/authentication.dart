import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class Authentication {

  BuildContext context;
  String email;
  String password;

  Authentication({Key? key,required this.context, required this.email, required this.password});


  signInValidations() async {
    if(email.isEmpty) {
      var snackBar = SnackBar(
        content: const Text('Email Girmediniz !',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        action: SnackBarAction(label: 'TAMAM', textColor: Colors.white , onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if(!email.contains('@') || !email.contains('.com') ) {
      var snackBar = SnackBar(
        content: const Text('Uygunsuz email formatı !',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        action: SnackBarAction(label: 'TAMAM', textColor: Colors.white , onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if(password.trim().isEmpty) {
      var snackBar = SnackBar(
        content: const Text('Şifre Girmediniz ! !',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        action: SnackBarAction(label: 'TAMAM', textColor: Colors.white , onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else if(password.length < 6) {
      var snackBar = SnackBar(
        content: const Text('Şifre en az 6 haneli olmalıdır !',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        action: SnackBarAction(label: 'TAMAM', textColor: Colors.white , onPressed: () {}),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else {
      Map<dynamic, dynamic> _kullanicibilgileriMap = <dynamic, dynamic>{};
      final List<dynamic> _kullanicibilgileriList = [];

      DatabaseReference dbrefu = FirebaseDatabase.instance.ref("users");
      final event = await dbrefu.orderByChild('email').equalTo(email).once(DatabaseEventType.value);

      if(event.snapshot.exists) {
          _kullanicibilgileriList.clear();
          _kullanicibilgileriMap = event.snapshot.value as dynamic;
          _kullanicibilgileriList.addAll(_kullanicibilgileriMap.values.toList());

          if(password != _kullanicibilgileriList[0]['password'].toString()) {
            var snackBar = SnackBar(
              content: const Text('Geçersiz Şifre !',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              action: SnackBarAction(label: 'TAMAM', textColor: Colors.white , onPressed: () {}),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          }
          else if(password == _kullanicibilgileriList[0]['password'].toString() && email == _kullanicibilgileriList[0]['email'].toString()) {

            await signIn();


            FirebaseAuth.instance
                .authStateChanges()
                .listen((User? user) async {
              if (user != null) {
                Navigator.pushReplacementNamed(context, '/anasayfa',);
              }
            });
          }
      }
      else {
        var snackBar = SnackBar(
          content: const Text('Kullanıcı bulunamadı !',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          action: SnackBarAction(label: 'TAMAM', textColor: Colors.white , onPressed: () {}),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

  }


  signIn() async {

    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );



  }


}