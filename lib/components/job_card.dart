// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:attnkare_manager_app/models/job_model.dart';

class JobCardWidget extends StatelessWidget {
  final JobModel jobModel;

  const JobCardWidget({
    Key? key,
    required this.jobModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.88,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(3, 9)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              jobModel.id,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w100,
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              jobModel.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                fontFamily: 'Poppins',
                color: Colors.green.shade900,
              ),
            ),
            Text(
              jobModel.place ?? 'N/A',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Poppins',
                  color: Colors.amber.shade900),
            ),
          ],
        ),
      ),
    );
  }
}
