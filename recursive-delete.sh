#!/bin/bash
for parentfolder in *; do
  cd "$parentfolder" || exit

  for folder in *; do
    cd "$folder" || exit

    for filename in *; do
      if [[ -f "$filename" ]]; then
        base=${filename%.*}
        ext=${filename#"$base".}
        mkdir -p "${ext}"
        mv "$filename" "${ext}"
      fi
    done
    cd ..

  done
  cd ..
  rm -rf POKES csw dck fdi ipf mdr mgt opd rom scl slt sp szx trd udi
done
