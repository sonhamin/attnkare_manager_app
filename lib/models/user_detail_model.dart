class UserDetailModel {
  final String id, title, rating, date, thumb;

  UserDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'],
        thumb = json['thumb'];
}
