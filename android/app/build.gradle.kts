import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
val hasReleaseSigningConfig = keystorePropertiesFile.exists()

if (hasReleaseSigningConfig) {
    FileInputStream(keystorePropertiesFile).use(keystoreProperties::load)
}

fun releaseSigningProperty(name: String): String {
    return keystoreProperties.getProperty(name)?.takeIf { it.isNotBlank() }
        ?: throw GradleException("Missing '$name' in android/key.properties.")
}

val isReleaseBuild = gradle.startParameter.taskNames.any {
    it.contains("release", ignoreCase = true)
}

if (isReleaseBuild && !hasReleaseSigningConfig) {
    throw GradleException(
        "Release signing is not configured. Copy android/key.properties.example " +
            "to android/key.properties and provide a production keystore."
    )
}

android {
    namespace = "com.example.guide_manager"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.traveltech.guideManager"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseSigningConfig) {
            create("release") {
                keyAlias = releaseSigningProperty("keyAlias")
                keyPassword = releaseSigningProperty("keyPassword")
                storeFile = file(releaseSigningProperty("storeFile"))
                storePassword = releaseSigningProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            if (hasReleaseSigningConfig) {
                signingConfig = signingConfigs.getByName("release")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
