class SubscribeModel {
  final int id;
  final SubscribeServiceModel service;

  SubscribeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        service = SubscribeServiceModel.fromJson(json['service']);
}

class SubscribeServiceModel {
  final int id, servcieType;
  final String addr, serviceName, description;

  SubscribeServiceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        addr = json['addr'],
        serviceName = json['service_name'],
        servcieType = json['service_type'],
        description = json['description'];
}
// bluekare_doctor