class ScreenResultResponse {
  final List<ScreenResult> screenResult;

  ScreenResultResponse({required this.screenResult});

  factory ScreenResultResponse.fromJson(Map<String, dynamic> json) {
    var list = json['screen_result'] as List;
    List<ScreenResult> screenResultList =
        list.map((i) => ScreenResult.fromJson(i)).toList();
    return ScreenResultResponse(screenResult: screenResultList);
  }
}

class ScreenResult {
  final String name;
  final String description;
  final String nationality;
  final String placeOfBirth;
  final int score;

  ScreenResult({
    required this.name,
    required this.description,
    required this.nationality,
    required this.placeOfBirth,
    required this.score,
  });

  factory ScreenResult.fromJson(Map<String, dynamic> json) {
    return ScreenResult(
      name: json['name'],
      description: json['descriptions'][0]['description1'],
      nationality: json['nat'],
      placeOfBirth: json['pob'],
      score: json['score'],
    );
  }
}
