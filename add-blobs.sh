#!/bin/bash

IFS='
'
pkg=""
blob=""
pkg_name=""
counter=0
for x in $(ls -l blobs-del/*/*); do
  # echo $x
  if [[ "${x}" == blobs-del/* ]]; then
    pkg=$(echo $x | awk '{ FS = ":" ; print $1 }' | sed s'/.$//');
    pkg_name=$(echo $pkg | awk -F'/' '{print $2}');
    # echo "$pkg $pkg_name"
  fi
  if [[ "${x}" == *.tar.* ]]; then
    blob=$(echo $x | awk '{ print $9 }');
    # echo "blob: $blob"
    # echo "pkg: $pkg"
    if [[ "${blob}" == '' ]]; then
      let counter=counter+1
    else
      #echo "${counter}) cp ${pkg}/${blob} tmp/$blob"
      #echo "bosh add blob tmp/${blob} ${pkg_name}"
      #cp $pkg/$blob tmp/$blob
      bosh add blob tmp/${blob} ${pkg_name}
    fi
  fi
done
