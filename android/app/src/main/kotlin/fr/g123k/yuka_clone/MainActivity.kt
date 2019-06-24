package fr.g123k.yuka_clone

import android.os.Bundle
import com.meetup.kotlin.paris.openfoodfacts.configureJsonCodecMessageChannel
import com.meetup.kotlin.paris.openfoodfacts.configureStandardCodecMessageChannel

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    configureStandardCodecMessageChannel()
  }
}
