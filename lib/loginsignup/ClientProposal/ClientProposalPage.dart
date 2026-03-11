import 'package:flutter/material.dart';
import 'package:freelancer_app/loginsignup/ClientProposal/ClientViewProPosalDetailPage.dart';
import 'package:get/get.dart';
import 'package:freelancer_app/loginsignup/ClientProposal/ClientProposalController.dart';

class ClientProposalPage extends StatefulWidget {
  const ClientProposalPage({super.key});

  @override
  State<ClientProposalPage> createState() => _ClientProposalPageState();
}

class _ClientProposalPageState extends State<ClientProposalPage> {

  final controller = Get.put(ClientProposalController());

  late String jobId;

  @override
  void initState() {
    super.initState();

    jobId = Get.arguments?.toString() ?? "";

    print("📌 ClientProposalPage → Received jobId = $jobId");

    if (jobId.isNotEmpty) {
      controller.fetchProposals(jobId);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF8F9FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("Proposals"),
      ),

      body: Obx(() {

        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.proposals.isEmpty) {
          return const Center(child: Text("No proposals found"));
        }

        return ListView.builder(

          padding: const EdgeInsets.all(18),

          itemCount: controller.proposals.length,

          itemBuilder: (_, i) {

            final p = controller.proposals[i];

            return Container(

              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),
                    blurRadius: 18,
                    offset: const Offset(0,6),
                  )
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  /// USER INFO
                  Row(
                    children: [

                      Container(
                        height: 46,
                        width: 46,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff8E7BFF),
                              Color(0xff5AA9FF)
                            ],
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          p.freelancerName.isNotEmpty
                              ? p.freelancerName[0].toUpperCase()
                              : "?",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Text(
                            p.freelancerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            p.freelancerEmail,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 14),

                  /// TAGS
                  Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xffE8F0FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Freelancer",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff3D6DFF),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xffFFF3CD),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "completed",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xffB98A00),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  const Divider(),

                  const SizedBox(height: 10),

                  /// PRICE DELIVERY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          const Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            "\$${p.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [

                          const Text(
                            "Delivery",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            "${p.deliveryDays} days",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// BUTTON
GestureDetector(
onTap: () {

  print("📌 View Details Clicked → ${p.id}");

  Get.to(() => ClientViewDetailsProposalPage(
    proposalId: p.id,
    jobId: p.jobId,
    freelancerName: p.freelancerName,
    freelancerEmail: p.freelancerEmail,
    status: p.status,
    coverLetter: p.coverLetter,
    price: p.price.toString(),
    deliveryDays: p.deliveryDays.toString(),
  ));

},
  child: Container(
    height: 42,
    alignment: Alignment.center,
    child: const Text("View Details"),
  ),
)
                ],
              ),
            );
          },
        );
      }),
    );
  }
}