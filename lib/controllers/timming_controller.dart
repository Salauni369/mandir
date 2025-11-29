import 'package:get/get.dart';
class Timing { String title, start, end; Timing(this.title,this.start,this.end); }
class TimingController extends GetxController {
  var darshan = <Timing>[].obs;
  var aarti = <Timing>[].obs;
  @override void onInit(){ super.onInit(); darshan.assignAll([Timing("Morning Darshan","04:30 AM","01:00 PM"), Timing("Evening Darshan","04:00 PM","09:00 PM")]); aarti.assignAll([Timing("Morning Aarti","04:30 AM","05:15 AM")]); }
  void deleteDarshan(int i){ darshan.removeAt(i); }
  void deleteAarti(int i){ aarti.removeAt(i); }
}
