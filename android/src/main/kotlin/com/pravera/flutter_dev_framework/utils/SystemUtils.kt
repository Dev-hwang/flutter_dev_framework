package com.pravera.flutter_dev_framework.utils

import android.app.Activity
import android.content.Context
import android.os.Build
import android.os.PowerManager
import kotlin.system.exitProcess

/**
 * 시스템 유틸리티
 *
 * @author  WOO JIN HWANG
 * @version 1.0
 */
class SystemUtils {
	companion object {
		/**
		 * 앱을 최소화한다.
		 *
		 * @param activity Activity
		 */
		fun minimize(activity: Activity) {
			activity.moveTaskToBack(true)
		}

		/**
		 * 앱을 강제 종료한다.
		 *
		 * @param activity Activity
		 */
		fun killProcess(activity: Activity) {
			if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN)
				activity.finishAffinity()
			exitProcess(0)
		}

		/**
		 * 절전 상태의 화면을 깨운다.
		 *
		 * @param context Context
		 */
		fun wakeLockScreen(context: Context) {
			val powerManager = context.getSystemService(Context.POWER_SERVICE) as PowerManager
			val serviceFlag = PowerManager.SCREEN_BRIGHT_WAKE_LOCK
					.or(PowerManager.ACQUIRE_CAUSES_WAKEUP)
					.or(PowerManager.ON_AFTER_RELEASE)

			val newWakeLock = powerManager.newWakeLock(serviceFlag, "SystemUtils:WAKELOCK")
			newWakeLock.acquire(1000)
			newWakeLock.release()
		}
	}
}
