import 'package:flutter/material.dart';
import 'package:freelancer_app/loginsignup/ClientProposal/ClientProposalModel.dart';
import 'package:freelancer_app/loginsignup/ClientProposal/ClientViewDetailPropsaleController.dart';
import 'package:get/get.dart';

class ClientViewDetailsProposalPage extends StatelessWidget {

  ClientViewDetailsProposalPage({
    super.key,
    required this.proposalId,
    required this.jobId,
    required this.freelancerName,
    required this.freelancerEmail,
    required this.status,
    required this.coverLetter,
    required this.price,
    required this.deliveryDays,
  });

  final ClientViewDetailsProposalController controller =
      Get.put(ClientViewDetailsProposalController());

  final String proposalId;
  final String jobId;
  final String freelancerName;
  final String freelancerEmail;
  final String status;
  final String coverLetter;
  final String price;
  final String deliveryDays;

  // final ClientProposalModel proposal = Get.arguments;

  @override
  Widget build(BuildContext context) {

    final avatarLetter =
        freelancerName.isNotEmpty ? freelancerName[0].toUpperCase() : "?";

    return Scaffold(
      backgroundColor: const Color(0xffF5F6F8),

      appBar: AppBar(
        elevation: 0,
        title: const Text("Proposal Details"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// FREELANCER CARD
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [

                  /// AVATAR
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,

                    child: Text(
                      avatarLetter,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// NAME + EMAIL
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          freelancerName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          freelancerEmail,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// STATUS BADGE
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      status.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// PRICE + DELIVERY
            Row(
              children: [

                Expanded(
                  child: _infoCard("PRICE", "£$price"),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _infoCard("DELIVERY", "$deliveryDays days"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// COVER LETTER
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  const Text(
                    "Cover Letter",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(coverLetter),
                ],
              ),
            ),

            const Spacer(),

            /// BUTTONS
            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),

                    onPressed: () {
                      controller.acceptProposal(proposalId);
                    },

                    child: const Text("Accept"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),

                    onPressed: () {
                      controller.rejectProposal(proposalId);
                    },

                    child: const Text("Reject"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// INFO CARD
  Widget _infoCard(String title, String value) {

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}