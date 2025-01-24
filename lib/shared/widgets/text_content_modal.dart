import 'package:flutter/material.dart';

class TextContentModal extends StatelessWidget {
  const TextContentModal({
    super.key,
    required this.label,
    required this.isi,
  });

  final String label;
  final String? isi;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.0,
            child: Text(
              label,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          const SizedBox(width: 10.0, child: Text(":")),
          Expanded(child: Text(isi ?? '-')),
        ],
      ),
    );
  }
}