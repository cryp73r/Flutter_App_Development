import 'package:yts_mx/utils/utils.dart';

String getImageData(String name, String type) {
  // return baseUrlImageData + "name=$name&type=$type";
  return baseUrlImageData + "$name/$type.jpg";
}
