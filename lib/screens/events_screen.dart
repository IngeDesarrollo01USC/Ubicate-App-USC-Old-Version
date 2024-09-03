import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ubicate_usc/models/models.dart';
import 'package:ubicate_usc/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventsProvider = Provider.of<EventsProvider>(context);
    List<UscEvent> events = eventsProvider.events;
    if (events.isEmpty) {
      // Se comenta al usuario que no hay eventos en el filtro seleccionado
      return const Center(
        child: Text("No hay eventos programados",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
            textAlign: TextAlign.center),
      );
    } else {
      return ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          UscEvent event = events[index];

          return GestureDetector(
            onTap: () async {
              String _url = 'https://peewah.co/events/${event.path}';
              await canLaunch(_url)
                  ? await launch(_url)
                  : throw 'Could not launch $_url';
            },
            child: Card(
              // color: const Color.fromRGBO(214, 237, 240, 1),
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _BannerImage(bannerUrl: event.bannerUrl),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: _ContentCard(event: event),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}

class _ContentCard extends StatelessWidget {
  final UscEvent event;
  const _ContentCard({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _getMode(),
        const SizedBox(height: 10),
        _getStartDate(),
        const SizedBox(height: 10),
        _getHour(),
        const SizedBox(height: 10),
      ],
    );
  }

  Row _getHour() => Row(
        children: [
          const FaIcon(FontAwesomeIcons.clock, size: 20),
          const SizedBox(width: 10),
          Text(event.startHourString)
        ],
      );

  Row _getStartDate() => Row(
        children: [
          const FaIcon(FontAwesomeIcons.calendarCheck, size: 20),
          const SizedBox(width: 10),
          Text(event.startDateString)
        ],
      );

  Row _getMode() => Row(
        children: [
          const FaIcon(FontAwesomeIcons.mapMarkerAlt, size: 20),
          const SizedBox(width: 10),
          (event.eventMode == "ONLINE")
              ? const Text('Virtual')
              : Text('${event.city} - ${event.country}')
        ],
      );
}

class _BannerImage extends StatelessWidget {
  final String? bannerUrl;
  const _BannerImage({
    required this.bannerUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bannerUrl != null) {
      return FadeInImage(
        placeholder: const AssetImage('assets/loadingBanner.gif'),
        image: NetworkImage(bannerUrl!),
        fit: BoxFit.cover,
      );
    } else {
      return const Image(
        image: AssetImage('assets/defaultBanner.jpeg'),
        fit: BoxFit.cover,
      );
    }
  }
}
