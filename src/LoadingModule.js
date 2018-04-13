import { NativeModules, NativeEventEmitter, Platform } from 'react-native'

const { NativeLoading } = NativeModules

export function showLoading(msg) {
    NativeLoading.show(msg)
}

export function hideLoading() {
    NativeLoading.hide()
}