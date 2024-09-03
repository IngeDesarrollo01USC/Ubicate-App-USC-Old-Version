import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubicate_usc/models/models.dart';
import 'package:ubicate_usc/providers/providers.dart';

class ClassroomsSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar Salón';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {},
        icon: const FaIcon(FontAwesomeIcons.times),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const FaIcon(FontAwesomeIcons.chevronLeft),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return _emptyData();
    }

    final classroomProvider =
        Provider.of<ClassroomProvider>(context, listen: false);

    return FutureBuilder(
      future: classroomProvider.searchRoom(query),
      builder: (_, AsyncSnapshot<List<ClassRoom>> snapshot) {
        if (!snapshot.hasData) return _emptyData();

        final classrooms = snapshot.data!;

        return ListView.builder(
          itemCount: classrooms.length,
          itemBuilder: (_, int index) => _ClassRoomItem(classrooms[index]),
        );
      },
    );
  }

  Widget _emptyData() {
    return const Center(
      child: FaIcon(
        FontAwesomeIcons.university,
        color: Colors.black38,
        size: 130,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyData();
    }

    final classroomProvider =
        Provider.of<ClassroomProvider>(context, listen: false);

    return FutureBuilder(
      future: classroomProvider.searchRoom(query),
      builder: (_, AsyncSnapshot<List<ClassRoom>> snapshot) {
        if (!snapshot.hasData) return _emptyData();

        final classrooms = snapshot.data!;

        return ListView.builder(
          itemCount: classrooms.length,
          itemBuilder: (_, int index) => _ClassRoomItem(classrooms[index]),
        );
      },
    );
  }
}

class _ClassRoomItem extends StatelessWidget {
  final ClassRoom classRoom;

  const _ClassRoomItem(this.classRoom);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(classRoom.id.toUpperCase()),
      onTap: () {
        _askedToEntrance(context, classRoom.name);
        // Navigator.popAndPushNamed(context, 'route');
      },
    );
  }
}

Future<void> _askedToEntrance(BuildContext context, String destination) async {
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
                Navigator.pop(context, "AulaMaxima");
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
