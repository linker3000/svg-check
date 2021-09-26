#!/bin/bash
#
# svg-check
#
# V1.0 N. Kendrick (linker3000@gmail.com)
#
# This bash script parses svg files for known issues that prevent
# the files being imported in yEd as icons
#
# syntax ./svg-check.sh svgfilename.svg
#
# The script will create a subfolder called svgout and the output file/s
# will be put in there. Existing files with matching names will be 
# overwritten.
#
# To use this script to process multiple files, try:
#
# find . -maxdepth 1 -name "*.svg" -exec ./svg-check.sh '{}' \;
#
# This is free and unencumbered software released into the public domain.
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# In jurisdictions that recognize copyright laws, the author or authors
# of this software dedicate any and all copyright interest in the
# software to the public domain. We make this dedication for the benefit
# of the public at large and to the detriment of our heirs and
# successors. We intend this dedication to be an overt act of
# relinquishment in perpetuity of all present and future rights to this
# software under copyright law.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# For more information, please refer to <http://unlicense.org/> 
#
# E&OE. This code is supplied 'as is' with no support.
#
fname=$1
oname="svgout/${fname}"

if [ -z "{$1}" ]; then
  echo "No file name specified - use: command filename"
  exit 1
fi   
 
mkdir -p svgout
rm -f "${oname}"

if [ -f "$fname" ]; then
  echo -n "Converting ${fname} ->> ${oname}..." 
 
  while read line || [ -n "$line" ]; do  

  # Fix stop without an offset    
    if [[ $line == *"stop"* ]]; then
      if ! [[ $line == *"offset"* ]]; then
        line="${line/stop/'stop offset="0"'}\n" >> "${oname}"
      fi
    fi

  #fix feBlend mode="hard-light" is not supported
    if [[ $line == *"feBlend"* ]]; then
      if [[ $line == *"hard-light"* ]]; then
        line="${line/hard-light/normal}\n" >> "${oname}"
      fi
    fi

    printf "$line\n" >> "${oname}"
  done < "${fname}"
  echo "Done!"
else
  echo "File $fname does not exist"
fi
