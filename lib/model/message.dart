class Message {
  final String room;
  final String type;
  final String username;
  final String message;

  Message(this.room, this.type, this.username, this.message);

  Message.fromJson(Map<String, dynamic> json)
      : room = json['room'],
        type = json['type'],
        username = json['username'],
        message = json['message'];

  Map<String, dynamic> toJson() =>
      {
        'room': room,
        'type': type,
        'username': username,
        'message': message,
      };
}