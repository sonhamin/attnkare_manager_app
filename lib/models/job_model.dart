class JobModel {
  final String id, name;
  final String? place;
  final int status;
  // final result //[],

  JobModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        place = json['place'],
        status = json['status'];
}
// bluekare_doctor