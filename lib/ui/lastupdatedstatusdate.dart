import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class LastUpdatedDateFormatter{
  final DateTime lastUpdated;
  LastUpdatedDateFormatter({@required this.lastUpdated});

  String lastUpdatedStatusText(){
    if(lastUpdated != null){
      final formatter = DateFormat.yMd().add_Hms();
      final formatted = formatter.format(lastUpdated);
      return 'Last updated: $formatted';
    }
    return '';
  }
}

class LastUpdatedStatusText extends StatelessWidget {
  final String text;
  LastUpdatedStatusText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
          textAlign: TextAlign.center,
      ),
    );
  }
}
