class AppAssets{
  static const String arrow="assets/images/arrow.png";
  static const String back="assets/images/back.png";
  static const String back_q="assets/images/back_q.png";
  static const String front="assets/images/front.png";
  static const String front_q="assets/images/front_q.png";
  static const String flutter="assets/images/flutter.png";
  static const String flutter_q="assets/images/flutter_q.png";
  static const String devops="assets/images/devops.png";
  static const String dev_q="assets/images/dev_q.png";



  static String getQuestionImage(String name){
    if(name=="Flutter"){
      return flutter_q;
    }else if(name=="backend"){
      return back_q;
    }else if(name=="frontend"){
      return front_q;
    }else {
      return dev_q;
    }
  }
}