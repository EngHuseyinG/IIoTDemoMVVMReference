import 'package:demo/cloudservices/database.dart';
import 'package:demo/viewmodels/drawerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class drawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<drawerViewModel>(
      builder: (context, drawerviewModel, child) {
        return Drawer(
          backgroundColor: Colors.black,
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Image.asset('assets/images/logos/teleportal40_normal2_white.png'),
              ),
              Expanded(
                child: ListView.builder(
                itemCount: drawerviewModel.drawerItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(drawerviewModel.drawerItems[index].icon, color: index == drawerviewModel.selectedIndex ? Colors.black : Colors.white,),
                    title: Text(drawerviewModel.drawerItems[index].title, style: TextStyle(color: index == drawerviewModel.selectedIndex ? Colors.black : Colors.white,),),
                    tileColor: Colors.black,
                    selectedTileColor: Colors.white,
                    selected: index == drawerviewModel.selectedIndex,
                    selectedColor: Colors.white,
                    hoverColor: Colors.blue,

                    onTap: () {
                      drawerviewModel.selectItem(index);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, drawerviewModel.currentRoute);
                    },
                  );
                },
              ),),


              const Text('Teleportal 4.0 Demo v1.0', style: TextStyle(color: Colors.white,fontSize: 12),),
            ],
          ),
        );
      },
    );
  }
}
