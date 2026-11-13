/**
 * LinkedIn Rich Text Shortcuts - Background Service Worker
 * Manifest V3 ephemeral service worker handling extension action clicks.
 */

const CHROME_WEB_STORE_URL =
  "https://chromewebstore.google.com/detail/linkedin-rich-text-shortc/pcnojfgoolblflomemlceeemfjdmneia";

chrome.action.onClicked.addListener((_tab) => {
  if (
    typeof chrome.runtime.openOptionsPage === "function" &&
    Boolean(chrome.runtime.getManifest?.()?.options_page)
  ) {
    chrome.runtime.openOptionsPage();
    return;
  }

  chrome.tabs.create({ url: CHROME_WEB_STORE_URL });
});
