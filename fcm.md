### First of all, add these packages : 
```
dependencies:
  googleapis_auth: ^1.4.1
  googleapis: ^12.0.0
```

### Obtain a Service Account Key:
Go to the `Firebase Console`.
Navigate to your project settings.
In the `"Service accounts"` tab, generate a new `private key`.
This will download a JSON file containing your service account credentials.

The json file look like :
```{
  "type": "service_account",
  "project_id": "project_id",
  "private_key_id": "asdfasdfasdfasdf",
  "private_key": "-----BEGIN PRIVATE KEY-----\asdfasdfasdfasdf\aasdfasdfasdfasdf/asdfasdfasdfasdfasdfasdfasdfasdf==\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-6ktze@project_id.iam.gserviceaccount.com",
  "client_id": "1111111111111111111",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-6ktze%40project_id.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
```

### Parse the in the json file to Map<String, dynamic> :
```
Map<String, dynamic> googleServices = {
   your json 
};
```

### Create a function to send the notification :
```
void sendFcmNotification(String? token, String? title, String? body) async {
  /// ? run the function in the background isolate to avoid UI blocking
  await compute((v) async {
    /// ? load the json file
    final credentials = ServiceAccountCredentials.fromJson(googleServices);

    /// ? create the client
    final client = await clientViaServiceAccount(credentials, [FirebaseCloudMessagingApi.cloudPlatformScope]);

    /// ? url of the fcm. || googleServices['project_id'] is the project id.
    final fcmEndpoint = 'https://fcm.googleapis.com/v1/projects/${googleServices['project_id']}/messages:send';

    final notification = {
      'message': {
        'token': v.$1, // Replace with the FCM device registration token
        'notification': {
          'title': v.$2,
          'body': v.$3,
        },
      },
    };

    final response = await client.post(Uri.parse(fcmEndpoint), body: jsonEncode(notification));

    debugPrint('FCM Notification Response: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');
  }, (token, title, body));
}
```