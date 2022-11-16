import { PNGCollectionEncoder, PngImage } from "@nouns/sdk";
import { promises as fs } from "fs";
import path from "path";
import { readPngImage } from "./utils";

const DESTINATION = path.join(__dirname, "../src/image-data.json");

const encode = async () => {
  const encoder = new PNGCollectionEncoder();

  const folderpath = path.join(__dirname, "../images");
  const files = await fs.readdir(folderpath);
  for (const file of files) {
    const image = await readPngImage(path.join(folderpath, file));
    encoder.encodeImage(file.replace(/\.png$/, ""), image);
  }
  await fs.writeFile(
    DESTINATION,
    JSON.stringify(
      {
        bgcolors: [],
        ...encoder.data,
      },
      null,
      2
    )
  );
};

encode();
