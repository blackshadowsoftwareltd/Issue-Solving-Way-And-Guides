# Google Map

- Add `url_launcher` package

```dart
import 'package:url_launcher/url_launcher.dart';
```

- Launch from shareable link. like `https://maps.app.goo.gl/uTHtPtUksC6Qb3Ve8`

```dart
final url = 'https://maps.app.goo.gl/${placeID}';
await canLaunchUrl(Uri.parse(url)).then((bool result) async {
    if (result) {
        await launchUrl(Uri.parse(url));
    } else {
        showErrorSnack('Can\'t launch map');
    }
});
```

- Launch from Lat & Lng

```dart
final uri = Uri(scheme: 'google.navigation', queryParameters: {'q': '${data.latitute}, ${data.longitude}'});
await canLaunchUrl(uri).then((bool result) async {
    if (result) {
        await launchUrl(Uri.parse(url));
    } else {
        showErrorSnack('Can\'t launch map');
    }
});
```
- Launch with direction

```dart
final url = 'https://www.google.com/maps/dir/?api=1&origin=${origin.lat},${origin.long}&travelmode=driving${destination.lat != null && destination.long != null ? '&destination=${destination.lat},${destination.long}' : ''}';
await canLaunchUrl(Uri.parse(url)).then((bool result) async {
    if (result) {
        await launchUrl(Uri.parse(url));
    } else {
        showErrorSnack('Can\'t launch map');
    }
});
```

