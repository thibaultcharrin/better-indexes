# better-indexes
Simple ETL script flatten folder structure by consolidating filepath onto filename

# Requirements

- Bash 5.* and above
- Git 2.3* and above

# Getting Started

In a bash terminal, clone repository to your home folder:

```bash
cd $HOME && git clone https://github.com/thibaultcharrin/better-indexes.git
```

Add a source folder for which you want to flatten the folder structure and run the script by passing the `source_folder` and `destination_folder` as arguments:

```bash
./etl.sh #SOURCE_FOLDER #DESTINATION_FOLDER
```

Your destination folder is created with your newly indexed files.

You're all set!  
