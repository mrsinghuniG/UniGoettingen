import 'package:flutter/material.dart';
import '../screens/webview_page.dart';

class HomeWidget extends StatelessWidget {
  final String title;

  const HomeWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'eCampus') {
          // Navigate to the WebViewPage for eCampus
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WebViewPage(
                url: 'https://www.uni-goettingen.de/',
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title clicked!')),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
