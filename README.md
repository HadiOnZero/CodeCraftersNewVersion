# 🔐 SyborgCate Workshop

<div align="center">
  
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.1.0-green.svg)](https://github.com/IndonesianDedsec/syborgcate_workshop)

</div>

## 📱 Deskripsi

**SyborgCate Workshop** adalah aplikasi Flutter yang dirancang untuk keamanan siber dan pengujian penetrasi. Aplikasi ini menyediakan berbagai fitur untuk membantu dalam melakukan analisis keamanan dan pengujian kerentanan sistem.

## ✨ Fitur Utama

- 🔐 **Autentikasi Firebase** - Login dan registrasi pengguna yang aman
- 🛡️ **SQL Injection Checker** - Pemeriksaan kerentanan SQL Injection
- 🌐 **XSS Checker** - Deteksi kerentanan Cross-Site Scripting
- 🔍 **Mass Mirror Tools** - Alat untuk mirror website
- 📊 **SMB Enumeration** - Enumerasi SMB dengan Nmap
- 🎯 **Selidiki ID** - Alat investigasi identitas digital

## 🚀 Teknologi yang Digunakan

### Bahasa Pemrograman
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![Kotlin](https://img.shields.io/badge/Kotlin-0095D5?style=flat-square&logo=kotlin&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-FA7343?style=flat-square&logo=swift&logoColor=white)

### Framework & Tools
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)

### Package Dependencies

| Package | Version | Kegunaan |
|---------|---------|----------|
| [`firebase_core`](https://pub.dev/packages/firebase_core) | ^3.15.1 | Core Firebase functionality |
| [`firebase_auth`](https://pub.dev/packages/firebase_auth) | ^5.6.2 | Authentication system |
| [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) | ^0.14.4 | Custom app icons |
| [`lottie`](https://pub.dev/packages/lottie) | ^3.3.1 | Animations and micro-interactions |
| [`http`](https://pub.dev/packages/http) | ^1.5.0 | HTTP requests |
| [`provider`](https://pub.dev/packages/provider) | ^6.1.2 | State management |

## 📦 Instalasi

### Prasyarat
- Flutter SDK ^3.8.1
- Dart SDK ^3.8.1
- Android Studio / Xcode
- Firebase Account

### Langkah Instalasi

1. **Clone Repository**
   ```bash
   git clone https://github.com/IndonesianDedsec/syborgcate_workshop.git
   cd syborgcate_workshop
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Konfigurasi Firebase**
   - Copy file `google-services.json` ke `android/app/`
   - Copy file `GoogleService-Info.plist` ke `ios/Runner/`

4. **Generate Launcher Icons**
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

5. **Generate Assets**
   ```bash
   flutter pub run flutter_assets:generate
   ```

## 🚀 Deployment

### Development
```bash
flutter run
```

### Build APK
```bash
flutter build apk --release
```

### Build untuk Platform Lain
```bash
# iOS
flutter build ios --release

# Web
flutter build web --release

# Desktop (Windows)
flutter build windows --release

# Desktop (macOS)
flutter build macos --release

# Desktop (Linux)
flutter build linux --release
```

## 📁 Struktur Proyek

```
syborgcate_workshop/
├── lib/
│   ├── components/          # Reusable UI components
│   ├── constants/           # App constants and assets
│   ├── providers/           # State management (Provider)
│   ├── main.dart           # Entry point
│   └── *.dart              # Feature modules
├── assets/                  # Images, animations, fonts
├── android/                 # Android-specific code
├── ios/                     # iOS-specific code
├── web/                     # Web-specific code
├── linux/                   # Linux-specific code
├── macos/                   # macOS-specific code
├── windows/                 # Windows-specific code
└── test/                    # Unit tests
```

## 🎨 Assets & Resources

- **Fonts**: Pixel font untuk estetika retro
- **Animations**: Lottie animations untuk UI yang menarik
- **Icons**: Custom launcher icons
- **Images**: Security-themed assets

## 🔧 Konfigurasi

### Firebase Configuration
Pastikan untuk mengonfigurasi Firebase di setiap platform:
- Android: `android/app/google-services.json`
- iOS: `ios/Runner/GoogleService-Info.plist`
- Web: `web/index.html`

### App Icons
Konfigurasi icon aplikasi di `flutter_launcher_icons.yaml`

## 🤝 Kontribusi

Kontribusi sangat dipersilahkan! Silakan fork repository ini dan buat pull request.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Lisensi

Proyek ini dilisensikan di bawah lisensi MIT - lihat file [LICENSE](LICENSE) untuk detailnya.

## 👥 Authors

- **[@IndonesianDedsec](https://github.com/IndonesianDedsec)** - Initial work
- **[@HadiOnZero](https://github.com/HadiOnZero)** - Core development

## 🙏 Acknowledgments

- Flutter Team untuk framework yang luar biasa
- Firebase Team untuk backend services
- Kontributor open source yang menginspirasi

---

<div align="center">
  
**⭐ Jika proyek ini bermanfaat, jangan lupa untuk memberikan bintang! ⭐**

</div>
