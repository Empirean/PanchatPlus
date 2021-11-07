class PanchatMessage{

  static const senderName = "SENDER";
  static const messageName = "MESSAGE";
  static const timestampName = "TIME_STAMP";

  final String sender;
  final String message;
  final DateTime timestamp;
  final String id;
  PanchatMessage({this.sender = "", this.message = "", required this.timestamp, this.id = ""});
}