class ClientProposalModel {

  final String id;
  final String freelancerName;
  final String freelancerEmail;
  final double price;
  final int deliveryDays;
  final String status;

  ClientProposalModel({
    required this.id,
    required this.freelancerName,
    required this.freelancerEmail,
    required this.price,
    required this.deliveryDays,
    required this.status,
  });

  factory ClientProposalModel.fromJson(Map<String, dynamic> json) {

    return ClientProposalModel(
      id: json["id"] ?? "",
      freelancerName: json["freelancer_name"] ?? "",
      freelancerEmail: json["freelancer_email"] ?? "",
price: double.tryParse(json['price'].toString()) ?? 0.0,
      deliveryDays: json["delivery_days"] ?? 0,
      status: json["status"] ?? "",
      
    );
  }
}