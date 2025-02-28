---
layout: post
title: Ionic configurations to push notifications
date: 2025-02-25
flashcards: 
---

Notifications play a crucial role in enhancing user engagement and experience in mobile applications. Notifications can be used to provide timely updates, reminders, and important information even when the app is not actively in use. Whether it’s a new message, an order update, or a promotional offer, notifications help keep users informed and connected.

There are different types of notifications, such as push notifications, local notifications and in-app notifications. Push notifications are sent from a server to the user’s device, making them ideal for real-time updates. Local notifications, on the other hand, are scheduled and triggered by the app itself, even without an internet connection.

In this article we will talk about how to enable local notifications in android. Firstly, we have to add the use notifications command in the Android manifest file. Go to your Android Studio and navigate to your `AndroidManifest.xml` file. Add the below code inside the manifest tag.

```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
```

This enables the android to provide push notifications and scheduled notifications.

Next we have to ask the android notification permissions form the user to send notifications from the app. To do this navigate to the `MainActivity.java` file and add the following code to it.

```java
package io.ionic.starter;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Build;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import com.getcapacitor.BridgeActivity;

public class MainActivity extends BridgeActivity {

    private static final int NOTIFICATION_PERMISSION_REQUEST_CODE = 101;

    @Override
    protected void onStart() {
        super.onStart();
        requestNotificationPermission();
    }

    private void requestNotificationPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) { // Android 13+
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS)
                    != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this,
                        new String[]{Manifest.permission.POST_NOTIFICATIONS},
                        NOTIFICATION_PERMISSION_REQUEST_CODE);
            }
        }
    }
}
```

After this when the application is build and installed. The applications asks the user for permissions to send notifications. Now you can make the app to send scheduled notifications from your application.
        