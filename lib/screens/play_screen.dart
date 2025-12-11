import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List<Map<String, dynamic>> _places = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPlaces();
  }

  Future<void> _fetchPlaces() async {
    try {
      // 查询视图，获取带 lat/lng 的数据
      final response = await Supabase.instance.client
          .from('places_with_coords')
          .select();

      if (mounted) {
        setState(() {
          _places = List<Map<String, dynamic>>.from(response);
          _isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching places: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 这里的 body 直接放地图，不再需要 AppBar，因为 MainScaffold 会处理
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(43.70, -79.42), // GTA 中心
          initialZoom: 9.5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: _places.map((place) {
              return Marker(
                point: _parseLocation(place),
                width: 45, // 图标稍微大一点
                height: 45,
                child: _buildCustomPin(place['category']),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ✨ 装修：根据分类返回不同颜色的图标
  Widget _buildCustomPin(String? category) {
    Color color;
    IconData icon;

    switch (category) {
      case 'play_indoor':
        color = Colors.blueAccent;
        icon = Icons.roofing; // 室内图标
        break;
      case 'play_outdoor':
        color = Colors.green;
        icon = Icons.park; // 户外图标
        break;
      case 'daycare':
        color = Colors.purpleAccent;
        icon = Icons.school; // 学校图标
        break;
      default:
        color = Colors.redAccent;
        icon = Icons.location_on;
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2), // 加个白边，更有质感
              boxShadow: [
                BoxShadow(blurRadius: 6, color: Colors.black26, offset: Offset(0, 3))
              ]
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        // 下面这个小三角是为了让它看起来像个大头针 (可选)
        // Icon(Icons.arrow_drop_down, color: color, size: 20),
      ],
    );
  }

  LatLng _parseLocation(Map<String, dynamic> place) {
    try {
      final lat = place['lat'];
      final lng = place['lng'];
      if (lat != null && lng != null) {
        return LatLng(lat.toDouble(), lng.toDouble());
      }
    } catch (e) {
      print('Location parse error: $e');
    }
    return const LatLng(43.65, -79.38);
  }
}