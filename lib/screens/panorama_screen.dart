import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panorama/panorama.dart';
import 'package:ubicate_usc/models/models.dart';
import 'package:ubicate_usc/utils/color_string_util.dart';
import 'package:ubicate_usc/utils/icon_string_util.dart';

class PanoramaScreen extends StatelessWidget {
  const PanoramaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    String imagePath = args["image_path"] ?? 'bulevar.JPG';
    double latitude = args["latitude"] ?? 0;
    double longitude = args["longitude"] ?? 0;
    // Se lee un nuevo atributo que identifica si la foto es panoramica o no
    bool disabledPanoramic = args["disabled_panoramic"] ?? false;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(FontAwesomeIcons.chevronLeft)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getIcon(args['icon']),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                args['title'],
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: getColor(args['color']),
      ),
      body: Center(
        child:
            // Si es panoramica muestre un panorama con la imagen
            !disabledPanoramic
                ? Panorama(
                    latitude: latitude,
                    longitude: longitude,
                    child: Image(
                      image: AssetImage('assets/$imagePath'),
                    ),
                  )
                // sino es panoramica muestra una imagen estatica con formato cover
                : Image(
                    image: AssetImage('assets/$imagePath'),
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
      ),
      floatingActionButton: _FloatingButtons(args: args),
    );
  }
}

class _FloatingButtons extends StatelessWidget {
  const _FloatingButtons({
    Key? key,
    required this.args,
  }) : super(key: key);

  final dynamic args;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        (args['floors'] != null)
            ? FloatingActionButton(
                child: const FaIcon(FontAwesomeIcons.info),
                backgroundColor: getColor(args['color']),
                onPressed: () {
                  _showDialogInfo(context);
                },
              )
            : const SizedBox(),
        const SizedBox(height: 10),
        FloatingActionButton(
          heroTag: 1,
          child: const FaIcon(FontAwesomeIcons.mapMarkerAlt),
          backgroundColor: getColor(args['color']),
          onPressed: () {
            _askedToEntrance(context, args['name']);
            // Navigator.popAndPushNamed(context, 'route');
          },
        ),
      ],
    );
  }

  Future<void> _showDialogInfo(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Row(
            children: [
              FaIcon(FontAwesomeIcons.infoCircle),
              SizedBox(width: 5),
              Text('Sitios de Interés')
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          children: _getInfoFloor(),
        );
      },
    );
  }

  List<Widget> _getInfoFloor() {
    List<Widget> floors = [const Divider()];
    for (var floor in args['floors']) {
      Widget temp = Text(
        '${floor['floor']}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      );
      floors.add(temp);
      for (var item in floor['items']) {
        Widget temp = Text('• $item');
        floors.add(temp);
      }
      floors.add(const Divider());
    }
    return floors;
  }

  Future<void> _askedToEntrance(
      BuildContext context, String destination) async {
    switch (await showDialog<String>(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          // Se cambiaron textos y se removio la entrada de profesores
          return SimpleDialog(
            title: const Text('Seleccione una Entrada'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Principal");
                },
                child: const Text('Entrada Principal - Calle 5'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Estudiantes");
                },
                child: const Text('Entrada Parqueaderos - Carrera 63a'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Santiaguitos");
                },
                child: const Text('Entrada Santiaguitos - Calle 3'),
              ),
            ],
          );
        })) {
      case "Principal":
        Navigator.popAndPushNamed(context, 'route',
            arguments: Direction('Principal', destination));
        break;
      case "Profesores":
        Navigator.popAndPushNamed(context, 'route',
            arguments: Direction('Profesores', destination));
        break;
      case "Santiaguitos":
        Navigator.popAndPushNamed(context, 'route',
            arguments: Direction('Santiaguitos', destination));
        break;
      case "Estudiantes":
        Navigator.popAndPushNamed(context, 'route',
            arguments: Direction('Estudiantes', destination));
        break;
    }
  }
}
