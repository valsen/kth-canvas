// To parse this JSON data, do
//
//     final customColor = customColorFromJson(jsonString);

import 'dart:convert';

CustomColors customColorsFromJson(String str) => CustomColors.fromMap(json.decode(str));

String customColorsToJson(CustomColors data) => json.encode(data.toMap());

class CustomColors {
    List<CustomColor> customColors;

    CustomColors({
        this.customColors,
    });

    factory CustomColors.fromMap(List<CustomColor> json) => CustomColors(
        customColors: json,
    );

    Map<String, List<CustomColor>> toMap() => {
        "custom_colors": customColors,
    };
}

class CustomColor {
  String id;
  String color;

  CustomColor({
    this.id,
    this.color
  });

  Map<String, String> toMap() => {
        "id": id,
        "color": color
    };
}
