import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ubicate_usc/models/models.dart';
import 'package:ubicate_usc/providers/providers.dart';
import 'package:ubicate_usc/utils/color_string_util.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

const LatLng _kMapCenter = LatLng(3.4027907796221877, -76.5477074668895);

class _RouteScreenState extends State<RouteScreen> {
  late GoogleMapController _controller;
  final LocationProvider _locationProvider = LocationProvider();

  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  int _polylineIdCounter = 0;
  MapType _mapType = MapType.normal;
  FaIcon _iconMapType = const FaIcon(FontAwesomeIcons.satellite);
  String _colorName = "blue";

  Set<Marker> markers = {};

  @override
  void initState() {
    // addMarkers();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // addMarkers() async {
  //   final Uint8List soccerIcon =
  //       await getBytesFromAsset('assets/mapIcons/soccer-field.png', 100);

  //   BitmapDescriptor markerBitmap = await BitmapDescriptor.fromAssetImage(
  //     ImageConfiguration(size: Size(48, 48)),
  //     'assets/soccer-field.png',
  //   );

  //   markers.add(
  //     Marker(
  //       markerId: MarkerId("soccer1"),
  //       position: LatLng(3.403487165018921, -76.54907446938833),
  //       infoWindow: InfoWindow(
  //         title: "Cancha de Fútbol",
  //         snippet: "I don't know",
  //       ),
  //       icon: BitmapDescriptor.fromBytes(soccerIcon),
  //     ),
  //   );

  //   markers.add(
  //     Marker(
  //       markerId: MarkerId("soccer2"),
  //       position: LatLng(3.402945628667238, -76.54855771656997),
  //       infoWindow: InfoWindow(
  //         title: "Cancha de Fútbol",
  //         snippet: "I don't know",
  //       ),
  //       icon: BitmapDescriptor.fromBytes(soccerIcon),
  //     ),
  //   );
  // }

  void _add(List<dynamic> route) {
    polylines.clear();

    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: getColor(_colorName)!,
      width: 5,
      points: _createPoints(route),
    );
    polylines[polylineId] = polyline;
  }

  final CameraPosition _initalCameraPosition = const CameraPosition(
    target: LatLng(3.4028615937943503, -76.54821359604487),
    zoom: 17.5,
  );

  void _toggleMapType() {
    if (_mapType == MapType.normal) {
      _mapType = MapType.satellite;
      _colorName = "white";
      _iconMapType = const FaIcon(FontAwesomeIcons.mapMarkedAlt);
    } else {
      _mapType = MapType.normal;
      _colorName = "blue";
      _iconMapType = const FaIcon(FontAwesomeIcons.satellite);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Direction;
    final RoutesProvider routesProvider = RoutesProvider();

    return FutureBuilder(
      future: routesProvider.getRouteByName(args.entry, args.destination),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          _add(snapshot.data);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Mapa'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const FaIcon(FontAwesomeIcons.chevronLeft)),
            ),
            body: Stack(
              children: [
                // Habilitar gestos
                GoogleMap(
                  mapType: _mapType,
                  initialCameraPosition: _initalCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                  markers: markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  rotateGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  indoorViewEnabled: false,
                  polylines: Set<Polyline>.of(polylines.values),
                  scrollGesturesEnabled: true,
                  // markers: <Marker>{_createMark()},
                ),
              ],
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // FloatingActionButton(
                //   child: const FaIcon(FontAwesomeIcons.route),
                //   onPressed: () {
                //     // _showLocationDialog(context, _locationProvider.locationData);
                //   },
                // ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 1,
                  child: _iconMapType,
                  onPressed: _toggleMapType,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Marker _createMark() {
  //   if (_markerIcon != null) {
  //     print("test");
  //     return Marker(
  //       markerId: const MarkerId('marker_1'),
  //       position: _kMapCenter,
  //       icon: _markerIcon!,
  //       infoWindow: InfoWindow(title: "Test", snippet: "*"),
  //     );
  //   } else {
  //     print("else");
  //     return const Marker(
  //       markerId: MarkerId('marker_1'),
  //       position: _kMapCenter,
  //       infoWindow: InfoWindow(title: "marker_1", snippet: "*"),
  //       onTap: null,
  //     );
  //   }
  // }

  List<LatLng> _createPoints(List<dynamic> route) {
    final List<LatLng> points = <LatLng>[];
    for (var coordinates in route) {
      points.add(
          _createLatLng(coordinates['latitude'], coordinates['longitude']));
    }
    return points;
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }
}
