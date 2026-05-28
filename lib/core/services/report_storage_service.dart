import 'package:flutter/material.dart';

class ReportStorageService {
  static final ReportStorageService _instance = ReportStorageService._internal();
  factory ReportStorageService() => _instance;
  ReportStorageService._internal();

  List<Report> _reports = [];

  List<Report> get reports => List.unmodifiable(_reports);

  void addReport(Report report) {
    _reports.insert(0, report); // Los nuevos van al inicio
  }

  void clearReports() {
    _reports.clear();
  }

  List<Report> getReportsByFilter({
    String? status,
    String? category,
    String? searchQuery,
  }) {
    List<Report> filtered = List.from(_reports);

    if (status != null && status != 'Todos') {
      filtered = filtered.where((r) => r.status == status).toList();
    }

    if (category != null && category != 'Todas' && category != 'Todos') {
      filtered = filtered.where((r) => r.category == category).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      filtered = filtered.where((r) =>
      r.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          r.location.toLowerCase().contains(searchQuery.toLowerCase()) ||
          r.folio.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  List<Report> getRecentActivity(int limit) {
    return _reports.take(limit).toList();
  }

  Map<String, dynamic> getStatistics() {
    return {
      'total': _reports.length,
      'pendientes': _reports.where((r) => r.status == 'Pendiente').length,
      'enProceso': _reports.where((r) => r.status == 'En proceso').length,
      'resueltos': _reports.where((r) => r.status == 'Resuelto').length,
      'categorias': {
        'Bache': _reports.where((r) => r.category == 'Bache').length,
        'Derrumbe': _reports.where((r) => r.category == 'Derrumbe').length,
        'Inundación': _reports.where((r) => r.category == 'Inundación').length,
        'Señalización': _reports.where((r) => r.category == 'Señalización').length,
        'Accidente': _reports.where((r) => r.category == 'Accidente').length,
      },
    };
  }
}

class Report {
  final String id;
  final String title;
  final String category;
  final String description;
  final String location;
  final String status;
  final String date;
  final String time;
  final String? imagePath;
  final String folio;
  final String risk;
  final double lat;
  final double lng;

  Report({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.location,
    required this.status,
    required this.date,
    required this.time,
    this.imagePath,
    required this.folio,
    required this.risk,
    required this.lat,
    required this.lng,
  });

  factory Report.create({
    required String category,
    required String description,
    required String location,
    String? imagePath,
  }) {
    final now = DateTime.now();
    final folio = 'VIA-${now.year}-${now.millisecond}${now.second}${now.minute}';

    String title;
    switch (category) {
      case 'Bache':
        title = 'Bache reportado en $location';
        break;
      case 'Derrumbe':
        title = 'Derrumbe en $location';
        break;
      case 'Inundación':
        title = 'Inundación en $location';
        break;
      case 'Señalización':
        title = 'Señalización dañada en $location';
        break;
      case 'Accidente':
        title = 'Accidente en $location';
        break;
      default:
        title = 'Reporte en $location';
    }

    return Report(
      id: now.millisecondsSinceEpoch.toString(),
      title: title,
      category: category,
      description: description,
      location: location,
      status: 'Pendiente',
      date: '${now.day}/${now.month}/${now.year}',
      time: '${now.hour}:${now.minute.toString().padLeft(2, '0')}',
      imagePath: imagePath,
      folio: folio,
      risk: _getRiskByCategory(category),
      lat: 16.7569,
      lng: -93.1293,
    );
  }

  static String _getRiskByCategory(String category) {
    switch (category) {
      case 'Derrumbe':
        return 'Crítico';
      case 'Accidente':
        return 'Alto';
      case 'Inundación':
        return 'Alto';
      case 'Bache':
        return 'Moderado';
      default:
        return 'Bajo';
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'location': location,
      'status': status,
      'date': date,
      'time': time,
      'imagePath': imagePath,
      'folio': folio,
      'risk': risk,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      description: map['description'],
      location: map['location'],
      status: map['status'],
      date: map['date'],
      time: map['time'],
      imagePath: map['imagePath'],
      folio: map['folio'],
      risk: map['risk'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }
}