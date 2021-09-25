# svg-check
Fixes incompatibilities in .svg icon files that stop them being imported into the yEd diagram editor.

syntax ./svg-check svgfilename.svg

The script will create a subfolder called svgout and the output file/s
will be put in there. Existing file swith matching names will be 
overwritten.

To use this script to process multiple files, try:
find . -maxdepth 1 -name "*.svg" -exec ./svg-check.sh '{}' \;

This is free and unencumbered software released into the public domain.
