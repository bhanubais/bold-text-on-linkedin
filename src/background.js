/**
 * LinkedIn Rich Text Shortcuts - Background Service Worker
 * Manifest V3 ephemeral service worker handling extension lifecycle and action clicks.
 */

const HOMEPAGE_URL = "https://bhanubais.github.io/bold-text-on-linkedin/";

// Open the official website when the extension icon is clicked in the toolbar
chrome.action.onClicked.addListener((_tab) => {
  if (
    typeof chrome.runtime.openOptionsPage === "function" &&
    Boolean(chrome.runtime.getManifest?.()?.options_page)
  ) {
    chrome.runtime.openOptionsPage();
    return;
  }

  chrome.tabs.create({ url: HOMEPAGE_URL });
});

// Automatically open the guide website upon fresh installation
chrome.runtime.onInstalled.addListener((details) => {
  if (details.reason === "install") {
    chrome.tabs.create({ url: HOMEPAGE_URL });
  }
});
