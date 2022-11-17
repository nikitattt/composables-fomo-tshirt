# Art

For storing art on chain it has to be RLE encoded. For this you will have to change/add your art to `images` folder and run the `yarn encode` command.

As the result you will have `src/image-data.json` file with all the data you need.

Resulting byte string(`data` field) is then used to save image in the contract:

```json
...
    {
        "filename": "image-file-name",
        "data": "0x00...0801"
    },
...
```

You also will have palette array that you'll need to concatenate (sum up all hex values to have one string)

For example:

```json
"palette": [
    "",
    "ffffff",
    "ff0e0e",
    "000000",
    "00a556"
]
```

Will have to be like this: `0x000000ffffffff0e0e00000000a556`
