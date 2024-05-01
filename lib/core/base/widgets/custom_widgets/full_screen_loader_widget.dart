import 'package:flutter/material.dart';

class FullScreenLoaderWidget extends StatelessWidget {
  final String? message;

  const FullScreenLoaderWidget({super.key, this.message});

  factory FullScreenLoaderWidget.onlyAnimation() {
    return const FullScreenLoaderWidget();
  }

  factory FullScreenLoaderWidget.message(String message) {
    return FullScreenLoaderWidget(message: message);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      color: theme.primaryColor.withOpacity(0.10),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
        ),
      ),
    );
  }

  Widget txtWithLoading(Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 20),
        Text(message ?? "", style: TextStyle(fontSize: 25, color: color))
      ],
    );
  }
}
