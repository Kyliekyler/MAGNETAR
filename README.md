# MAGNETAR
<p align="center">
  <img src="https://github.com/Kyliekyler/MAGNETAR/blob/master/.github/magnetar.png"> 
</p>
 
<p align="center">
  <a href="https://t.me/MAGNETAR1999"><img src="https://img.shields.io/badge/Telegram-Channel-blue.svg"></a><br/><a href="https://t.me/MAGNETARCHAT"><img src="https://img.shields.io/badge/Telegram-Group-blue.svg"></a>
</p>
<br/>

Eliminate Lags and Throttling — Run Your Game Smoothly and Comfortably with No Substantial Performance Drops

# Notes
- This will improve overall performance but in exchange for a bit increased power usage and may cause heating
- Flash at your own risk, I'm not responsible for lost data or bricked devices

# Compatibility
- [![Android 5](https://img.shields.io/badge/Android-5-red.svg)]() [![Android 6](https://img.shields.io/badge/Android-6-pink.svg)]() [![Android 7](https://img.shields.io/badge/Android-7-violet.svg)]() [![Android 8](https://img.shields.io/badge/Android-8-yellow.svg)]() [![Android 9](https://img.shields.io/badge/Android-9-lightgreen.svg)]() [![Android 10](https://img.shields.io/badge/Android-10-brightgreen.svg)]()
- [![CPU ABI](https://img.shields.io/badge/ABI-32-pink.svg)]() [![Chipset](https://img.shields.io/badge/ABI-64-pink.svg)]()
- [![Magisk](https://img.shields.io/badge/Magisk-19%2B-00B39B.svg)]()
   
# Instructions
- Download and install the module
- Reboot after you finished installing

### Modes
- Changing modes can be done w/out having to reboot
just edit the mode.txt file to the mode you want

```
0 = Adaptive Mode (Default)
    will be changing dynamically through user's usage (recommended)
1 = Idle Mode
    will force the device to save some battery
2 = Moderate Mode
    will be set forcely to balanced+ profile
3 = Performance Mode
    will be setting force gaming mode (for hardcore gamers and power users)
```
- There are also modes that cannot be changed and automatically
runs when certain conditions met like:

```
Sleep Mode = will stop MAGNETAR processes for the moment
             it detects the phone minutes when screen turned off
Cooldown Mode = will automatically sets the mode lower
             when certain temp reached to avoid overheating
```

# Changelog
### GOLF (2004020115)
- Hotfix
  - Fixed Stucked Module
- A Bit Faster Module Logging

### GOLF (2004012304)
- Introduction of Modes
  - Adaptive 
  - Idle
  - Moderate
  - Performance
  - Cooldown – Triggered when Temp Hits 45°C
  - Sleep – Triggered when Screen was Turned OFF
- Mode Switch Made Easy
  - Can Be Done WITHOUT REBOOTING
  - See Instructions
- Support For All SOC
  - 32bit and 64bit
- Anti-Blocking Parameters Added
  - Unique ID For Each Installation
- Updated GPU Tweaks
- Fixed Missing Folder on Android 10
- API Support From As Low As Android 5
- Removed Unnecessary Script
- Various Bug Fixes & Improvements

### FOXTROT (1910121000)
- Various Important Bug Fix

### FOXTROT (1910112244)
- Fixed After-Reboot-Execution

### FOXTROT (1910111955)
- Fixed .MAGNE.BIN Path Detection

### FOXTROT (1910111550)
- Anti-Kang Parameters
- Fully Rewritten For Efficiency
- Not Forcing Config To Avoid Conflicts
- Force High Quality Graphics
- Added RAM Gaming Configuration
- Adjusted Kernel Gaming Config
- Removed Governor Config For CPU & GPU
- Fixed Lag When Certain Temp Reached
- Much Better Temps
- Removed SoundFX
- Updated Props
- Compiled With Clang 
  - 32bit and 64bit SOC Support
- All New Logging System
  - Detailed Logging
- Improved SOC Detection
  - Fixed Recovery Installation
- Smoother UI
  - FPS Unlocking
  - Auto Freq
- Reduced Idle Drain
  - Adjusted LPM Parameters
  - Disabled Debuggers
- EAS / HMP Tuning
- Better Color Adjustment
- More...
  
### ECHO (1909230945)
- Various Adjustments
- Smoother Performance
- Added SD855 Support
- Added SoundFX Opt-in/out
- Added More GPU/CPU Tweaks
- Fixed Wifi Issues On Some Devices
- Fixed Static Call Sound
- Fixed Scroll Bug
- Fixed Module Logging Duplicate
- Updated Thermal
- Better Idling
  - Reduced Heating
  - Lower Batt Consumption
- Updated Props
  - Removed Various Props
  - Reverted Some Props from Build 1909101057
- Smart Fast Charge
  - Lowering Charge Input When Battery Temp Reached 45°C
- Improved Log Checking
- Increased Override Time To 3mins After Boot

### DELTA (1909191327)
- Support for All Devices Using QComm Snapdragon SOC
- Improved System Speed
- Improved App Launch Speed
- Improved IPV4 Traffic
- Improved Module Logging
- Better Temperature
- Lower Battery Consumption
- Adjusted KCAL Values
- Updated Props
- Cleanup and Optimizations thanks to [Hafiz](https://t.me/HafizZiq)

### CHARLIE (1909101057)
- Performance Improvements
- Proper Android 10 Support
- Updated Props
- Extended Min API to 25
- Added More Devices to Run Service Script
- Added Thermal Bin to Entry-Level SOC
- Adjusted Tweaking Values
- Improved Module Logging
- Sound Mod Will Only Be Installed on AOSP Based Android 9 Rom (Device Specific)

### BRAVO (1908312141)
- Performance Improvements
- Adjusted Some Tweaking Values
- Fixed Some Settings That Didn't Get Applied
- Added Thermals On Flagship SOC 
- Added Module Logging
- Added Better BT Libs
- More... (Forgotten)

### ALPHA (1908281710)
- Initial Release

# Special Thanks to
- [Master Skittles](https://t.me/Skittles9823) for the aapt binaries
- [Hafiz](https://t.me/HafizZiq) for some fixes and code optimization
- [K1ks](https://t.me/K1ks1) for few of his tweaks included in this module
- [Zackptg5](https://github.com/Zackptg5) for Unity template
- [topjohnwu](https://github.com/topjohnwu) for Magisk
- To my TESTERS who give immediate feedback and hunting 🐞
