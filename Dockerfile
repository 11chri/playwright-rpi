FROM python:3.10-bullseye

# Install Chromium and node.js for arm
RUN apt-get update && \
    apt-get install -y \
    chromium \
    nodejs

RUN mkdir /app
WORKDIR /app

# Download playwright for linux x86_64
RUN wget https://files.pythonhosted.org/packages/9c/72/3fb51087950f392c2b7e66532cfa23c94c6d5c97fb25de0c06e6a8012b2e/playwright-1.19.0-py3-none-manylinux1_x86_64.whl

# Rename it so that it can be installed on arm
RUN mv playwright-1.19.0-py3-none-manylinux1_x86_64.whl playwright-1.19.0-py3-none-any.whl

RUN pip install playwright-1.19.0-py3-none-any.whl

# replace the node binary provided by playwright with a symlink to the version we just installed.
RUN rm /usr/local/lib/python3.10/site-packages/playwright/driver/node && \
    ln -s /usr/bin/node /usr/local/lib/python3.10/site-packages/playwright/driver/node

# create the hierarchy expected by playwright to find chrome
RUN mkdir -p /app/pw-browser/chromium-965416/chrome-linux/
# Add a symlink to the chromium binary we just installed.
RUN ln -s /usr/bin/chromium /app/pw-browser/chromium-965416/chrome-linux/chrome
# ask playwright to search chrome in this folder
ENV PLAYWRIGHT_BROWSERS_PATH=/app/pw-browser

# Copy the test file
COPY test_playwright.py /app/test_playwright.py

CMD [ "python3", "test_playwright.py" ]

####################
# armv7
