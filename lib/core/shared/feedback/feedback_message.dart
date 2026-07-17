enum FeedbackType { success, error, info, warning }

class FeedbackMessage {
  final FeedbackType type;
  final String? title;
  final String description;

  const FeedbackMessage({
    required this.type,
    this.title,
    required this.description,
  });

  FeedbackMessage copyWith({
    FeedbackType? type,
    String? title,
    String? description,
  }) {
    return FeedbackMessage(
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
