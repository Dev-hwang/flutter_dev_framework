package com.pravera.flutter_dev_framework

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull
import com.pravera.flutter_dev_framework.errors.ErrorCodes
import com.pravera.flutter_dev_framework.utils.PermissionUtils
import com.pravera.flutter_dev_framework.utils.SystemUtils

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

/** MethodCallHandlerImpl */
class MethodCallHandlerImpl : MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {
	companion object {
		const val OVERLAY_PERMISSION_REQ_CODE = 1000
		const val LOCATION_SERVICE_REQ_CODE = 1001
	}
	
	private lateinit var channel: MethodChannel
	private var methodCallResult: MethodChannel.Result? = null
	
	private var activity: Activity? = null

	fun startListening(messenger: BinaryMessenger) {
		channel = MethodChannel(messenger, "flutter_dev_framework")
		channel.setMethodCallHandler(this)
	}

	fun stopListening() {
		if (::channel.isInitialized)
			channel.setMethodCallHandler(null)
	}

	fun setActivity(activity: Activity?) {
		this.activity = activity
	}

	private fun handleError(result: MethodChannel.Result?, errorCode: ErrorCodes) {
		result?.error(errorCode.toString(), null, null)
	}

	override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
		if (activity == null) {
			handleError(result, ErrorCodes.ACTIVITY_NOT_REGISTERED)
			return
		}

		when (call.method) {
			"minimize" -> SystemUtils.minimize(activity!!)
			"killProcess" -> SystemUtils.killProcess(activity!!)
			"wakeLockScreen" -> SystemUtils.wakeLockScreen(activity!!)
			"canDrawOverlays" -> {
				val reqResult = PermissionUtils.canDrawOverlays(activity!!)
				result.success(reqResult)
			}
			"requestOverlayPermission" -> {
				this.methodCallResult = result
				PermissionUtils.requestOverlayPermission(activity!!, OVERLAY_PERMISSION_REQ_CODE)
			}
			"requestOverlayPermissionWithDialog" -> {
				this.methodCallResult = result
				val serviceName = call.argument<String>("serviceName") ?: "서비스"
				PermissionUtils.requestOverlayPermissionWithDialog(
						activity!!, OVERLAY_PERMISSION_REQ_CODE, serviceName)
			}
			"isLocationServiceEnabled" -> {
				val reqResult = PermissionUtils.isLocationServiceEnabled(activity!!)
				result.success(reqResult)
			}
			"requestLocationService" -> {
				this.methodCallResult = result
				PermissionUtils.requestLocationService(activity!!, LOCATION_SERVICE_REQ_CODE)
			}
			"requestLocationServiceWithDialog" -> {
				this.methodCallResult = result
				val serviceName = call.argument<String>("serviceName") ?: "서비스"
				PermissionUtils.requestLocationServiceWithDialog(
						activity!!, LOCATION_SERVICE_REQ_CODE, serviceName)
			}
			else -> result.notImplemented()
		}
	}

	override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
		if (activity == null) {
			handleError(methodCallResult, ErrorCodes.ACTIVITY_NOT_REGISTERED)
			return false
		}

		if (requestCode == OVERLAY_PERMISSION_REQ_CODE) {
			val reqResult = PermissionUtils.canDrawOverlays(activity!!)
			this.methodCallResult?.success(reqResult)
			this.methodCallResult = null
		} else if (requestCode == LOCATION_SERVICE_REQ_CODE) {
			val reqResult = PermissionUtils.isLocationServiceEnabled(activity!!)
			this.methodCallResult?.success(reqResult)
			this.methodCallResult = null
		}

		return resultCode == Activity.RESULT_OK
	}
}
