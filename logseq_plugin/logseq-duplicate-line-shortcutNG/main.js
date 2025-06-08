// main.js - Logseq Duplicate Line Plugin

// Ensure Logseq API is available
if (typeof logseq !== "undefined") {
  logseq.ready(() => {
    // Duplicate line logic as a function
    async function duplicateLine() {
      const block = await logseq.Editor.getCurrentBlock();
      if (!block) {
        logseq.App.showMsg("No block selected.");
        return;
      }
      // Insert a blank block at the same indent level (sibling)
      await logseq.Editor.insertBlock(block.uuid, "", { sibling: true, before: false });
    }

    // Register the "duplicate line" slash command
    logseq.Editor.registerSlashCommand("duplicate line", duplicateLine);

    // Register a command palette command for config.edn mapping
    logseq.App.registerCommandPalette(
      {
        key: "duplicate-line",
        label: "Duplicate Line"
      },
      duplicateLine
    );

    logseq.App.showMsg("Logseq Duplicate Line Plugin Loaded!");
  }).catch(console.error);
}
