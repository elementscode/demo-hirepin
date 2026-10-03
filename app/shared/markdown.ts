import { Marked } from "marked";

function escapeHtml(text: string): string {
  return text
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}

// Employers write these descriptions and anyone reads them, so markdown is all
// that renders: raw html shows as text, and a link must be http, https or
// mailto. Images are dropped to their alt text so a listing cannot pull in
// third-party pixels.
const marked = new Marked({
  gfm: true,
  renderer: {
    html({ text }) {
      return escapeHtml(text);
    },

    link({ href, tokens }) {
      if (!/^(https?:|mailto:)/i.test(href)) {
        return this.parser.parseInline(tokens);
      }

      return false;
    },

    image({ text }) {
      return escapeHtml(text);
    },
  },
});

export function renderMarkdown(source: string): string {
  return marked.parse(source, { async: false }) as string;
}
