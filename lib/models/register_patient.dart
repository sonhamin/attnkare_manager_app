class RegisterPatientModel {
  final int id, patientId, doctorId;

  RegisterPatientModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        patientId = json['patient_id'],
        doctorId = json['doctor_id'];
}
