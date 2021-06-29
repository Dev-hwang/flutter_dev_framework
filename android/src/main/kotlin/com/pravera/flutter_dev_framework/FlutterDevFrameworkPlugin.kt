package com.pravera.flutter_dev_framework

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterDevFrameworkPlugin */
class FlutterDevFrameworkPlugin : FlutterPlugin, ActivityAware {
	private lateinit var methodCallHandler: MethodCallHandlerImpl

	override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
		methodCallHandler = MethodCallHandlerImpl()
		methodCallHandler.startListening(binding.binaryMessenger)
	}

	override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
		if (::methodCallHandler.isInitialized)
			methodCallHandler.stopListening()
	}

	override fun onAttachedToActivity(binding: ActivityPluginBinding) {
		methodCallHandler.setActivity(binding.activity)
		binding.addActivityResultListener(methodCallHandler)
	}

	override fun onDetachedFromActivityForConfigChanges() {
		onDetachedFromActivity()
	}

	override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
		binding.removeActivityResultListener(methodCallHandler)
		onAttachedToActivity(binding)
	}

	override fun onDetachedFromActivity() {
		methodCallHandler.setActivity(null)
	}
}
