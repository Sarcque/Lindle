# Installing Lindle

This guide takes you from download to your first login. You need a USB stick of 8 GB or more and about 30 minutes. Nothing on your computer changes until you click **Install** in the last step.

## 1. Pick your download

| Your computer has | Download |
|---|---|
| An NVIDIA graphics card (GeForce, RTX, Quadro) | **Lindle for NVIDIA** |
| Anything else (Intel, AMD, Apple Intel Macs, most laptops) | **Lindle** |

Not sure? On Windows, open **Task Manager → Performance → GPU** and look for "NVIDIA". On a Mac, open ** → About This Mac**. If you pick the wrong one, Lindle still works; the NVIDIA edition just adds NVIDIA's own driver for faster graphics and games.

Each download comes with a `CHECKSUM` file. To check that the download is complete, run this in the folder where you saved it:

- Windows (PowerShell): `Get-FileHash lindle-live.iso`
- macOS: `shasum -a 256 lindle-live.iso`

The long number it prints should match the one in the `CHECKSUM` file.

## 2. Make a USB stick

Writing the ISO erases everything on the stick.

- **Windows:** use [Fedora Media Writer](https://flathub.org/apps/org.fedoraproject.MediaWriter) or [Rufus](https://rufus.ie). In Rufus, choose **DD Image mode** when it asks.
- **macOS:** use [Fedora Media Writer](https://github.com/FedoraQt/MediaWriter/releases) or [balenaEtcher](https://etcher.balena.io).
- **Linux:** use Fedora Media Writer, or GNOME Disks → **Restore Disk Image**.

## 3. Start from the USB stick

Plug in the stick and restart. While the computer starts, press the boot menu key and pick the USB stick:

| Brand | Key |
|---|---|
| Dell | F12 |
| HP | F9 or Esc |
| Lenovo | F12, or the small Novo button |
| ASUS | F8 or Esc |
| Acer | F12 |
| MSI | F11 |
| Intel Mac | Hold Option (⌥) and choose **EFI Boot** |

On Windows you can also hold **Shift** while clicking **Restart**, then choose **Use a device**.

Lindle works with Secure Boot turned on, so you don't need to change any firmware settings.

## 4. Try Lindle

Choose **Try or Install Lindle**. After a minute you're on the Lindle desktop, running straight from the stick. Nothing is saved, so try anything you like: check that Wi-Fi, sound, the touchpad and your screen work.

If the screen stays black or flickers, restart and choose **Try or Install Lindle (safe graphics)**.

## 5. Install

Double-click **Install Lindle** on the desktop and follow the steps.

**Where to install**

- **Use the whole disk:** erases the disk and installs only Lindle. Choose this if you don't need anything on the computer anymore.
- **Next to Windows:** keeps Windows and lets you choose at every start. Before you start, make room in Windows: open **Disk Management**, right-click your C: drive, choose **Shrink Volume**, and free at least 64 GB. Then pick **Use free space** in the installer.

**If Windows uses BitLocker** (common on new laptops), save your BitLocker recovery key first: in Windows, search for **Manage BitLocker** and choose **Back up your recovery key**. Installing next to Windows can make Windows ask for that key once.

**Encrypt my data** keeps your files safe if your laptop is lost or stolen. You'll type a password at every start. Write it down: without it, nobody can get your files back, including you.

When the installer finishes, remove the USB stick and restart.

## 6. First start

Log in with the account you created. **Welcome Center** opens and lets you:

- choose a Windows-like or Mac-like desktop,
- see where everything is if you're coming from Windows or a Mac,
- find the apps that are already installed.

Lindle keeps itself up to date in the background. When an update is ready, you get a notification with a **Restart now** button. If an update ever causes trouble, open **Restore Previous Version** from the start menu.

## Help

- Something not working? [Open an issue](https://github.com/Sarcque/Lindle/issues) and describe your computer model.
- Already using Fedora Atomic? Switch without reinstalling: `sudo bootc switch ghcr.io/sarcque/lindle:latest` (or `lindle-nvidia:latest`).
