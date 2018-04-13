package com.mogu.androidloading;

import android.util.Log;
import android.widget.Toast;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

public class LoadingModule extends ReactContextBaseJavaModule {


    LoadingDialog dialog1;

    public LoadingModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "NativeLoading";
    }
    @ReactMethod
    public void hide() {
        if(dialog1!=null){
            dialog1.dismiss();
        }
    }

    @ReactMethod
    public void show(String msg) {
        LoadingDialog.Builder builder1=new LoadingDialog.Builder(getCurrentActivity())
                .setMessage(msg)
                .setCancelable(false);
        dialog1=builder1.create();
        dialog1.show();
    }
}