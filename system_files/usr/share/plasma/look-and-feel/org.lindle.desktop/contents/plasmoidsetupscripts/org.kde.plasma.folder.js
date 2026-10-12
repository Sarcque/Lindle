// Every new desktop starts with the Lindle wallpaper.
applet.wallpaperPlugin = "org.kde.image"
applet.currentConfigGroup = ["Wallpaper", "org.kde.image", "General"]
applet.writeConfig("Image", "file:///usr/share/wallpapers/Lindle/")
applet.reloadConfig()
