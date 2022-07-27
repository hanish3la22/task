import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task/services/firestore_services.dart';

import '../model/weight_model.dart';


class AddWeight extends StatefulWidget {
  final bool? edit;
  final Weight? weight;
   AddWeight({Key? key,this.edit,this.weight}) : super(key: key);

  @override
  State<AddWeight> createState() => _AddWeightState();
}

class _AddWeightState extends State<AddWeight> {
  final _formKey = GlobalKey<FormState>();
String weight = '';


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child:Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    initialValue: widget.edit!? widget.weight!.weight.toString():"",
                    decoration: InputDecoration(
                      labelText: "Enter Your weight",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty ) {
                        return 'Please enter your weight';
                      }
                      else if(double.parse(value)==null){

                        return 'Please enter a valid value';
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState((){
                        weight = value;
                      });

                    },
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async{

                    if (_formKey.currentState!.validate()) {

                 widget.edit!? await Services.updateUserWeight(Weight(
                   weight: double.parse(weight),
                   timeStamp: widget.weight!.timeStamp,
                   id: widget.weight!.id
                 )) :await Services.createUserWeight({
                    'weight':double.parse(weight),
                    'timeStamp':DateTime.now().toString()
                  });
Navigator.of(context).pop();
                    }

                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
