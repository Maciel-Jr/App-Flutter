import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;

  void _onMapCreated(MapboxMap map) {
    mapboxMap = map;

    // Ativa o puck de localização (o "carrinho" do Waze)
    map.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. O Mapa 3D
          MapWidget(
            key: const ValueKey('mapWidget'),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            cameraOptions: CameraOptions(
              center: Point(coordinates: Position(-60.003566,-3.068117)), // Ex: Av. Paulista
              zoom: 16.5,
              pitch: 55.0, // Inclinação 3D do Waze
              bearing: 0.0,
            ),
            onMapCreated: _onMapCreated,
          ),

          // 2. Banner Superior: Próxima Manobra
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0038FF), // Azul marcante do topo do Waze
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.turn_right_rounded, color: Colors.white, size: 40),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'A 300 m',
                              style: TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                            Text(
                              'Vire à direita na Av. Brasil',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Velocímetro Circular (Inferior Esquerdo)
          Positioned(
            left: 16,
            bottom: 110,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 2),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '60',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1),
                  ),
                  Text('km/h', style: TextStyle(fontSize: 9, color: Colors.grey)),
                ],
              ),
            ),
          ),

          // 4. Botão de Reportar Incidentes (Inferior Direito)
          Positioned(
            right: 16,
            bottom: 110,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFFFF8A00), // Laranja de alerta
              child: const Icon(Icons.report_problem_rounded, color: Colors.white),
              onPressed: () {
                // Abre o modal de reportar trânsito/polícia/acidente
              },
            ),
          ),

          // 5. Card Inferior: Tempo Estimado e Chegada
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '18:45',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Chegada estimada',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '24 min',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal,
                          ),
                        ),
                        Text('14 km', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.grey, size: 28),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}