// Lindle "Mac-like" layout: a thin top bar with the Lindle menu, the app's
// menus, the tray and the clock, plus a centered dock at the bottom.
// Run by lindle-layout through Plasma's scripting API.

const top = new Panel;
top.location = "top";
top.height = Math.round(gridUnit * 1.6);
top.floating = false;

const menu = top.addWidget("org.kde.plasma.kickoff");
menu.currentConfigGroup = ["General"];
menu.writeConfig("icon", "lindle-logo");
top.addWidget("org.kde.plasma.appmenu");
top.addWidget("org.kde.plasma.panelspacer");
top.addWidget("org.kde.plasma.systemtray");
top.addWidget("org.kde.plasma.digitalclock");

const dock = new Panel;
dock.location = "bottom";
dock.height = Math.round(gridUnit * 3.2);
dock.floating = true;
dock.lengthMode = "fit";
dock.alignment = "center";

const tasks = dock.addWidget("org.kde.plasma.icontasks");
tasks.currentConfigGroup = ["General"];
tasks.writeConfig("launchers", [
    "preferred://browser",
    "preferred://filemanager",
    "applications:ai.storyteller.wordcraft.desktop",
    "applications:ai.storyteller.gridcraft.desktop",
    "applications:ai.storyteller.deckcraft.desktop",
    "applications:ai.storyteller.photocraft.desktop",
    "applications:io.github.kolunmi.Bazaar.desktop",
    "applications:systemsettings.desktop"
]);
tasks.reloadConfig();
