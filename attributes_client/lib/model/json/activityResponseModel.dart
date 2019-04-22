import 'package:tuple/tuple.dart';

class ActivityResponseModel {
  final int id;
  final DateTime dateCreated;

  final List<int> faith;
  final List<int> hope;
  final List<int> charity;
  final List<int> virtue;
  final List<int> knowledge;
  final List<int> patience;
  final List<int> humility;
  final List<int> diligence;
  final List<int> obedience;

  ActivityResponseModel(
      this.id,
      this.dateCreated,
      this.faith,
      this.hope,
      this.charity,
      this.virtue,
      this.knowledge,
      this.patience,
      this.humility,
      this.diligence,
      this.obedience);

  ActivityResponseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dateCreated = DateTime.parse(json['date_created']),
        faith = json['faith'].cast<int>(),
        hope = json['hope'].cast<int>(),
        charity = json['charity'].cast<int>(),
        virtue = json['virtue'].cast<int>(),
        knowledge = json['knowledge'].cast<int>(),
        patience = json['patience'].cast<int>(),
        humility = json['humility'].cast<int>(),
        diligence = json['diligence'].cast<int>(),
        obedience = json['obedience'].cast<int>();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateCreated':
          dateCreated.toIso8601String(), // TODO is this right? does it matter?
      'faith': faith,
      'hope': hope,
      'charity': charity,
      'virtue': virtue,
      'knowledge': knowledge,
      'patience': patience,
      'humility': humility,
      'diligence': diligence,
      'obedience': obedience,
    };
  }

  Map<String, List<int>> ratingLists() {
    return {
      'faith': faith,
      'hope': hope,
      'charity': charity,
      'virtue': virtue,
      'knowledge': knowledge,
      'patience': patience,
      'humility': humility,
      'diligence': diligence,
      'obedience': obedience,
    };
  }

  Tuple2<String, double> getHighestAttribute() {
    var highestAverage = 0.0;
    var highestAttr = '';
    for (var entry in ratingLists().entries) {
      final currentAttr = entry.key;
      final currentRatingsList = entry.value;

      final currentAverage = currentRatingsList.reduce((a, b) => a + b) /
          currentRatingsList.length.toDouble();
      if (currentAverage >= highestAverage) {
        highestAverage = currentAverage;
        highestAttr =
            '${currentAttr[0].toUpperCase()}${currentAttr.substring(1)}';
      }
    }

    return new Tuple2<String, double>(highestAttr, highestAverage);
  }

  Tuple2<String, double> getLowestAttribute() {
    var lowestAverage = 5.0;
    var lowestAttr = '';
    for (var entry in ratingLists().entries) {
      final currentAttr = entry.key;
      final currentRatingsList = entry.value;

      final currentAverage = currentRatingsList.reduce((a, b) => a + b) /
          currentRatingsList.length.toDouble();
      if (currentAverage <= lowestAverage) {
        lowestAverage = currentAverage;
        lowestAttr =
            '${currentAttr[0].toUpperCase()}${currentAttr.substring(1)}';
      }
    }

    return Tuple2<String, double>(lowestAttr, lowestAverage);
  }
}
