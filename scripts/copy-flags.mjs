import { copyFile, mkdir, rm } from "node:fs/promises";


const flagCodes = [
  "ar", "at", "au", "ba", "be", "br", "ca", "cd", "ch", "ci", "co", "cv",
  "cw", "cz", "de", "dz", "ec", "eg", "es", "fr", "gb-eng", "gb-sct", "gh",
  "hr", "ht", "iq", "ir", "jo", "jp", "kr", "ma", "mx", "nl", "no", "nz",
  "pa", "pt", "py", "qa", "sa", "se", "sn", "tn", "tr", "us", "uy", "uz",
  "za"
];

const packageDirectory = new URL("../node_modules/flag-icons/", import.meta.url);
const outputDirectory = new URL("../public/flags/", import.meta.url);

await rm(outputDirectory, { recursive: true, force: true });
await mkdir(outputDirectory, { recursive: true });

await Promise.all(
  flagCodes.map((code) =>
    copyFile(
      new URL(`flags/4x3/${code}.svg`, packageDirectory),
      new URL(`${code}.svg`, outputDirectory)
    )
  )
);

await copyFile(
  new URL("LICENSE", packageDirectory),
  new URL("LICENSE-flag-icons.txt", outputDirectory)
);
