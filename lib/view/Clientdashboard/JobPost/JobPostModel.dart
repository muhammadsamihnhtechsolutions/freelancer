class JobPostModel {
  String title;
  String description;
  double budgetMin;
  double budgetMax;
  String jobType;
  String categoryId;

  JobPostModel({
    required this.title,
    required this.description,
    required this.budgetMin,
    required this.budgetMax,
    required this.jobType,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "budget_min": budgetMin,
      "budget_max": budgetMax,
      "job_type": jobType,
      "category_id": categoryId,
    };
  }
}