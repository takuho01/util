import "@logseq/libs";

async function duplicateLine() {
  const block = await logseq.Editor.getCurrentBlock();
  if (!block) {
    logseq.App.showMsg("No block selected.");
    return;
  }
  await logseq.Editor.insertBlock(block.uuid, "", { sibling: true, before: false });
}

function main() {
  logseq.Editor.registerSlashCommand("duplicate line", duplicateLine);
  logseq.App.registerCommandPalette(
    {
      key: "duplicate-line",
      label: "Duplicate Line"
    },
    duplicateLine
  );
  logseq.App.showMsg("Logseq Duplicate Line Plugin Loaded!");
}

logseq.ready(main).catch(console.error);
