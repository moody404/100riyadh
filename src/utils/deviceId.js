/**
 * Device ID utilities for tracking users without authentication
 */

const DEVICE_ID_KEY = 'riyadh_restaurants_device_id';

/**
 * Generate a unique device ID
 */
function generateDeviceId() {
  return 'device_' + Math.random().toString(36).substring(2, 15) +
         Math.random().toString(36).substring(2, 15) +
         Date.now().toString(36);
}

/**
 * Get or create device ID
 */
export function getDeviceId() {
  let deviceId = localStorage.getItem(DEVICE_ID_KEY);

  if (!deviceId) {
    deviceId = generateDeviceId();
    localStorage.setItem(DEVICE_ID_KEY, deviceId);
  }

  return deviceId;
}

/**
 * Clear device ID (for testing)
 */
export function clearDeviceId() {
  localStorage.removeItem(DEVICE_ID_KEY);
}
