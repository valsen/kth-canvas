import 'package:flutter/material.dart';

import '../data/models/models.dart';

class DeleteTodoSnackBar extends SnackBar {
//  final ArchSampleLocalizations localizations;

  DeleteTodoSnackBar({
    Key key,
    @required Todo todo,
    @required VoidCallback onUndo,
  }) : super(
    key: key,
    content: Text(
      "Gömde " + todo.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    duration: Duration(seconds: 2),
    action: SnackBarAction(
      label: "ångra",
      onPressed: onUndo,
    ),
  );
}