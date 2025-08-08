plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle Plugin must be applied after the Android and Kotlin plugins
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.voiplay"
    compileSdk = flutter.compileSdkVersion

    // NDK versiyasini video_player_android pluginining talabiga moslab aniq belgilang:
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.voiplay"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true           // Kodni siqish yoqildi (Proguard ishlaydi)
            isShrinkResources = true         // Foydalanilmayotgan resurslarni o'chirish yoqildi
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false          // Debugda siqishni o'chiramiz
            isShrinkResources = false        // Debugda resurs siqishni o'chiramiz
        }
    }
}

flutter {
    source = "../.."
}
