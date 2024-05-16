import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EmergencyPointsMapPage extends StatefulWidget {
  @override
  _EmergencyPointsMapPageState createState() => _EmergencyPointsMapPageState();
}

class _EmergencyPointsMapPageState extends State<EmergencyPointsMapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(-20.2675, -50.5444); // Coordenadas de Jales, SP
  MapType _currentMapType = MapType.normal;

  // Lista de coordenadas de postos de emergência em Jales, SP
  List<LatLng> emergencyLocationsInJales = [
    LatLng(-20.2726, -50.5423), // Hospital de Amor (HC de Jales)
    LatLng(-20.2691, -50.5476), // Santa Casa de Misericórdia de Jales
    LatLng(-20.2742, -50.5448), // Pronto Socorro Municipal de Jales
    // Adicione mais coordenadas conforme necessário
  ];

  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      // Adiciona marcadores para cada coordenada de posto de emergência em Jales, SP
      _markers = emergencyLocationsInJales.map((LatLng location) {
        return Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Ícone do marcador
          infoWindow: InfoWindow(
            title: 'Posto de Emergência',
            snippet: 'Descrição do posto de emergência',
          ),
        );
      }).toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pontos de Emergência em Jales, SP'),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              setState(() {
                _currentMapType = _currentMapType == MapType.normal
                    ? MapType.satellite
                    : MapType.normal;
              });
            },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: _currentMapType,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 13.0,
        ),
        markers: _markers, // Adiciona os marcadores ao mapa
        myLocationEnabled: true, // Habilita a localização do usuário
      ),
    );
  }
}
