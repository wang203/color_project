awk '{print $1;}' tag/tag4binsum > tag/tagidx
awk '{print $1;}' tagfemale/tag4binsum > tagfemale/tagidx
awk '{print $1;}' tagmale/tag4binsum > tagmale/tagidx

awk '{print $2;}' tag/tag4binsum > tag/tagtext
awk '{print $2;}' tagfemale/tag4binsum > tagfemale/tagtext
awk '{print $2;}' tagmale/tag4binsum > tagmale/tagtext

awk '{print $3;}' tag/tag4binsum > tag/tagentropy
awk '{print $3;}' tagfemale/tag4binsum > tagfemale/tagentropy
awk '{print $3;}' tagmale/tag4binsum > tagmale/tagentropy
