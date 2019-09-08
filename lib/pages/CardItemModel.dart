import 'package:flutter/material.dart';

class CardItemModel {
  String cardTitle;
  IconData icon;
  int tasksRemaining;
  double taskCompletion;
  MaterialPageRoute pageRoute;

  CardItemModel(this.cardTitle, this.icon, this.tasksRemaining,
      this.taskCompletion, this.pageRoute);
}
