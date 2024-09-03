import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ubicate_usc/models/models.dart';

class EventsProvider extends ChangeNotifier {
  final String _baseUrl = 'peewah-prod.appspot.com';

  List<UscEvent> events = [];
  List<UscEvent> allEvents = [];

  EventsProvider() {
    getAllEvents();
  }

  Future<String> _getJsonData() async {
    final url = Uri.https(_baseUrl,
        '_ah/api/ems/v1/organizers/87c0ab4ebd604c919d77f9cb1825f9eb/events', {
      'page': '1',
      'pageSize': '10000',
      'date': DateTime.now().toIso8601String(),
    });
    final response = await http.get(url);
    return response.body;
  }

  getAllEvents() async {
    final jsonData = await _getJsonData();
    final UscEventsResponse uscEventsResponse =
        UscEventsResponse.fromJson(jsonData);
    // Se crea una variable temporal donde se guarda lo devuelto por peewah
    List<UscEvent> responseLocal = uscEventsResponse.items;

    // Se invierte la lista para que los más nuevos aparezcan arriba
    responseLocal = responseLocal.reversed.toList();

    // Se inserta el evento nuevo (constante) en la posición 0
    /*responseLocal.insert(
        0,
        UscEvent(
            city: 'Cali',
            country: 'Colombia Auditorio Pedro Elías Serrano USC',
            bannerUrl:
                'https://lh3.googleusercontent.com/fife/AAbDypAJy6u3oLwWmu3MPAFmBQkntj0THx5UftiiyDSbWv3ZkKoZiVA3ubWcY7qFVrG2u6YbVWzmVtK_QLB_tgFmbGFPcePAjF1p6SCt5XMr2Jsm3WkCCKlABItGoSEXHqJKqi41RrvcDB6hLrbRszIFX7j4KeTET1ik9Rt3qBmnlmxBu3dBgRqZptvfOQGAQtN7pZvuiJcXHuYC6O_v0q6Q8QDWHtaorRD9pLcxpYJ-KAvWucFqiCUfL28wa9I8wXvGbgaaKoZo3V2gt6X1Na_wGBSd3zODFXWy-qT1rAXbT2zCVPvc9ahI7McdWXp_0Ykh2gaC7H2kr33zDDQ6cWgTTRGc8iRUkovyUeLcubvbTHIRp41GhMmWPaSV3nms1-c1P8697NhqIkC2GXMXraBDyR4CnKhZsmkCdMjXofg-8leAgpL0sBWYCk4UXkgycmWjpte6UtKDXHL3nxL8uQhxTUFcivQOeuOEQZs6IrMRo0jBB27R-Zt_hKZkuYgjjMdRWiCgBDhIPu1GqbijUAYkA2wk5Fxw0ItxlJkhq4TWiBUwgScZtMjOeRPCX0Tjc_CMoSMe0BYlZVJlfWW5CG0OxHpqchIIpliZKu_5XGpWSKa-KiBuMlASO8WNUXpByX_Kax50Ms_wUyXM1NzlOuxEB78yftpI12W78aNaeu6B_WLocipS0u6d20Cc6UqihJuEszYqLUY2KayurTS3DOAQQ54_feCmcFCyUdJJxfKUqdBilV08JumuprqZ_TjjqCkzTz32TnwoUC4cEsQLZA0sR-k58TS2H1iOVKMPiD0O1qoXOyXDqVaTk8qb6T0W2cGtV6XgqYxCAWQeaGq7YB0kOASGOBlTfWgUNqO3-ooFdLYIPYuVOzw5eRvHyAhto0Mq4DU2iXNP_beE9wdv9lIjd80_9svrQiyH83a62KQXZLDPK3nP5d-87pfIEjDjvjJ4UkiAsik6egM_rbrqKJFQg38BcG_yRdfNyRsA-FMd0U3-HE7e9E_lF4OOikpJlKUxz3QqsVmlXBi0E0VIu-4aoDJJ308HBnVX2zuLaNQOo2DwF611YRlFMc_eNCNQUa6qD2_xCPa4_O9bZwaI1q-u6ohOCYpNfSw8OizpPJBivIb_IW5ar6xuVJspKBsxg10doHkgxu-fhp_5cAjXRo9RTEl2WwV8DlmmhKirzVqajfx62ywFvvYRrUmrZKr1LCuzYeBag7VfqsbD-Ndn-EZcKZhUwezivmIxZHexexU2iF3TRs6uvLkbms6F55yUimqWM6eJZboxNsv0xKb9q9KJ9dU_ebh2msIJ-ucWdxlDzvV4fNUEoIMLSAlvMw9GMAk4eOiODu3fpEBEZTyJSQzGbUTRskIcbwYWlfbTwkawq_kqNKmHPlaAVXuQ6bYQ55U4cBqBAykfKOZLdje_Ec9TjtpTAm4kZh8ajwjeF6u8kCWs5eJITE-DTWjvEO7muvbAOezdzt_ud73oE2dTWVxJpPd83mNAFtqfOiwJRT_j5JGdyZoPoQfioO3AIFgIQnPW_RBklOdkHsG41f2ZrSsC=w1919-h961',
            startDate: DateTime.parse('2022-10-07T13:30:00Z'),
            place: 'Universidad Santiago de Cali',
            name:
                'Foro Nacional de Consejos Departamentales de Ciencia Tecnología e Innovación CODECTI',
            path:
                'foro-nacional-dia-2/private/bxwtbsEQWZaDmybQ9a1g4xEqV4VMHyIk',
            eventMode: '',
            id: '126453'));*/

    // se asigna el arreglo modificado de los eventos a los atributos
    events = responseLocal;
    allEvents = responseLocal;
    notifyListeners();
  }

  getEventsCali() {
    events = allEvents.where((element) => element.city == 'Cali').toList();
    notifyListeners();
  }

  // Se crea función para obtener los eventos del día de hoy
  getEventsToday() {
    events = allEvents
        .where((element) =>
            //Se pregunta si el día del evento es el mismo día de hoy
            element.startDate
                .difference(DateTime.now().subtract(const Duration(days: 1)))
                .inDays ==
            1)
        .toList();
    notifyListeners();
  }

  getEventsPalmira() {
    events = allEvents.where((element) => element.city == 'Palmira').toList();
    notifyListeners();
  }

  restoreFilter() {
    events = allEvents.toList();
    notifyListeners();
  }
}
