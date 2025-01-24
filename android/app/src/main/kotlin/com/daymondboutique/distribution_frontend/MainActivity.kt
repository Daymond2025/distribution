package com.daymondboutique.distribution_frontend


import android.content.ContentValues
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.OutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.daymondboutique.distribution_frontend/media_store"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "saveImageToGallery") {
                val imagePath: String? = call.argument("imagePath")
                if (imagePath != null) {
                    val isSaved = saveImageToGallery(imagePath)
                    if (isSaved) {
                        result.success("Image enregistrée avec succès")
                    } else {
                        result.error("SAVE_FAILED", "Échec de l'enregistrement", null)
                    }
                } else {
                    result.error("INVALID_ARGUMENT", "Chemin de l'image invalide", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

   private fun saveImageToGallery(imagePath: String): Boolean {
    return try {
        val bitmap = BitmapFactory.decodeFile(imagePath)
        val filename = "IMG_${System.currentTimeMillis()}.jpg"

        val contentValues = ContentValues().apply {
            put(MediaStore.Images.Media.DISPLAY_NAME, filename)
            put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                put(MediaStore.Images.Media.RELATIVE_PATH, Environment.DIRECTORY_PICTURES + "/DAYMOND")
                put(MediaStore.Images.Media.IS_PENDING, 1)
            }
        }

        val resolver = contentResolver
        val uri = resolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, contentValues)

        if (uri != null) {
            resolver.openOutputStream(uri)?.use { stream ->
                bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream)
            }

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                contentValues.clear()
                contentValues.put(MediaStore.Images.Media.IS_PENDING, 0)
                resolver.update(uri, contentValues, null, null)
            }
            true
        } else {
            false // Échec si l'URI est nul
        }
    } catch (e: Exception) {
        e.printStackTrace()
        false
    }
}

}

