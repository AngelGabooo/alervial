import 'package:flutter/material.dart';
import 'package:viatux/core/constants/colors.dart';
import 'package:viatux/core/utils/responsive.dart';
import '../widgets/comment_header.dart';
import '../widgets/comment_card.dart';
import '../widgets/evidence_gallery.dart';
import '../widgets/add_comment_input.dart';
import '../widgets/comment_filters.dart';

class CommentsEvidencesPage extends StatefulWidget {
  const CommentsEvidencesPage({super.key});

  @override
  State<CommentsEvidencesPage> createState() => _CommentsEvidencesPageState();
}

class _CommentsEvidencesPageState extends State<CommentsEvidencesPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final TextEditingController _commentController = TextEditingController();

  String _selectedFilter = 'Todos';
  String _selectedDateFilter = 'Hoy';
  List<Map<String, dynamic>> _comments = [];

  // Estado para nueva evidencia
  String? _newImagePath;
  String? _newLocation;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() {
    _comments = [
      {
        'id': '1',
        'userName': 'María González',
        'userRole': 'Ciudadano',
        'userAvatar': 'M',
        'time': 'Hace 2 horas',
        'comment': 'Ya paso por aquí y el bache sigue igual. Espero que las autoridades puedan atenderlo pronto. Es muy peligroso para los motociclistas.',
        'imageUrl': null,
        'likes': 12,
        'comments': 3,
        'isOfficial': false,
      },
      {
        'id': '2',
        'userName': 'Autoridad Municipal',
        'userRole': 'Autoridad',
        'userAvatar': 'A',
        'time': 'Hace 5 horas',
        'comment': 'Hemos recibido su reporte. El equipo de mantenimiento ha sido notificado y estará atendiendo la zona en las próximas 24 horas.',
        'imageUrl': null,
        'likes': 45,
        'comments': 8,
        'isOfficial': true,
      },
      {
        'id': '3',
        'userName': 'Carlos Méndez',
        'userRole': 'Ciudadano',
        'userAvatar': 'C',
        'time': 'Ayer, 18:30',
        'comment': 'Adjunto foto del estado actual del bache. Está empeorando rápidamente.',
        'imageUrl': 'https://picsum.photos/200/150?random=1',
        'likes': 8,
        'comments': 2,
        'isOfficial': false,
      },
    ];
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loadComments();
    });
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;

    final newComment = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'userName': 'Ángel López',
      'userRole': 'Ciudadano',
      'userAvatar': 'A',
      'time': 'Ahora mismo',
      'comment': _commentController.text.trim(),
      'imageUrl': _newImagePath,
      'likes': 0,
      'comments': 0,
      'isOfficial': false,
    };

    setState(() {
      _comments.insert(0, newComment);
      _commentController.clear();
      _newImagePath = null;
      _newLocation = null;
    });

    // Mostrar confirmación
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comentario publicado'),
        backgroundColor: AppColors.softGreen,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _addImage() {
    // Simular selección de imagen
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded),
                title: const Text('Tomar foto'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _newImagePath = 'new_photo_${DateTime.now().millisecondsSinceEpoch}';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cámara - Próximamente')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded),
                title: const Text('Elegir de galería'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _newImagePath = 'gallery_${DateTime.now().millisecondsSinceEpoch}';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Galería - Próximamente')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on_rounded),
                title: const Text('Compartir ubicación'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _newLocation = 'Av. Central #123, Tuxtla Gtz';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ubicación agregada')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.resp;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        color: AppColors.blueBright,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: CommentHeader()),
            SliverToBoxAdapter(
              child: CommentFilters(
                selectedFilter: _selectedFilter,
                selectedDateFilter: _selectedDateFilter,
                onFilterSelected: (filter) {
                  setState(() => _selectedFilter = filter);
                },
                onDateFilterSelected: (dateFilter) {
                  setState(() => _selectedDateFilter = dateFilter);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: resp.wp(5)),
                child: const EvidenceGallery(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(resp.wp(5)),
                child: Row(
                  children: [
                    Text(
                      'Comentarios',
                      style: TextStyle(
                        fontSize: resp.sp(18),
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_comments.length} comentarios',
                      style: TextStyle(
                        fontSize: resp.sp(12),
                        color: isDark ? Colors.grey[500] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => CommentCard(
                  comment: _comments[index],
                  onLike: () {
                    setState(() {
                      _comments[index]['likes']++;
                    });
                  },
                ),
                childCount: _comments.length,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: resp.hp(10))),
          ],
        ),
      ),
      bottomNavigationBar: AddCommentInput(
        controller: _commentController,
        onSend: _addComment,
        onAddImage: _addImage,
      ),
    );
  }
}