const test = require("node:test");
const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");

const SRC_DIR = path.resolve(__dirname, "../../src");
const ROOT_DIR = path.resolve(__dirname, "../..");
const CONTENT_SCRIPT_PATH = path.join(SRC_DIR, "content.js");
const MANIFEST_PATH = path.join(SRC_DIR, "manifest.json");
const BACKGROUND_SCRIPT_PATH = path.join(SRC_DIR, "background.js");

// Minimal mock DOM for testing content script behavior
function createMockElement({
  tagName = "div",
  nodeType = 1,
  attributes = {},
  isContentEditable = false,
  parent = null,
} = {}) {
  const attrs = { ...attributes };
  const element = {
    tagName: tagName.toUpperCase(),
    nodeType,
    attributes: attrs,
    isContentEditable,
    parentElement: parent,
    classList: {
      contains(cls) {
        return (attrs.class || "").split(/\s+/).includes(cls);
      },
    },
    getAttribute(name) {
      return attrs[name] ?? null;
    },
    setAttribute(name, value) {
      attrs[name] = String(value);
    },
    matches(selector) {
      if (selector === '[contenteditable="true"]') {
        return attrs.contenteditable === "true";
      }
      if (selector === '[role="textbox"]') {
        return attrs.role === "textbox";
      }
      if (selector === '[role="textbox"][contenteditable="true"]') {
        return attrs.role === "textbox" && attrs.contenteditable === "true";
      }
      if (selector.includes("ProseMirror")) {
        return (attrs.class || "").includes("ProseMirror");
      }
      if (selector.includes("ql-editor")) {
        return (attrs.class || "").includes("ql-editor");
      }
      if (selector.includes("comments-comment-box")) {
        return (attrs.class || "").includes("comments-comment-box");
      }
      if (selector.includes("msg-form")) {
        return (attrs.class || "").includes("msg-form");
      }
      if (selector.includes("share-creation-state")) {
        return (attrs.class || "").includes("share-creation-state");
      }
      if (selector.includes("ui-core-tiptap-text-editor-wrapper")) {
        return attrs["data-testid"] === "ui-core-tiptap-text-editor-wrapper";
      }
      return false;
    },
    closest(selector) {
      let current = this;
      while (current) {
        if (current.matches && current.matches(selector)) {
          return current;
        }
        current = current.parentElement;
      }
      return null;
    },
    dispatchEvent(event) {
      if (this.onBeforeInput) {
        return this.onBeforeInput(event);
      }
      return true;
    },
  };
  return element;
}

test("Topology verification: loose files removed from root and contained in /src/", () => {
  assert.equal(fs.existsSync(path.join(ROOT_DIR, "manifest.json")), false);
  assert.equal(fs.existsSync(path.join(ROOT_DIR, "content.js")), false);
  assert.equal(fs.existsSync(MANIFEST_PATH), true);
  assert.equal(fs.existsSync(CONTENT_SCRIPT_PATH), true);
  assert.equal(fs.existsSync(BACKGROUND_SCRIPT_PATH), true);
});

test("Manifest V3 compliance: validate manifest structure, icons, and safe browsing", () => {
  const manifest = JSON.parse(fs.readFileSync(MANIFEST_PATH, "utf8"));

  assert.equal(manifest.manifest_version, 3);
  assert.ok(manifest.name && manifest.name.length <= 45);
  assert.ok(manifest.description && manifest.description.length <= 132);
  assert.equal(manifest.version, "2.0.0");

  // Icons validation
  assert.ok(manifest.icons);
  for (const size of ["16", "32", "48", "128"]) {
    const iconRelativePath = manifest.icons[size];
    assert.ok(iconRelativePath, `Missing icon for size ${size}`);
    const fullIconPath = path.join(SRC_DIR, iconRelativePath);
    assert.ok(
      fs.existsSync(fullIconPath),
      `Icon file does not exist: ${fullIconPath}`,
    );
  }

  // Action declaration
  assert.ok(manifest.action);
  assert.ok(manifest.action.default_title);
  assert.ok(manifest.action.default_icon["16"]);
  assert.ok(manifest.action.default_icon["32"]);
  assert.ok(manifest.action.default_icon["48"]);

  // Background service worker
  assert.ok(manifest.background?.service_worker);
  assert.equal(manifest.background.service_worker, "background.js");
  assert.ok(
    fs.existsSync(path.join(SRC_DIR, manifest.background.service_worker)),
  );

  // Content scripts
  assert.ok(Array.isArray(manifest.content_scripts));
  assert.equal(manifest.content_scripts.length, 1);
  assert.deepEqual(manifest.content_scripts[0].matches, [
    "https://www.linkedin.com/*",
  ]);
  assert.deepEqual(manifest.content_scripts[0].js, ["content.js"]);
  assert.equal(manifest.content_scripts[0].run_at, "document_idle");

  // Permissions minimal audit
  assert.equal(manifest.permissions, undefined);
});

test("Production hygiene: content.js contains zero console.log statements", () => {
  const contentCode = fs.readFileSync(CONTENT_SCRIPT_PATH, "utf8");
  const hasConsoleLog = /console\.log\s*\(/.test(contentCode);
  assert.equal(
    hasConsoleLog,
    false,
    "Expected zero console.log statements in production content.js",
  );
});

test("Shortcut detection: should support Ctrl+B on Windows/Linux and Cmd+B on macOS", () => {
  const content = require(CONTENT_SCRIPT_PATH);
  assert.equal(typeof content.isBoldShortcut, "function");

  // Ctrl+B (Windows/Linux)
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: true,
      metaKey: false,
      altKey: false,
      shiftKey: false,
      key: "b",
    }),
    true,
  );
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: true,
      metaKey: false,
      altKey: false,
      shiftKey: false,
      key: "B",
    }),
    true,
  );
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: true,
      metaKey: false,
      altKey: false,
      shiftKey: false,
      code: "KeyB",
    }),
    true,
  );

  // Cmd+B (macOS)
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: false,
      metaKey: true,
      altKey: false,
      shiftKey: false,
      key: "b",
    }),
    true,
  );
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: false,
      metaKey: true,
      altKey: false,
      shiftKey: false,
      key: "B",
    }),
    true,
  );
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: false,
      metaKey: true,
      altKey: false,
      shiftKey: false,
      code: "KeyB",
    }),
    true,
  );
});

test("Shortcut restriction: strictly reject shift, alt, or non-bold keys (Italic/Underline)", () => {
  const content = require(CONTENT_SCRIPT_PATH);

  // Modifiers that must be rejected
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: true,
      metaKey: false,
      altKey: true,
      shiftKey: false,
      key: "b",
    }),
    false,
  );
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: true,
      metaKey: false,
      altKey: false,
      shiftKey: true,
      key: "b",
    }),
    false,
  );
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: false,
      metaKey: false,
      altKey: false,
      shiftKey: false,
      key: "b",
    }),
    false,
  );

  // Non-bold formatting commands must NOT be intercepted (bold-only constraint)
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: true,
      metaKey: false,
      altKey: false,
      shiftKey: false,
      key: "i",
    }),
    false,
  );
  assert.equal(
    content.isBoldShortcut({
      ctrlKey: true,
      metaKey: false,
      altKey: false,
      shiftKey: false,
      key: "u",
    }),
    false,
  );
  assert.equal(
    content.isBoldShortcut({
      metaKey: true,
      ctrlKey: false,
      altKey: false,
      shiftKey: false,
      key: "i",
    }),
    false,
  );
  assert.equal(
    content.isBoldShortcut({
      metaKey: true,
      ctrlKey: false,
      altKey: false,
      shiftKey: false,
      key: "u",
    }),
    false,
  );
});

test("DOM resilience: should find editor across multiple LinkedIn selectors and fallbacks", () => {
  const content = require(CONTENT_SCRIPT_PATH);
  assert.equal(typeof content.findLinkedInEditor, "function");

  // 1. Primary Tiptap wrapper
  const tiptapWrapper = createMockElement({
    attributes: { "data-testid": "ui-core-tiptap-text-editor-wrapper" },
  });
  const tiptapEditable = createMockElement({
    attributes: { contenteditable: "true" },
    isContentEditable: true,
    parent: tiptapWrapper,
  });
  assert.ok(content.findLinkedInEditor(tiptapEditable));

  // 2. ProseMirror class fallback
  const prosemirrorEditable = createMockElement({
    attributes: {
      contenteditable: "true",
      class: "editor-content ProseMirror",
    },
    isContentEditable: true,
  });
  assert.ok(content.findLinkedInEditor(prosemirrorEditable));

  // 3. ARIA role textbox fallback
  const ariaEditable = createMockElement({
    attributes: { contenteditable: "true", role: "textbox" },
    isContentEditable: true,
  });
  assert.ok(content.findLinkedInEditor(ariaEditable));

  // 4. Text node inside editor
  const textNode = { nodeType: 3, parentElement: ariaEditable };
  assert.ok(content.findLinkedInEditor(textNode));

  // 5. Non-editor element (e.g., plain input or regular div) must be rejected
  const plainDiv = createMockElement({
    attributes: { class: "feed-post" },
    isContentEditable: false,
  });
  assert.equal(content.findLinkedInEditor(plainDiv), null);

  const plainInput = createMockElement({
    tagName: "input",
    attributes: { type: "text" },
    isContentEditable: false,
  });
  assert.equal(content.findLinkedInEditor(plainInput), null);
});

test("Edge cases: handle empty selection, rapid repeated presses, and non-throwing execution", () => {
  const content = require(CONTENT_SCRIPT_PATH);

  const fakeEditor = createMockElement({
    attributes: { contenteditable: "true", role: "textbox" },
    isContentEditable: true,
  });

  let execCommandCount = 0;
  const fakeDoc = {
    execCommand(cmd) {
      if (cmd === "bold") {
        execCommandCount++;
        return true;
      }
      return false;
    },
  };

  const fakeEvent = {
    ctrlKey: true,
    metaKey: false,
    altKey: false,
    shiftKey: false,
    key: "b",
    target: fakeEditor,
    preventDefault() {},
    stopPropagation() {},
  };

  // Simulate multiple rapid Ctrl+B presses
  assert.doesNotThrow(() => {
    content.handleKeyDown(fakeEvent, fakeDoc);
    content.handleKeyDown(fakeEvent, fakeDoc);
    content.handleKeyDown(fakeEvent, fakeDoc);
  });

  assert.equal(execCommandCount, 3);

  // Empty target or null editor edge case
  assert.doesNotThrow(() => {
    content.handleKeyDown({ ctrlKey: true, key: "b", target: null }, fakeDoc);
  });
});
