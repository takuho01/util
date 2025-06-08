

document.addEventListener("keydown", (e) => {
  if (e.ctrlKey && e.shiftKey && e.key === "Enter") {
    const blockId = logseq.api.get_current_block().uuid;
    const options = { focus: true, sibling: true, before: false };
    logseq.api.insert_block(blockId, "", options);
    e.preventDefault();
  }
});


