file(REMOVE_RECURSE
  "libllava.pdb"
  "libllava.so"
)

# Per-language clean rules from dependency scanning.
foreach(lang CXX)
  include(CMakeFiles/llava_shared.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
