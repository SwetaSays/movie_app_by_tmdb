# Keep your app classes
-keep class com.example.movies_app.** { *; }

# Retrofit
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**

# OkHttp
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**

# Gson
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# Keep annotations & generics info
-keepattributes Signature
-keepattributes *Annotation*

# Hive (if you use Hive for bookmarks)
-keep class ** extends TypeAdapter
-keep class ** extends HiveObject
-keep class ** extends HiveTypeAdapter
