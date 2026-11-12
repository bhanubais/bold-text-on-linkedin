/**
 * LinkedIn Rich Text Shortcuts - Background Service Worker
 * Manifest V3 ephemeral service worker handling extension action clicks.
 */

chrome.action.onClicked.addListener((_tab) => {
  const extensionId = chrome.runtime?.id;
  const storeUrl = extensionId
    ? `https://chromewebstore.google.com/detail/${extensionId}`
    : "https://www.linkedin.com/feed/";

  if (
    typeof chrome.runtime.openOptionsPage === "function" &&
    Boolean(chrome.runtime.getManifest?.()?.options_page)
  ) {
    chrome.runtime.openOptionsPage();
    return;
  }

  chrome.tabs.create({ url: storeUrl });
});
