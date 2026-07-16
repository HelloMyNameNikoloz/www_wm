import { copyFile, mkdir, rm } from "node:fs/promises";


const flagCodes = [
  "ar", "at", "au", "ba", "be", "br", "ca", "cd", "ch", "ci", "co", "cv",
  "cw", "cz", "de", "dz", "ec", "eg", "es", "fr", "gb-eng", "gb-sct", "gh",
  "hr", "ht", "iq", "ir", "jo", "jp", "kr", "ma", "mx", "nl", "no", "nz",
  "pa", "pt", "py", "qa", "sa", "se", "sn", "tn", "tr", "us", "uy", "uz",
  "za"
];

const lucideIcons = [
  "arrow-left", "arrow-right", "calendar-days", "check", "chevron-down", "chevron-up",
  "circle-check", "circle-help", "clock-3", "code-2", "coins", "copy", "flag", "gem",
  "globe-2", "house", "layout-grid", "list-ordered", "mail", "map-pin", "moon",
  "rotate-ccw", "sun", "ticket", "trash-2", "user-round", "wallet", "x"
];

const flagPackage = new URL("../node_modules/flag-icons/", import.meta.url);
const lucidePackage = new URL("../node_modules/lucide-static/", import.meta.url);
const flagsOutput = new URL("../public/flags/", import.meta.url);
const iconsOutput = new URL("../public/icons/lucide/", import.meta.url);

await Promise.all([
  rm(flagsOutput, { recursive: true, force: true }),
  rm(iconsOutput, { recursive: true, force: true })
]);
await Promise.all([
  mkdir(flagsOutput, { recursive: true }),
  mkdir(iconsOutput, { recursive: true })
]);

await Promise.all([
  ...flagCodes.map((code) =>
    copyFile(new URL(`flags/4x3/${code}.svg`, flagPackage), new URL(`${code}.svg`, flagsOutput))
  ),
  ...lucideIcons.map((name) =>
    copyFile(new URL(`icons/${name}.svg`, lucidePackage), new URL(`${name}.svg`, iconsOutput))
  )
]);

await Promise.all([
  copyFile(new URL("LICENSE", flagPackage), new URL("LICENSE-flag-icons.txt", flagsOutput)),
  copyFile(new URL("LICENSE", lucidePackage), new URL("LICENSE-lucide.txt", iconsOutput))
]);
