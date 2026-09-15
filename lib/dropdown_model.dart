class DropDownModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  DropDownModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory DropDownModel.fromJson(Map<String, dynamic> json) {
    return DropDownModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
