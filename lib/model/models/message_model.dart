class MessageModel {
  late final String text;

  late final String senderId;

  late String receiverId;
  late String dateTime;

  MessageModel({
    required this.receiverId,
    required this.senderId,
    required this.text,
    required this.dateTime,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];

    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
    };
  }
}
