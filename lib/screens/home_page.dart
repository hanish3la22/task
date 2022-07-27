import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/helper/shared_preferences.dart';
import 'package:task/model/weight_model.dart';
import 'package:task/screens/add_new_weight.dart';
import 'package:task/services/firestore_services.dart';

class MyHomePage extends StatefulWidget {
   MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String? uid ;


@override
  void initState() {
    SharedPreferencesHelper.getUserId().then((value) => uid = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/register');
          },
          child: Icon(Icons.signpost_outlined,color: Colors.black,size: 30,),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Weight",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> AddWeight(edit: false)));
              },
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Services.getAllWeights(uid),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
    return Center(child: Text('Something went wrong'));
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: Text("Loading"));
    }
    var data = snapshot.data!.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      return Weight(weight: data['weight'],timeStamp: data['timeStamp'],id: document.id);}).toList();

    data.sort((a,b) {
      var adate = DateTime.parse(a.timeStamp!);
      var bdate = DateTime.parse(b.timeStamp!);
      return bdate.compareTo(adate);
    });

    return   ListView.builder(
      key: UniqueKey(),
    itemCount: data.length,
    itemBuilder:(cntx,index){
      return Padding(
          key: ValueKey(index),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: ListTile(title: Text(data[index].weight.toString(),style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,),),
          subtitle: Text(data[index].timeStamp!,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,), ),
          leading:  GestureDetector(child:  Icon(Icons.edit,size: 20,color: Colors.black,),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=> AddWeight(edit: true,weight: data[index],)));
            },),
          trailing: GestureDetector(child: Icon(Icons.remove,size: 20,color: Colors.black,),onTap: ()async{
            await Services.deleteUserWeight(data[index].id!);
          },),
        ),
      );
    }
    );


      }
          ),
          
        ),
      ),
    );
  }
}
