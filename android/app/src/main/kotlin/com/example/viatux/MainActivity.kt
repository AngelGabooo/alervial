package com.example.viatux

import android.os.Bundle  // ← AGREGAR ESTA IMPORTACIÓN
import android.view.WindowManager  // ← AGREGAR ESTA IMPORTACIÓN
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {  // ← AGREGAR TODO ESTE MÉTODO
        super.onCreate(savedInstanceState)

        // 🔒 BLOQUEAR CAPTURAS DE PANTALLA
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE
        )
    }
}