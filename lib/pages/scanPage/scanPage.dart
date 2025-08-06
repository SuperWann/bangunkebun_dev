import 'dart:io';

import 'package:bangunkebun_dev/models/modelScan.dart';
import 'package:bangunkebun_dev/services/roboflowService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanPage extends StatefulWidget {
  static const routeName = '/scanPage';
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    File? selectedImage;
    bool isLoading = false;
    final ImagePicker picker = ImagePicker();

    final RoboflowService roboflowService = RoboflowService();
    List<DiseaseDetectionResult> detectionResults = [];

    void showErrorDialog(String message) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Error'),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }

    void showInfoDialog(String message) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Info'),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }

    Future<void> detectDisease() async {
      if (selectedImage == null) return;

      setState(() {
        isLoading = true;
        detectionResults.clear();
      });

      try {
        // Coba dengan multipart request terlebih dahulu
        Map<String, dynamic> result;
        try {
          result = await roboflowService.detectDisease(selectedImage!);
        } catch (e) {
          // Jika multipart gagal, coba dengan base64
          print('Multipart failed, trying base64: $e');
          result = await roboflowService.detectDiseaseBase64(selectedImage!);
        }

        List<DiseaseDetectionResult> detections = [];

        // Parse predictions dari response
        if (result['predictions'] != null && result['predictions'] is List) {
          for (var prediction in result['predictions']) {
            detections.add(DiseaseDetectionResult.fromJson(prediction));
          }
        }

        // Sort berdasarkan confidence tertinggi
        detections.sort((a, b) => b.confidence.compareTo(a.confidence));

        setState(() {
          detectionResults = detections;
        });

        if (detections.isEmpty) {
          showInfoDialog('Tidak ditemukan penyakit pada gambar cabai ini.');
        } else {
          // Tampilkan hasil dengan confidence tertinggi
          String topResult = detections.first.className;
          double topConfidence = detections.first.confidence;
          showInfoDialog(
            'Deteksi selesai!\nPenyakit utama: $topResult (${(topConfidence * 100).toStringAsFixed(1)}%)',
          );
        }
      } catch (e) {
        showErrorDialog('Gagal mendeteksi penyakit: $e');
        print('Detection error: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

    String getDiseaseTreatment(String diseaseName) {
      // Treatment suggestions untuk penyakit cabai
      Map<String, String> treatments = {
        'anthracnose':
            'Gunakan fungisida berbahan aktif tembaga, pangkas daun terinfeksi, dan pastikan sirkulasi udara baik',
        'bacterial_spot':
            'Aplikasikan bakterisida, hindari penyiraman dari atas, dan berikan jarak tanam yang cukup',
        'cercospora_leaf_spot':
            'Semprot dengan fungisida sistemik, buang daun yang terinfeksi, dan jaga kelembaban udara',
        'leaf_curl':
            'Kendalikan vektor (kutu putih), gunakan insektisida, dan tanam varietas tahan',
        'leaf_spot':
            'Semprot dengan fungisida, perbaiki drainase, dan hindari kelembaban berlebih',
        'mosaic_virus':
            'Tidak ada obat, kendalikan vektor (thrips, kutu daun), dan cabut tanaman terinfeksi',
        'powdery_mildew':
            'Gunakan fungisida anti jamur tepung, tingkatkan sirkulasi udara, dan kurangi kelembaban',
        'rust':
            'Aplikasikan fungisida berbahan tembaga, buang daun terinfeksi, dan pastikan drainase baik',
        'whitefly':
            'Gunakan insektisida sistemik, pasang perangkap kuning, dan kendalikan gulma sekitar',
        'yellowish':
            'Periksa nutrisi tanaman, pastikan drainase baik, dan cek adanya hama atau penyakit lain',
        'healthy':
            'Tanaman cabai dalam kondisi sehat! Lanjutkan perawatan rutin dengan penyiraman teratur dan pemupukan seimbang',
      };

      // Bersihkan nama penyakit dan cocokkan
      String cleanedName =
          diseaseName
              .toLowerCase()
              .replaceAll('_', ' ')
              .replaceAll('-', ' ')
              .trim();

      // Cari berdasarkan kata kunci
      for (String key in treatments.keys) {
        if (cleanedName.contains(key) || key.contains(cleanedName)) {
          return treatments[key]!;
        }
      }

      return 'Konsultasikan dengan ahli pertanian untuk penanganan penyakit "$diseaseName" yang tepat. Pastikan sanitasi kebun dan monitoring rutin.';
    }

    Widget buildResultCard(DiseaseDetectionResult result) {
      Color cardColor =
          result.confidence > 0.7 ? Colors.red.shade50 : Colors.orange.shade50;
      Color borderColor = result.confidence > 0.7 ? Colors.red : Colors.orange;

      return Card(
        margin: EdgeInsets.only(bottom: 10),
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: borderColor, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      result.className,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // color: borderColor.shade700,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${(result.confidence * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                getDiseaseTreatment(result.className),
                style: TextStyle(color: Colors.grey[700], fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    Future<void> pickImage(ImageSource source) async {
      if (source == ImageSource.camera) {
        final cameraStatus = await Permission.camera.request();
        if (cameraStatus.isDenied) return;
      }

      try {
        final XFile? image = await picker.pickImage(
          source: source,
          maxWidth: 1920,
          maxHeight: 1080,
          imageQuality: 80,
        );
        if (image != null) {
          setState(() {
            selectedImage = File(image.path);
          });
          print(selectedImage);
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Deteksi Penyakit tanaman')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          selectedImage == null
              ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 233, 233, 233),
                ),
                height: MediaQuery.of(context).size.height * 0.25,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Pilih atau ambil gambar',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              )
              : Container(
                height: MediaQuery.of(context).size.height * 0.25,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: FileImage(selectedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(
                        255,
                        233,
                        233,
                        233,
                      ).withOpacity(0.8),
                      child: Icon(Icons.edit, color: Colors.black),
                    ),
                  ),
                  onTap: () {
                    // _pickImage();
                  },
                ),
              ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt),
                  label: Text('Kamera'),
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo_library),
                  label: Text('Galeri'),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed:
                selectedImage != null && !isLoading ? detectDisease : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15),
              textStyle: TextStyle(fontSize: 16),
            ),
            child:
                isLoading
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Mendeteksi...'),
                      ],
                    )
                    : Text('Deteksi Penyakit'),
          ),

          SizedBox(height: 20),

          // Hasil deteksi
          if (detectionResults.isNotEmpty) ...[
            Text(
              'Hasil Deteksi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...detectionResults.map((result) => buildResultCard(result)),
          ],
        ],
      ),
    );
  }
}
