// Pre-execution evaluation script checking bindings structurally proactively 
pluginManagement {
    val flutterSdkPath =
        run {
            // Physical mapping blocks actively parsing local.properties natively structurally looking for Flutter's installation path securely
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    // Locates Flutter's path reliably and embeds Flutter's custom compile tools cleanly
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

// Map native dependencies globally prior to executing specific physical functional sub-folders
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    // Configuration securely loading Firebase configurations locally logically prior natively 
    id("com.google.gms.google-services") version("4.3.15") apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

// Directs total compile engine targeting structurally forcing :app module as absolute execution logic block location 
include(":app")
