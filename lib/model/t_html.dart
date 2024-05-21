

import 'package:floor/floor.dart';

@entity
class Html {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? htmlcodigo;



  Html(
      {this.id,
        this.htmlcodigo
      });

  factory Html.fromJson(dynamic json) {
    return Html(
      id: json['id'],
      htmlcodigo: json['htmlcodigo'],
    );
  }

  static List<Html> listFromJson(dynamic json) {
    var bienvenidaList = json as List;
    List<Html> items =
    bienvenidaList.map((e) => Html.fromJson(e)).toList();
    return items;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "htmlcodigo": htmlcodigo,
    };
  }
}
