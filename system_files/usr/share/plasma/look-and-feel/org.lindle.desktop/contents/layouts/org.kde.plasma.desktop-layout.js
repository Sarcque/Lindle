// Lindle default layout: Plasma's standard bottom panel (start menu, apps,
// tray, clock), floating, with Lindle's pinned apps. The Windows-like and
// Mac-like layouts arrive with the welcome app in 0.3.
loadTemplate("org.kde.plasma.desktop.defaultPanel")

const allPanels = panels();

for (let i = 0; i < allPanels.length; ++i) {
    const panel = allPanels[i];
    panel.floating = true;

    const widgets = panel.widgets();
    for (let j = 0; j < widgets.length; ++j) {
        const widget = widgets[j];
        if (widget.type === "org.kde.plasma.icontasks") {
            widget.currentConfigGroup = ["General"];
            widget.writeConfig("launchers", [
                "preferred://browser",
                "preferred://filemanager",
                "applications:org.onlyoffice.desktopeditors.desktop",
                "applications:ai.storyteller.gridcraft.desktop",
                "applications:ai.storyteller.photocraft.desktop",
                "applications:org.kde.discover.desktop"
            ]);
            widget.reloadConfig();
        }
    }
}
