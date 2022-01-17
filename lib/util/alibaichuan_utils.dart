
class AlibaiChuanUtils {
  
  AlibaiChuanUtils._();
  factory AlibaiChuanUtils()=>AlibaiChuanUtils._();

  // oc字典转map
  Map<String,dynamic> covertToMap(dynamic result){
    if(result is Map<Object?,Object?>){
     return Map<String,dynamic>.from(result);
    }
    return {'errorMessage': result};
  }


}


extension MapExt on Map<String,dynamic> {
  bool get isSuccess => !containsKey('errorMessage');
  String get errorMessage => this['errorMessage'] ??'unkown error';
}