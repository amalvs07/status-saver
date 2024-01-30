import 'package:hive/hive.dart';

part 'storedetails.g.dart';

@HiveType(typeId: 1)
class Storedetails {
  Storedetails({this.lang="en", this.mode=false,this.whatsappfolderpath="/storage/emulated/0/Android/com.whatsapp/",this.selectedOrNot=0});

  @HiveField(0)
  String lang;

  @HiveField(1)
  bool mode;

  @HiveField(2)
  String whatsappfolderpath;

 @HiveField(3)
  int selectedOrNot;

  // @HiveField(2)
  // List<Storedetails> imagepath;

  //   @HiveField(3)
  // List<Storedetails> videopath;

  //   @HiveField(4)
  // List<Storedetails> savedImagepath;
  //     @HiveField(5)
  // List<Storedetails> savedVideopath;
}
