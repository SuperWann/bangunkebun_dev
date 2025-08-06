class GeminiResponse {
  final List<Candidate> candidates;

  GeminiResponse({required this.candidates});

  factory GeminiResponse.fromJson(Map<String, dynamic> json) {
    return GeminiResponse(
      candidates: (json['candidates'] as List)
          .map((candidate) => Candidate.fromJson(candidate))
          .toList(),
    );
  }

  // Method untuk mengambil text dari candidate pertama
  String getFirstText() {
    if (candidates.isNotEmpty && 
        candidates[0].content.parts.isNotEmpty) {
      return candidates[0].content.parts[0].text;
    }
    return '';
  }
}

class Candidate {
  final Content content;
  final String finishReason;
  final int index;

  Candidate({
    required this.content,
    required this.finishReason,
    required this.index,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      content: Content.fromJson(json['content']),
      finishReason: json['finishReason'],
      index: json['index'],
    );
  }
}

class Content {
  final List<Part> parts;
  final String role;

  Content({required this.parts, required this.role});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      parts: (json['parts'] as List)
          .map((part) => Part.fromJson(part))
          .toList(),
      role: json['role'],
    );
  }
}

class Part {
  final String text;

  Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(text: json['text']);
  }
}