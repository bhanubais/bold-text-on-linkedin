# Skill: TDD Rules (Test-Driven Development)

## Purpose
Enforce test-first development practices for the extension codebase.

## Rules
1. **Red → Green → Refactor.** Write a failing test first. Make it pass. Then clean up.
2. **No production code without a corresponding test.**
3. **Test behavior, not implementation.** "When user presses Ctrl+B with text selected, text becomes bold" — not "when execCommand is called."
4. **Edge cases are first-class tests:**
   - Empty selection
   - Already-bold text (toggle)
   - Cursor in non-LinkedIn editor
   - Multiple rapid Ctrl+B presses
   - Selection spanning formatting boundaries
5. **Test isolation.** Each test must be independent. No shared state between tests.
6. **Name tests as specifications.** `should_apply_bold_when_text_selected_and_ctrl_b_pressed`

## Tooling for Chrome Extensions
- Unit tests: Jest or Vitest for pure logic.
- Integration tests: Puppeteer or Playwright for end-to-end browser testing.
- Manual testing: Required for LinkedIn-specific DOM validation (LinkedIn blocks automated testing).
