package com.emerissource "https://rubygems.org"

gem "fastlane"
plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)


import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
