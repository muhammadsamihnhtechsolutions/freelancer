import 'package:flutter/material.dart';
import 'package:freelancer_app/view/Clientdashboard/JobPost/PostJobController.dart';
import 'package:get/get.dart';

class PostJob extends StatelessWidget {
  PostJob({super.key});

  final JobController controller = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f7),

      appBar: AppBar(
        title: const Text("Post a Job"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// JOB TITLE
              const Text(
                "Job Title",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              TextField(
                controller: controller.titleCtrl,
                decoration: _dec("Enter job title"),
              ),

              const SizedBox(height: 18),

              /// DESCRIPTION
              const Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              TextField(
                controller: controller.descCtrl,
                maxLines: 7,
                decoration: _dec("Job description..."),
                onChanged: (_) {
                  controller.update();
                },
              ),

              const SizedBox(height: 18),

              /// LIVE PREVIEW
              const Text(
                "Live Preview",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              GetBuilder<JobController>(
                builder: (c) {
                  return Container(
                    width: double.infinity,
                    height: 130,
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Text(
                      c.descCtrl.text.isEmpty
                          ? "Job Overview\nResponsibilities\nRequirements"
                          : c.descCtrl.text,
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),

              /// BUDGET
              Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Min Budget",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 6),

                        TextField(
                          controller: controller.minBudgetCtrl,
                          keyboardType: TextInputType.number,
                          decoration: _dec("e.g. 50"),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Max Budget",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 6),

                        TextField(
                          controller: controller.maxBudgetCtrl,
                          keyboardType: TextInputType.number,
                          decoration: _dec("e.g. 150"),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 18),

              /// JOB TYPE
              const Text(
                "Job Type",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              Obx(() {

                const types = ["remote", "onsite", "hybrid"];

                String? safeValue =
                types.contains(controller.jobType.value)
                    ? controller.jobType.value
                    : null;

                return _dropdown(
                  items: types,
                  value: safeValue,
                  onChanged: (v) {
                    if (v != null) {
                      controller.jobType.value = v;
                    }
                  },
                );

              }),

              const SizedBox(height: 18),

              /// CATEGORY
              const Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 6),

              Obx(() {

                if (controller.loadingCategories.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.categories.isEmpty) {
                  return const Text("No Categories Found");
                }

                final ids =
                controller.categories.map((e) => e.id).toList();

                final labels =
                controller.categories.map((e) => e.name).toList();

                String? safeCategory =
                ids.contains(controller.selectedCategoryId.value)
                    ? controller.selectedCategoryId.value
                    : null;

                return _dropdown(
                  items: ids,
                  labels: labels,
                  value: safeCategory,
                  onChanged: (v) {
                    controller.selectedCategoryId.value = v;
                  },
                );

              }),

              const SizedBox(height: 26),

              /// POST BUTTON
              Obx(() => SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: controller.creatingJob.value
                      ? null
                      : () {
                    controller.createJob();
                  },

                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFF5A5BFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  child: controller.creatingJob.value
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    "Post Job",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                ),

              )),

            ],
          ),
        ),
      ),
    );
  }

  /// TEXTFIELD STYLE
  InputDecoration _dec(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade100,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  /// SAFE DROPDOWN
  Widget _dropdown({
    required List<String> items,
    required Function(String?) onChanged,
    String? value,
    List<String>? labels,
  }) {

    if (value != null && items.where((e) => e == value).length != 1) {
      value = null;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),

      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        hint: const Text("Select"),

        items: List.generate(items.length, (i) {

          return DropdownMenuItem<String>(
            value: items[i],
            child: Text(labels != null ? labels[i] : items[i]),
          );

        }),

        onChanged: onChanged,
      ),
    );
  }
}
