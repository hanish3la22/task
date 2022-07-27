class Weight{
  String? id;
  double? weight;
  String? timeStamp;

  Weight({this.id,this.timeStamp,this.weight});


fromJson(var json){
  return Weight(
    id: json['id'],
    timeStamp: json['timeStamp'],
    weight: json['weight']
  );
}


}