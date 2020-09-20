
class Notification {
  final String id;
  final String message;

 Notification(this.id, this.message);

  Notification.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        message= json['message'];


  Map<String, dynamic> toJson() =>
      {
        '_id': id,
        'message': message,
      };
}