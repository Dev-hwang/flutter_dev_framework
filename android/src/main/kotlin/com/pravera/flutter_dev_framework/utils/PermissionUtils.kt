package com.pravera.flutter_dev_framework.utils

import android.app.Activity
import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.location.LocationManager
import android.net.Uri
import android.os.Build
import android.provider.Settings

/**
 * 앱 권한 유틸리티
 *
 * @author  WOO JIN HWANG
 * @version 1.0
 */
class PermissionUtils {
	companion object {
		/**
		 * 윈도우(Overlay) 권한 허용 여부를 확인한다.
		 *
		 * @param context Context
		 * @return 윈도우 권한 허용 여부
		 */
		fun canDrawOverlays(context: Context): Boolean {
			if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M)
				return true

			return Settings.canDrawOverlays(context)
		}

		/**
		 * 윈도우(Overlay) 권한을 요청한다.
		 *
		 * @param activity Activity
		 * @param requestCode 권한 요청 코드
		 */
		fun requestOverlayPermission(activity: Activity, requestCode: Int) {
			if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M)
				return

			if (!canDrawOverlays(activity.applicationContext)) {
				val action = Settings.ACTION_MANAGE_OVERLAY_PERMISSION
				val uri = Uri.parse("package:${activity.packageName}")
				activity.startActivityForResult(Intent(action, uri), requestCode)
			}
		}

		/**
		 * 윈도우(Overlay) 권한을 요청할 것인지 질문 후 권한을 요청한다.
		 *
		 * @param activity Activity
		 * @param requestCode 권한 요청 코드
		 * @param serviceName 권한을 필요로 하는 서비스 이름
		 */
		fun requestOverlayPermissionWithDialog(activity: Activity, requestCode: Int, serviceName: String) {
			if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M)
				return
			if (canDrawOverlays(activity.applicationContext))
				return

			val dialog = AlertDialog.Builder(activity, android.R.style.Theme_DeviceDefault_Dialog_Alert)
					.setMessage("앱에서 ${serviceName}를 제공하려면 윈도우 권한이 필요합니다.\n설정 페이지로 이동하시겠어요?")
					.setCancelable(false)
					.setNegativeButton("취소") { dialog, _ ->
						dialog.cancel()
					}
					.setPositiveButton("이동") { dialog, _ ->
						dialog.cancel()
						requestOverlayPermission(activity, requestCode)
					}
					.create()
			dialog.show()
		}

		/**
		 * 위치 서비스 활성화 여부를 확인한다.
		 *
		 * @param context Context
		 * @return 위치 서비스 활성화 여부
		 */
		fun isLocationServiceEnabled(context: Context): Boolean {
			val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
			return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
		}

		/**
		 * 위치 서비스 활성화 요청한다.
		 *
		 * @param activity Activity
		 * @param requestCode 권한 요청 코드
		 */
		fun requestLocationService(activity: Activity, requestCode: Int) {
			val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
			intent.addCategory(Intent.CATEGORY_DEFAULT)
			activity.startActivityForResult(intent, requestCode)
		}

		/**
		 * 위치 서비스를 활성화할 것인지 질문 후 활성화 요청한다.
		 *
		 * @param activity Activity
		 * @param requestCode 권한 요청 코드
		 * @param serviceName 위치 서비스를 필요로 하는 서비스 이름
		 */
		fun requestLocationServiceWithDialog(activity: Activity, requestCode: Int, serviceName: String) {
			if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M)
				return
			if (isLocationServiceEnabled(activity.applicationContext))
				return

			val dialog = AlertDialog.Builder(activity, android.R.style.Theme_DeviceDefault_Dialog_Alert)
					.setMessage("앱에서 ${serviceName}를 제공하려면 위치 서비스 활성화가 필요합니다.\n설정 페이지로 이동하시겠어요?")
					.setCancelable(false)
					.setNegativeButton("취소") { dialog, _ ->
						dialog.cancel()
					}
					.setPositiveButton("이동") { dialog, _ ->
						dialog.cancel()
						requestLocationService(activity, requestCode)
					}
					.create()
			dialog.show()
		}
	}
}
