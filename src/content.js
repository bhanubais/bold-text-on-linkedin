/**
 * LinkedIn Rich Text Shortcuts - Content Script
 * Enables native bold formatting (Ctrl+B / Cmd+B) across LinkedIn editors.
 */

(() => {
  const EDITOR_SELECTORS = [
    // Primary modern LinkedIn post editor (Tiptap / ProseMirror)
    '[data-testid="ui-core-tiptap-text-editor-wrapper"] [contenteditable="true"]',
    '[data-testid*="tiptap"] [contenteditable="true"]',
    '[data-testid*="editor"] [contenteditable="true"]',
    '.tiptap.ProseMirror[contenteditable="true"]',
    '.ProseMirror[contenteditable="true"]',

    // Feed post creation and share modals
    '.share-creation-state__text-editor [contenteditable="true"]',
    '.feed-shared-creation-state__text-editor [contenteditable="true"]',
    '.share-creation-state [contenteditable="true"]',
    '.feed-shared-creation-state [contenteditable="true"]',
    '.share-box-feed-entry__wrapper [contenteditable="true"]',
    '.editor-content [contenteditable="true"]',

    // Comment and quick-reply editors
    '.comments-comment-box__editor [contenteditable="true"]',
    '.comments-comment-box [contenteditable="true"]',

    // Messaging composers
    '.msg-form__contenteditable[contenteditable="true"]',
    '.msg-form__message-texteditor [contenteditable="true"]',

    // Legacy Quill editors
    '.ql-editor[contenteditable="true"]',

    // Semantic ARIA textbox
    '[role="textbox"][contenteditable="true"]',
  ];

  function isBoldShortcut(event) {
    if (!event) return false;
    const isModifier = Boolean(event.ctrlKey || event.metaKey);
    if (!isModifier || event.shiftKey || event.altKey) {
      return false;
    }
    const key = event.key ? event.key.toLowerCase() : "";
    return key === "b" || event.code === "KeyB";
  }

  function findLinkedInEditor(target) {
    if (!target) return null;

    // Handle text node targets by jumping to their parent element
    const element =
      target.nodeType === 3 /* Node.TEXT_NODE */
        ? target.parentElement
        : target;

    if (!element || typeof element.closest !== "function") {
      return null;
    }

    // 1. Direct match against known LinkedIn editor hierarchy
    for (const selector of EDITOR_SELECTORS) {
      const matched = element.closest(selector);
      if (matched && matched.isContentEditable !== false) {
        return matched;
      }
    }

    // 2. Fallback: Any valid contenteditable container within LinkedIn
    const editable = element.closest('[contenteditable="true"]');
    if (editable && editable.isContentEditable !== false) {
      return editable;
    }

    return null;
  }

  function applyBoldFormatting(editor, doc) {
    const documentRef =
      doc || (typeof document !== "undefined" ? document : null);
    if (!editor && !documentRef) return false;

    let applied = false;

    // Attempt modern InputEvent (DOM Level 3 / Input Events Level 2)
    if (
      editor &&
      typeof InputEvent === "function" &&
      typeof editor.dispatchEvent === "function"
    ) {
      try {
        const inputEvent = new InputEvent("beforeinput", {
          inputType: "formatBold",
          bubbles: true,
          cancelable: true,
          composed: true,
        });
        const notCanceled = editor.dispatchEvent(inputEvent);
        if (!notCanceled) {
          applied = true;
        }
      } catch {
        // Continue to fallback
      }
    }

    // Robust fallback for contenteditable environments
    if (
      !applied &&
      documentRef &&
      typeof documentRef.execCommand === "function"
    ) {
      try {
        documentRef.execCommand("bold", false, null);
        applied = true;
      } catch {
        // Silently handle edge cases without throwing
      }
    }

    return applied;
  }

  function handleKeyDown(event, doc) {
    if (!isBoldShortcut(event)) {
      return;
    }

    const documentRef =
      doc || (typeof document !== "undefined" ? document : null);
    const target =
      event.target || (documentRef ? documentRef.activeElement : null);
    const editor = findLinkedInEditor(target);

    if (!editor) {
      return;
    }

    if (typeof event.preventDefault === "function") {
      event.preventDefault();
    }
    if (typeof event.stopPropagation === "function") {
      event.stopPropagation();
    }

    applyBoldFormatting(editor, documentRef);
  }

  if (
    typeof document !== "undefined" &&
    typeof document.addEventListener === "function"
  ) {
    document.addEventListener("keydown", handleKeyDown, true);
  }

  // CommonJS export for automated unit testing in Node environment
  if (typeof module !== "undefined" && module.exports) {
    module.exports = {
      isBoldShortcut,
      findLinkedInEditor,
      applyBoldFormatting,
      handleKeyDown,
      EDITOR_SELECTORS,
    };
  }
})();
