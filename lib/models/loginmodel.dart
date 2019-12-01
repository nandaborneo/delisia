class LoginModel {
  String staffid;
  String userid;
  String usernama;

  LoginModel({this.staffid, this.userid, this.usernama});

  LoginModel.fromJson(Map<String, dynamic> json)
      : staffid = json['staff_id'],
        userid = json['user_id'],
        usernama = json['user_nama'];
}
