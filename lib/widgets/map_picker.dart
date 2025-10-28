import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apolo_project/services/location_service.dart';

class MapPicker extends StatefulWidget {
  final LatLng? initialPosition;
  final Function(LatLng, String) onLocationSelected;

  const MapPicker({
    super.key,
    this.initialPosition,
    required this.onLocationSelected,
  });

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  late GoogleMapController _mapController;
  LatLng _selectedPosition = const LatLng(-23.5505, -46.6333); // SP default
  String _address = 'Selecione no mapa';
  final TextEditingController _searchCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialPosition != null) {
      _selectedPosition = widget.initialPosition!;
      _updateAddress();
    }
  }

  void _updateAddress() async {
    setState(() => _isLoading = true);
    final addr = await LocationService.getAddressFromLatLng(_selectedPosition);
    setState(() {
      _address = addr ?? 'Localização selecionada';
      _isLoading = false;
    });
  }

  void _onMapTap(LatLng position) {
    setState(() {
      _selectedPosition = position;
      _isLoading = true;
    });
    _updateAddress();
    widget.onLocationSelected(position, _address);
  }

  void _searchLocation() async {
    final query = _searchCtrl.text;
    if (query.isEmpty) return;
    setState(() => _isLoading = true);
    final position = await LocationService.getLatLngFromAddress(query);
    if (position != null) {
      _selectedPosition = position;
      _mapController.animateCamera(CameraUpdate.newLatLng(position));
      _updateAddress();
      widget.onLocationSelected(position, _address);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Localização não encontrada')),
      );
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Buscar cidade ou CEP...',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onSubmitted: (_) => _searchLocation(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: _searchLocation,
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) => _mapController = controller,
                initialCameraPosition: CameraPosition(
                  target: _selectedPosition,
                  zoom: 12,
                ),
                onTap: _onMapTap,
                markers: {
                  Marker(
                    markerId: const MarkerId('selected'),
                    position: _selectedPosition,
                  ),
                },
              ),
              if (_isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_address, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}