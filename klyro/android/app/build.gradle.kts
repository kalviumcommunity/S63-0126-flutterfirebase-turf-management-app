// App-Level Gradle Module Architecture
plugins {
    id("com.android.application")
    id("kotlin-android")
    // Injects Flutter compilation pipelines alongside Google Services manually natively
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    // Defines perfectly unique internal bundle identifiers mapped per device securely
    namespace = "com.example.klyro"
    // Dynamically pulls the SDK targeting map limit directly from Flutter parameters natively avoiding redundant mapping
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // Sets Java 17 explicit codebase as compilation target resolving cross-platform interoperabilities cleanly natively
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    // Instructs JVM configurations targeting 17 constraints natively inside Kotlin specifically structurally 
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // Universal application ID natively mapped to the underlying ecosystem securely 
        applicationId = "com.example.klyro"
        // Constraints minimal supported Android OS platform utilizing variables directly parsed out of the framework dynamically 
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Extrapolates standard pubspec.yaml version mappings accurately without manually typing over and over 
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Overrides explicit KeyStore protocols explicitly deploying prototype debug signatures globally for quick pipeline testing natively cleanly 
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Tells the Gradle execution where Dart physical configurations natively live mapping backwards structurally securely 
flutter {
    source = "../.."
}
