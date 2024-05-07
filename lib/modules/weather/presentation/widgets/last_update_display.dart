import 'package:cloudwalk/shared/commons/extensions/datetime_extension.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/services/connectivity/widgets/connectivity_builder.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';

/// [LastWeatherUpdateDisplay] is a widget that displays the last weather update from the server.
class LastWeatherUpdateDisplay extends StatefulWidget {
  final DateTime lastUpdate;

  const LastWeatherUpdateDisplay({
    Key? key,
    required this.lastUpdate,
  }) : super(key: key);

  @override
  State<LastWeatherUpdateDisplay> createState() =>
      _LastWeatherUpdateDisplayState();
}

class _LastWeatherUpdateDisplayState extends State<LastWeatherUpdateDisplay> {
  late String date;
  late String time;

  setup(DateTime lastUpdate) {
    date = widget.lastUpdate.formatDDMMYYYY();

    if (lastUpdate.isToday) {
      date = Language.instance.lang.today;
    }

    time = widget.lastUpdate.formatHHmm();
  }

  @override
  void initState() {
    super.initState();
    setup(widget.lastUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityBuilder(
      onlineChild: const SizedBox.shrink(),
      offlineChild: Text(
        '${Language.instance.lang.lastUpdate}: $date $time',
        style: AppTextStyle.bodyMedium(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
