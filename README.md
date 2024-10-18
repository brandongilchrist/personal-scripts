# Personal Scripts

A collection of personal utility scripts for macOS to streamline daily tasks.

## Scripts

### `combine_files`

**Description:** Combines all `.txt` or `.md` files in the current directory into a single file.

**Usage:**
	```bash
	combine_files <extension> [output_filename]
	```

**Examples:**
	
    •	Combine all .txt files into combined.txt:

	```bash
	combine_files txt combined.txt
	```
 
    •	Combine all .md files into markdown_collection.md:

	```bash
	combine_files md markdown_collection.md
	```

Notes:
	•	Supported extensions: .txt, .md
	•	If output_filename is not specified, defaults to combined.<extension>
	•	Existing output file is overwritten without warning

## Installation

See the Installation section below.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.
License

This project is licensed under the CC0 license.

