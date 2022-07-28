import 'package:flutter/material.dart';

Future<String?> buildShowDialog(BuildContext context, List content) async {
  String result = '';
  await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: GestureDetector(
                        onTap: () {
                          result = content[index];
                          Navigator.pop(context);
                        },
                        child: Card(child: Text(content[index])),
                      ),
                    );
                  },
                  itemCount: content.length,
                ),
              ],
            ),
          ),
        );
      });
  return result;
}
