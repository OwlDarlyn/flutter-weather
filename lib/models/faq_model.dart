library faq.model;

class Faq {
  final String title;
  final String body;
  bool isExpanded;

  Faq({required this.title, required this.body, required this.isExpanded});
}