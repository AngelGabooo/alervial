import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import 'package:viatux/routes/app_routes.dart';
import '../widgets/photo_picker.dart';
import '../widgets/category_selector.dart';
import '../widgets/description_field.dart';
import '../widgets/location_picker.dart';
import '../widgets/report_preview.dart';
import 'package:viatux/core/services/report_storage_service.dart';


class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _photoPath;
  String _description = '';
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,
              color: isDark ? Colors.white : AppColors.blueDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Nuevo reporte',
          style: TextStyle(
            fontSize: resp.sp(18),
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppColors.blueDark,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(resp.wp(5)),
          child: Column(
            children: [
              PhotoPicker(
                onPhotoSelected: (path) => setState(() => _photoPath = path),
              ),
              SizedBox(height: resp.hp(2)),
              CategorySelector(
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) => setState(() => _selectedCategory = category),
              ),
              SizedBox(height: resp.hp(2)),
              DescriptionField(
                onChanged: (value) => setState(() => _description = value),
              ),
              SizedBox(height: resp.hp(2)),
              const LocationPicker(),
              SizedBox(height: resp.hp(2)),
              ReportPreview(
                photoPath: _photoPath,
                category: _selectedCategory,
                description: _description,
              ),
              SizedBox(height: resp.hp(3)),
              SizedBox(
                width: double.infinity,
                height: resp.buttonHeight(52),
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 4,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                      : Text(
                    'Enviar reporte',
                    style: TextStyle(fontSize: resp.sp(16), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: resp.hp(3)),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReport() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      await Future.delayed(const Duration(seconds: 1));

      // Crear y guardar el reporte
      final newReport = Report.create(
        category: _selectedCategory!,
        description: _description,
        location: 'Av. Central #123, Tuxtla Gutiérrez',
        imagePath: _photoPath,
      );

      ReportStorageService().addReport(newReport);

      setState(() => _isSubmitting = false);

      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.reportSuccess);
      }
    }
  }
}