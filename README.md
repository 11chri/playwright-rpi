# Dockerfile for playwright-python on Raspberry Pi Zero 2 W

Even though Playwright v1.17+ now supports Raspberry PI - [see 1.17 release notes](https://github.com/microsoft/playwright/releases/tag/v1.17.0), it seems that the normal installation procedure does not support Raspberry Pi Zero 2 W (armv7l, 32-bit). Therefore I updated the Dockerfile of https://github.com/glops/playwright-rpi4 with 
- Python 3.10 on Debian 11 bullseye
- Playwright version 1.19.0


This dockerfile demonstrates how to install playwright-python on raspberry pi. 

I tested it on Raspberry Pi Zero 2 W (armv7l, 32-bit). It may work on other raspberries.

## Run it

```bash
# Build the image
docker build --pull --rm -t playwrightrpi:latest "."

# Run it
docker run --rm -it  playwrightrpi:latest
# it should show playwright webpage title:
# Fast and reliable end-to-end testing for modern web apps | Playwright
```

## Install Playwright outside of docker

1. You need to download playwright package manually as shown in the dockerfile because there is no version for arm.
2. You need to install chromium. `sudo apt-get install chromium-browser`
3. You need to install node. `sudo apt-get install nodejs`
4. Follow the commands in dockerfile to replace the chrome and node binaries with the one you installed.
