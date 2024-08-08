# ulalo

Ulalo DApp MobileApplication


```Generate translation loader & keys```

dart run easy_localization:generate --source-dir assets/translations && dart run easy_localization:generate -f keys -o locale_keys.g.dart  --source-dir assets/translations

flutter pub run easy_localization:generate --source-dir assets/translations && flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart  --source-dir assets/translations

## Commands


Launcher Icon : flutter pub run flutter_launcher_icons -f ./flutter_launcher_icons.yaml
OR
Launcher Icon : dart run flutter_launcher_icons -f ./flutter_launcher_icons.yaml

Splash Screen : dart run flutter_native_splash:create --path=flutter_native_splash.yaml

Fix iOS Build:

    - pod repo update 
    - pod install
    - flutter clean && flutter build ios