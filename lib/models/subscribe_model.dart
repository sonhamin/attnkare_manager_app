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
        servcieType = json['servcie_type'],
        addr = json['addr'],
        serviceName = json['service_name'],
        description = json['description'];
}
