class AutocompletePrediction {
  AutocompletePrediction({
    required this.description,
    required this.structuredFormatting,
    required this.placeId,
    required this.reference,
  });

  final String? description;
  final StructuredFormatting? structuredFormatting;
  final String? placeId;
  final String? reference;

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      description: json['description'] as String?,
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structred_formatting'] != null
          ? StructuredFormatting.fromJson(json['structred_formatting'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'description': description,
        'place_id': placeId,
        'reference': reference,
        'structred_formatting': structuredFormatting,
      };

  @override
  String toString() => toJson().toString();
}

class StructuredFormatting {
  StructuredFormatting({
    required this.mainText,
    required this.secondaryText,
  });

  final String? mainText;
  final String? secondaryText;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
    );
  }
}
