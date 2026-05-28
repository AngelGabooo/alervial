lib/
│
├── main.dart                                      # Punto de entrada (registra ScreenshotService)
├── app.dart                                       # Configuración principal de MaterialApp
│
├── core/
│   ├── constants/
│   │   ├── colors.dart                            # Colores de la app (claro/oscuro)
│   │   ├── text_styles.dart                       # Estilos de texto responsivos
│   │   └── assets.dart                            # Rutas de assets (imágenes, iconos)
│   │
│   ├── themes/
│   │   └── app_theme.dart                         # Tema claro/oscuro de Material Design 3
│   │
│   ├── utils/
│   │   └── responsive.dart                        # Sistema responsivo (wp, hp, sp, etc.)
│   │
│   ├── services/
│   │   ├── screenshot_service.dart                # Bloquear/permite capturas en Login
│   │   ├── screenshot_detector.dart               # Detector de capturas (opcional)
│   │   └── report_storage_service.dart            # Almacenamiento local de reportes
│   │
│   └── widgets/
│       ├── gradient_background.dart               # Fondo con degradado + patrón
│       ├── premium_card.dart                      # Card con efecto de selección
│       ├── page_indicator.dart                    # Indicador de páginas (onboarding)
│       ├── screenshot_alert.dart                  # Alerta estilo WhatsApp
│       └── screenshot_blocker_overlay.dart        # Overlay para bloqueo
│
├── routes/
│   └── app_routes.dart                            # Definición de todas las rutas (24 rutas unificadas)
│
├── features/
│   │
│   ├── splash/                                    # ✅ VISTA 1
│   │   ├── pages/
│   │   │   └── splash_page.dart
│   │   └── widgets/
│   │       ├── animated_logo.dart
│   │       └── loading_indicator.dart
│   │
│   ├── onboarding/                                # ✅ VISTA 2
│   │   ├── pages/
│   │   │   └── onboarding_page.dart
│   │   └── widgets/
│   │       ├── onboarding_slide.dart
│   │       └── navigation_buttons.dart
│   │
│   ├── role_selection/                            # ✅ VISTA 3
│   │   ├── pages/
│   │   │   └── role_selection_page.dart
│   │   └── widgets/
│   │       ├── role_card.dart
│   │       └── role_header.dart
│   │
│   ├── welcome/                                   # ✅ VISTA 4
│   │   ├── pages/
│   │   │   └── welcome_page.dart
│   │   └── widgets/
│   │       ├── welcome_header.dart
│   │       ├── welcome_illustration.dart
│   │       └── action_buttons.dart
│   │
│   ├── register/                                  # ✅ VISTA 5
│   │   ├── pages/
│   │   │   └── register_page.dart
│   │   └── widgets/
│   │       ├── register_form.dart
│   │       ├── password_field.dart
│   │       └── social_buttons.dart
│   │
│   ├── login/                                     # ✅ VISTA 6
│   │   ├── pages/
│   │   │   └── login_page.dart
│   │   └── widgets/
│   │       ├── login_form.dart
│   │       ├── remember_me.dart
│   │       └── social_login.dart
│   │
│   ├── forgot_password/                           # ✅ VISTA 7
│   │   ├── pages/
│   │   │   └── forgot_password_page.dart
│   │   └── widgets/
│   │       ├── forgot_password_form.dart
│   │       └── forgot_password_illustration.dart
│   │
│   ├── home/                                      # ✅ VISTA 8
│   │   ├── pages/
│   │   │   └── home_page.dart
│   │   └── widgets/
│   │       ├── bottom_nav_bar.dart
│   │       ├── home_header.dart
│   │       ├── stats_card.dart
│   │       ├── nearby_incidents.dart
│   │       ├── mini_map.dart
│   │       └── recent_activity.dart
│   │
│   ├── nearby_reports/                            # ✅ VISTA 9
│   │   ├── pages/
│   │   │   └── nearby_reports_page.dart
│   │   └── widgets/
│   │       ├── report_header.dart
│   │       ├── location_card.dart
│   │       ├── filter_chips.dart
│   │       └── report_card.dart
│   │
│   ├── interactive_map/                           # ✅ VISTA 10
│   │   ├── pages/
│   │   │   └── interactive_map_page.dart
│   │   └── widgets/
│   │       ├── map_header.dart
│   │       ├── custom_marker.dart
│   │       ├── bottom_sheet_detail.dart
│   │       └── floating_buttons.dart
│   │
│   ├── risk_zones/                                # ✅ VISTA 11
│   │   ├── pages/
│   │   │   └── risk_zones_page.dart
│   │   └── widgets/
│   │       ├── risk_header.dart
│   │       ├── risk_map.dart
│   │       ├── risk_bottom_sheet.dart
│   │       └── alert_card.dart
│   │
│   ├── create_report/                             # ✅ VISTA 12
│   │   ├── pages/
│   │   │   └── create_report_page.dart
│   │   └── widgets/
│   │       ├── photo_picker.dart
│   │       ├── category_selector.dart
│   │       ├── description_field.dart
│   │       ├── location_picker.dart
│   │       └── report_preview.dart
│   │
│   ├── report_success/                            # ✅ VISTA 13
│   │   ├── pages/
│   │   │   └── report_success_page.dart
│   │   └── widgets/
│   │       ├── success_animation.dart
│   │       ├── info_card.dart
│   │       └── timeline_steps.dart
│   │
│   ├── report_detail/                             # ✅ VISTA 14
│   │   ├── pages/
│   │   │   └── report_detail_page.dart
│   │   └── widgets/
│   │       ├── report_image.dart
│   │       ├── info_section.dart
│   │       ├── progress_timeline.dart
│   │       ├── mini_map_detail.dart
│   │       ├── comments_section.dart
│   │       └── action_buttons.dart
│   │
│   ├── comments_evidences/                        # ✅ VISTA 15
│   │   ├── pages/
│   │   │   └── comments_evidences_page.dart
│   │   └── widgets/
│   │       ├── comment_header.dart
│   │       ├── comment_card.dart
│   │       ├── evidence_gallery.dart
│   │       ├── add_comment_input.dart
│   │       └── comment_filters.dart
│   │
│   ├── my_reports/                                # ✅ VISTA 16
│   │   ├── pages/
│   │   │   └── my_reports_page.dart
│   │   └── widgets/
│   │       ├── reports_header.dart
│   │       ├── report_summary_card.dart
│   │       ├── filter_chips_reports.dart
│   │       ├── report_list_card.dart
│   │       ├── empty_reports_state.dart
│   │       └── report_search_bar.dart
│   │
│   ├── history/                                   # ✅ VISTA 17
│   │   ├── pages/
│   │   │   └── history_page.dart
│   │   └── widgets/
│   │       ├── history_header.dart
│   │       ├── history_summary.dart
│   │       ├── history_filters.dart
│   │       ├── timeline_event.dart
│   │       ├── stats_charts.dart
│   │       └── empty_history.dart
│   │
│   ├── recent_activity_feed/                      # ✅ VISTA 18
│   │   ├── pages/
│   │   │   └── recent_activity_feed_page.dart
│   │   └── widgets/
│   │       ├── feed_header.dart
│   │       ├── featured_card.dart
│   │       ├── feed_filters.dart
│   │       ├── activity_card.dart
│   │       └── trending_section.dart
│   │
│   ├── notifications/                             # ✅ VISTA 19
│   │   ├── pages/
│   │   │   └── notifications_page.dart
│   │   └── widgets/
│   │       ├── notification_header.dart
│   │       ├── notification_filters.dart
│   │       ├── notification_card.dart
│   │       └── empty_notifications.dart
│   │
│   ├── smart_alerts/                              # ✅ VISTA 20
│   │   ├── pages/
│   │   │   └── smart_alerts_page.dart
│   │   └── widgets/
│   │       ├── alert_header.dart
│   │       ├── critical_alert_card.dart
│   │       ├── alert_list_card.dart
│   │       ├── alert_mini_map.dart
│   │       └── recommendations_section.dart
│   │
│   │  ⚡ NUEVAS CARPETAS INTEGRADAS DE MANERA LIMPIA:
│   │
│   ├── personal_stats/                            # ⭐ VISTA 21 (Estadísticas Personales)
│   │   ├── pages/
│   │   │   └── personal_stats_page.dart
│   │   └── widgets/
│   │       ├── activity_chart.dart
│   │       ├── metric_grid.dart
│   │       ├── personal_profile_card.dart
│   │       └── progression_card.dart
│   │
│   ├── gamification/                              # ⭐ VISTA 22 (Sistema de Gamificación)
│   │   ├── pages/
│   │   │   └── gamification_page.dart
│   │   └── widgets/
│   │       ├── badges_grid.dart
│   │       ├── challenge_list.dart
│   │       ├── leaderboard_view.dart
│   │       └── neon_level_card.dart
│   │
│   ├── favorites/                                 # ⭐ VISTA 23 (Panel de Favoritos)
│   │   ├── pages/
│   │   │   └── favorites_page.dart
│   │   └── widgets/
│   │       ├── favorite_report_card.dart          # Cards en rejilla de 2 columnas
│   │       ├── favorite_tab_bar.dart              # Selector de Reportes/Zonas/Municipios
│   │       └── empty_favorites_state.dart         # Estado vacío elegante
│   │
│   └── intelligent_search/                        # ⭐ VISTA 24 (Búsqueda Avanzada AI)
│       ├── pages/
│       │   └── intelligent_search_page.dart
│       └── widgets/
│           ├── search_header_bar.dart             # Barra de búsqueda con micro y geolocalización
│           ├── search_filter_chips.dart           # Chips horizontales filtrables
│           ├── trending_searches.dart             # Sección de búsquedas sugeridas y recientes
│           ├── live_map_card.dart                 # Previsualización del mapa interactivo mini
│           └── search_results_grid.dart           # Rejilla adaptativa de resultados encontrados
│
└── shared/                                        # Elementos compartidos entre features
    ├── widgets/
    │   ├── premium_card.dart
    │   └── modern_app_bar.dart
    └── extensions/
        └── context_extensions.dart
