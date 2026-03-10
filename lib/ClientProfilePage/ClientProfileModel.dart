
// class ClientProfileModel {
//   String? companyName;
//   String? companyWebsite;
//   String? companySize;
//   String? contactEmail;
//   String? linkedinUrl;
//   String? industry;
//   String? location;
//   String? phone;
//   String? description;
//   String? logo;
//   String? createdAt;
//   String? updatedAt;

//   ClientProfileModel({
//     this.companyName,
//     this.companyWebsite,
//     this.companySize,
//     this.contactEmail,
//     this.linkedinUrl,
//     this.industry,
//     this.location,
//     this.phone,
//     this.description,
//     this.logo,
//     this.createdAt,
//     this.updatedAt,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "company_name": companyName,
//       "company_website": companyWebsite,
//       "company_size": companySize,
//       "contact_email": contactEmail,
//       "linkedin_url": linkedinUrl,
//       "industry": industry,
//       "location": location,
//       "phone": phone,
//       "company_description": description,
//       "logo": logo,
//     };
//   }

//   factory ClientProfileModel.fromJson(Map<String, dynamic> json) {
//     return ClientProfileModel(
//       companyName: json["company_name"],
//       companyWebsite: json["company_website"],
//       companySize: json["company_size"],
//       contactEmail: json["contact_email"],
//       linkedinUrl: json["linkedin_url"],
//       industry: json["industry"],
//       location: json["location"],
//       phone: json["phone"],
//       description: json["company_description"],
//       logo: json["logo"],
//       createdAt: json["created_at"],
//       updatedAt: json["updated_at"],
//     );
//   }
// }


class ClientProfileModel {

  String? companyName;
  String? companyWebsite;
  String? companySize;
  String? contactEmail;
  String? linkedinUrl;
  String? industry;
  String? location;
  String? phone;
  String? description;
  String? logo;
  String? createdAt;
  String? updatedAt;

  ClientProfileModel({
    this.companyName,
    this.companyWebsite,
    this.companySize,
    this.contactEmail,
    this.linkedinUrl,
    this.industry,
    this.location,
    this.phone,
    this.description,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {

    final data = <String, dynamic>{};

    if (companyName != null) data["company_name"] = companyName;
    if (companyWebsite != null) data["company_website"] = companyWebsite;
    if (companySize != null) data["company_size"] = companySize;
    if (contactEmail != null) data["contact_email"] = contactEmail;
    if (linkedinUrl != null) data["linkedin_url"] = linkedinUrl;
    if (industry != null) data["industry"] = industry;
    if (location != null) data["location"] = location;
    if (phone != null) data["phone"] = phone;
    if (description != null) data["company_description"] = description;
    if (logo != null) data["logo"] = logo;

    return data;
  }

  factory ClientProfileModel.fromJson(Map<String, dynamic> json) {
    return ClientProfileModel(
      companyName: json["company_name"]?.toString(),
      companyWebsite: json["company_website"]?.toString(),
      companySize: json["company_size"]?.toString(),
      contactEmail: json["contact_email"]?.toString(),
      linkedinUrl: json["linkedin_url"]?.toString(),
      industry: json["industry"]?.toString(),
      location: json["location"]?.toString(),
      phone: json["phone"]?.toString(),
      description: json["company_description"]?.toString(),
      logo: json["logo"]?.toString(),
      createdAt: json["created_at"]?.toString(),
      updatedAt: json["updated_at"]?.toString(),
    );
  }
}