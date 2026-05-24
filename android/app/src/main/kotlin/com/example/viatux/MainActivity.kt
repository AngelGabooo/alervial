package com.example.viatux

import android.content.ContentResolver
import android.database.ContentObserver
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.MediaStore
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "screenshot_channel"
    private var contentObserver: ContentObserver? = null
    private var lastScreenshotTime: Long = 0
    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "disableScreenshots" -> {
                    // Bloquear capturas
                    window.setFlags(
                        WindowManager.LayoutParams.FLAG_SECURE,
                        WindowManager.LayoutParams.FLAG_SECURE
                    )
                    // Iniciar detección de capturas
                    startScreenshotDetection()
                    result.success(true)
                }
                "enableScreenshots" -> {
                    // Permitir capturas
                    window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                    // Detener detección
                    stopScreenshotDetection()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startScreenshotDetection() {
        stopScreenshotDetection()

        contentObserver = object : ContentObserver(Handler(Looper.getMainLooper())) {
            override fun onChange(selfChange: Boolean, uri: Uri?) {
                super.onChange(selfChange, uri)
                val currentTime = System.currentTimeMillis()
                if (currentTime - lastScreenshotTime > 2000) {
                    lastScreenshotTime = currentTime
                    methodChannel?.invokeMethod("screenshot_taken", null)
                }
            }
        }

        contentResolver.registerContentObserver(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            true,
            contentObserver!!
        )
    }

    private fun stopScreenshotDetection() {
        contentObserver?.let {
            contentResolver.unregisterContentObserver(it)
        }
        contentObserver = null
    }

    override fun onDestroy() {
        stopScreenshotDetection()
        super.onDestroy()
    }
}