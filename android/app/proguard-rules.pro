# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Dart specific rules
-keep class androidx.lifecycle.DefaultLifecycleObserver

# Keep GetX related classes
-keep class com.github.dart_lang.** { *; }
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep model classes (adjust package name as needed)
-keep class com.ousadbazar.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep custom views
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
    *** get*();
}

# Keep Activity classes
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider

# Keep Parcelable classes
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep Serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep annotations
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Keep enum classes
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# OkHttp and Retrofit (common in Flutter projects)
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

# Gson (if used for JSON parsing)
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Firebase (if used)
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Image loading libraries (common in Flutter)
-keep class com.bumptech.glide.** { *; }
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.module.AppGlideModule
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
    **[] $VALUES;
    public *;
}

# WebView (if using webview_flutter)
-keep class android.webkit.** { *; }
-keep class * extends android.webkit.WebViewClient
-keep class * extends android.webkit.WebChromeClient

# Camera and permissions (if using camera/image picker)
-keep class androidx.camera.** { *; }
-keep class androidx.core.content.FileProvider { *; }

# Crashlytics (if used)
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Remove debug logs in release
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Optimize and obfuscate
-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-verbose

# Allow obfuscation of android.support and androidx
-dontwarn android.support.**
-dontwarn androidx.**

# Keep custom application class
-keep public class * extends android.app.Application

# Keep R classes
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Platform calls Class.forName on types which do not exist on Android to determine platform
-dontnote retrofit2.Platform
-dontwarn retrofit2.Platform$Java8
-keepattributes Signature
-keepattributes Exceptions

# Retain generic type information for use by reflection by converters and adapters
-keepattributes Signature

# Retain service method parameters when optimizing
-keepclassmembers,allowshrinking,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}

# Ignore annotation used for build tooling
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement

# Ignore JSR 305 annotations for embedding nullability information
-dontwarn javax.annotation.**

# Guarded by a NoClassDefFoundError try/catch and only used when on the classpath
-dontwarn kotlin.Unit

# Top-level functions that can only be used by Kotlin
-dontwarn retrofit2.KotlinExtensions
-dontwarn retrofit2.KotlinExtensions$*

# With R8 full mode, it sees no subtypes of Retrofit interfaces since they are created with a Proxy
# and replaces all potential values with null. Explicitly keeping the interfaces prevents this.
-if interface * { @retrofit2.http.* <methods>; }
-keep,allowobfuscation interface <1>

# Keep generic signature of Call, Response (R8 full mode strips signatures from non-kept items).
-keep,allowobfuscation,allowshrinking interface retrofit2.Call
-keep,allowobfuscation,allowshrinking class retrofit2.Response

# With R8 full mode generic signatures are stripped for classes that are not
# kept. Suspend functions are wrapped in continuations where the type argument
# is used.
-keep,allowobfuscation,allowshrinking class kotlin.coroutines.Continuation

# Additional Flutter specific rules for your project
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.common.** { *; }

# Keep your main application class
-keep class com.ousadbazar.MainActivity { *; }
-keep class com.ousadbazar.MainApplication { *; }

# GetX specific rules
-keep class com.github.dart_lang.** { *; }
-keep class * extends com.github.dart_lang.** { *; }

# Keep any classes that might be used via reflection
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep classes with native methods
-keepclasseswithmembers class * {
    native <methods>;
}

# Additional rules for common Flutter plugins
# Shared Preferences
-keep class androidx.preference.** { *; }

# Path Provider
-keep class io.flutter.plugins.pathprovider.** { *; }

# URL Launcher
-keep class io.flutter.plugins.urllauncher.** { *; }

# Image Picker
-keep class io.flutter.plugins.imagepicker.** { *; }

# Permission Handler
-keep class com.baseflow.permissionhandler.** { *; }

# Connectivity Plus
-keep class dev.fluttercommunity.plus.connectivity.** { *; }

# HTTP
-keep class io.flutter.plugins.flutter_plugin_android_lifecycle.** { *; }

# Package Info
-keep class io.flutter.plugins.packageinfo.** { *; }

# Device Info
-keep class io.flutter.plugins.deviceinfo.** { *; }

# Screen Util (if used)
-keep class com.github.flutter_screenutil.** { *; }

# Font Awesome Flutter (if used)
-keep class com.github.fluttercommunity.plus.** { *; }

# Any Image View (if used)
-keep class com.github.peng8350.flutter_pulltorefresh.** { *; }

# Google Play Core (for deferred components and split APKs)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Flutter Play Store Split Application
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }

# Flutter deferred components
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }

# Missing classes that are referenced but not used
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# Keep classes that might be missing but are referenced
-keep class * extends com.google.android.play.core.splitcompat.SplitCompatApplication
-keep class * implements com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener

# R8 compatibility rules
-keepattributes RuntimeVisibleAnnotations
-keepattributes RuntimeInvisibleAnnotations
-keepattributes RuntimeVisibleParameterAnnotations
-keepattributes RuntimeInvisibleParameterAnnotations

# Keep all Flutter embedding classes
-keep class io.flutter.embedding.** { *; }

# Additional rules for R8 full mode
-allowaccessmodification
-repackageclasses 