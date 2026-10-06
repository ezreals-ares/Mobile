import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

// ─────────────────────────────────────────────────────────────
// Camera & GPS Feature Page
// ─────────────────────────────────────────────────────────────
class CameraGpsPage extends StatefulWidget {
  const CameraGpsPage({super.key});

  @override
  State<CameraGpsPage> createState() => _CameraGpsPageState();
}

class _CameraGpsPageState extends State<CameraGpsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.deepPurple,
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt), text: 'Camera'),
            Tab(icon: Icon(Icons.location_on), text: 'GPS'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              CameraTab(),
              GpsTab(),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab Camera
// ─────────────────────────────────────────────────────────────
class CameraTab extends StatefulWidget {
  const CameraTab({super.key});

  @override
  State<CameraTab> createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  File? _capturedImage;
  bool _isLoading = false;
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _showLivePreview = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  // Ambil foto menggunakan ImagePicker (galeri/kamera sistem)
  Future<void> _pickFromGallery() async {
    setState(() => _isLoading = true);
    try {
      final XFile? image =
          await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() => _capturedImage = File(image.path));
      }
    } catch (e) {
      _showError('Gagal membuka galeri: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Ambil foto langsung dari kamera sistem
  Future<void> _takePhotoWithSystem() async {
    setState(() => _isLoading = true);
    try {
      final XFile? image =
          await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() => _capturedImage = File(image.path));
      }
    } catch (e) {
      _showError('Gagal membuka kamera: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Inisialisasi kamera in-app (live preview)
  Future<void> _initLiveCamera() async {
    setState(() => _isLoading = true);
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        _showError('Tidak ada kamera yang tersedia');
        setState(() => _isLoading = false);
        return;
      }
      _cameraController = CameraController(
        _cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
        _showLivePreview = true;
      });
    } catch (e) {
      _showError('Gagal menginisialisasi kamera: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Ambil foto dari live preview
  Future<void> _captureFromLive() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      final XFile photo = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = File(photo.path);
        _showLivePreview = false;
      });
      await _cameraController?.dispose();
      _cameraController = null;
      _isCameraInitialized = false;
    } catch (e) {
      _showError('Gagal mengambil foto: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _closeLivePreview() {
    _cameraController?.dispose();
    _cameraController = null;
    setState(() {
      _isCameraInitialized = false;
      _showLivePreview = false;
    });
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header info
          Card(
            color: Colors.deepPurple.shade50,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📷 Fitur Camera',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Gunakan kamera untuk mengambil foto atau pilih dari galeri. '
                    'Didukung oleh package camera & image_picker.',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Live Preview kamera in-app
          if (_showLivePreview && _isCameraInitialized) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: _cameraController!.value.aspectRatio,
                child: CameraPreview(_cameraController!),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _captureFromLive,
                    icon: const Icon(Icons.camera),
                    label: const Text('Ambil Foto'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _closeLivePreview,
                  icon: const Icon(Icons.close),
                  label: const Text('Tutup'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          // Tombol aksi kamera
          if (!_showLivePreview) ...[
            // Tombol kamera sistem (via ImagePicker)
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _takePhotoWithSystem,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Ambil Foto (Kamera Sistem)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 8),

            // Tombol live preview kamera in-app
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _initLiveCamera,
              icon: const Icon(Icons.videocam),
              label: const Text('Buka Live Preview Kamera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 8),

            // Tombol galeri
            OutlinedButton.icon(
              onPressed: _isLoading ? null : _pickFromGallery,
              icon: const Icon(Icons.photo_library),
              label: const Text('Pilih dari Galeri'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Loading indicator
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),

          // Hasil foto
          if (_capturedImage != null) ...[
            const Text(
              'Foto Hasil:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                _capturedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 280,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Path: ${_capturedImage!.path}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => setState(() => _capturedImage = null),
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text('Hapus Foto',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab GPS
// ─────────────────────────────────────────────────────────────
class GpsTab extends StatefulWidget {
  const GpsTab({super.key});

  @override
  State<GpsTab> createState() => _GpsTabState();
}

class _GpsTabState extends State<GpsTab> {
  Position? _currentPosition;
  bool _isLoading = false;
  String _statusMessage = 'Tekan tombol untuk mendapatkan lokasi.';
  final List<Position> _locationHistory = [];

  // Cek & minta permission lokasi
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() =>
          _statusMessage = 'GPS tidak aktif. Aktifkan GPS di pengaturan.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _statusMessage = 'Izin lokasi ditolak.');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _statusMessage =
          'Izin lokasi ditolak permanen. Buka pengaturan aplikasi.');
      return false;
    }

    return true;
  }

  // Ambil lokasi saat ini
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Mengambil lokasi...';
    });

    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      setState(() {
        _currentPosition = position;
        _statusMessage = 'Lokasi berhasil didapatkan!';
        _locationHistory.insert(0, position);
        if (_locationHistory.length > 5) _locationHistory.removeLast();
      });
    } catch (e) {
      setState(() => _statusMessage = 'Gagal mendapatkan lokasi: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Hitung jarak antara dua titik (demo)
  String _calculateDistance(Position from, Position to) {
    final distanceInMeters = Geolocator.distanceBetween(
      from.latitude,
      from.longitude,
      to.latitude,
      to.longitude,
    );
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toStringAsFixed(1)} m';
    }
    return '${(distanceInMeters / 1000).toStringAsFixed(2)} km';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header info
          Card(
            color: Colors.green.shade50,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📍 Fitur GPS / Lokasi',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Dapatkan koordinat GPS perangkat secara real-time. '
                    'Didukung oleh package geolocator.',
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Status
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(
                  _currentPosition != null
                      ? Icons.check_circle
                      : Icons.info_outline,
                  color: _currentPosition != null
                      ? Colors.green
                      : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _statusMessage,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tombol ambil lokasi
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _getCurrentLocation,
            icon: _isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.my_location),
            label: Text(_isLoading ? 'Mengambil...' : 'Dapatkan Lokasi Saya'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 16),

          // Data lokasi saat ini
          if (_currentPosition != null) ...[
            const Text(
              'Koordinat Saat Ini:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _locationCard(_currentPosition!),
            const SizedBox(height: 16),
          ],

          // Riwayat lokasi
          if (_locationHistory.length >= 2) ...[
            const Text(
              'Riwayat & Jarak:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...List.generate(_locationHistory.length, (i) {
              final pos = _locationHistory[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.shade100,
                    child: Text('${i + 1}',
                        style:
                            const TextStyle(color: Colors.green)),
                  ),
                  title: Text(
                    'Lat: ${pos.latitude.toStringAsFixed(6)}\nLng: ${pos.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 13),
                  ),
                  subtitle: i < _locationHistory.length - 1
                      ? Text(
                          'Jarak dari titik berikut: '
                          '${_calculateDistance(pos, _locationHistory[i + 1])}',
                          style: const TextStyle(color: Colors.orange),
                        )
                      : null,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '±${pos.accuracy.toStringAsFixed(0)}m',
                        style: const TextStyle(
                            fontSize: 11, color: Colors.grey),
                      ),
                      Text(
                        '${pos.speed.toStringAsFixed(1)} m/s',
                        style: const TextStyle(
                            fontSize: 11, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],

          // Info tambahan GPS
          if (_currentPosition != null) ...[
            const SizedBox(height: 8),
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Detail Tambahan:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _infoRow('Altitude',
                        '${_currentPosition!.altitude.toStringAsFixed(2)} m'),
                    _infoRow('Accuracy',
                        '±${_currentPosition!.accuracy.toStringAsFixed(2)} m'),
                    _infoRow('Heading',
                        '${_currentPosition!.heading.toStringAsFixed(2)}°'),
                    _infoRow('Speed',
                        '${_currentPosition!.speed.toStringAsFixed(2)} m/s'),
                    _infoRow(
                        'Timestamp',
                        _currentPosition!.timestamp
                            .toLocal()
                            .toString()
                            .substring(0, 19)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => setState(() {
                _currentPosition = null;
                _locationHistory.clear();
                _statusMessage = 'Tekan tombol untuk mendapatkan lokasi.';
              }),
              icon: const Icon(Icons.clear),
              label: const Text('Reset Lokasi'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _locationCard(Position position) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.location_on, color: Colors.red, size: 40),
            const SizedBox(height: 8),
            _infoRow('Latitude',
                position.latitude.toStringAsFixed(7)),
            _infoRow('Longitude',
                position.longitude.toStringAsFixed(7)),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 13, color: Colors.black54)),
          Text(value,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
