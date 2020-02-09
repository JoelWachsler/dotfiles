const desk = desktops()

desk.forEach(d => {
    d.wallpaperPlugin = 'org.kde.image'
    d.currentConfigGroup = ['Wallpaper', 'org.kde.image', 'General']
    d.writeConfig('Image', `${userDataPath()}/dotfiles/configure_kde/kde_files/wallpaper.jpg`)
})