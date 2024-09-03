import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ubicate_usc/utils/icon_string_util.dart';

List<Widget> listItems(data, BuildContext context) {
  final List<Widget> options = [];

  for (var opt in data) {
    final cardTemp = Card(
      color: const Color.fromRGBO(214, 237, 240, 1),
      child: ListTile(
        dense: true,
        leading: getIconWithColor(opt['icon'], opt['color']),
        title: Text(
          opt['title'],
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const FaIcon(FontAwesomeIcons.streetView),
        onTap: () {
          Navigator.pushNamed(context, 'panorama', arguments: opt);
        },
      ),
    );

    options.add(cardTemp);
  }

  return options;
}

/*
Future<void> _showInfoDialog(BuildContext context, dynamic opt) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            getIcon(opt['icon'], opt['color']),
            const SizedBox(width: 6),
            Text(opt['title']),
          ],
        ),
        content: Text(
          opt['info'],
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          TextButton(
            onPressed: () => Navigator.popAndPushNamed(context, 'route'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Ir'),
                SizedBox(width: 4),
                FaIcon(
                  FontAwesomeIcons.locationArrow,
                  size: 13,
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
*/