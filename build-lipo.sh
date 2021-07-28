BUILD_DIR=$1
rm -rf $BUILD_DIR
mkdir $BUILD_DIR

for lib in $2/output/*.a; do
    name=`basename $lib`
    inputs=""
    for ((i = 2; i <= $#; i++ )); do
        inputs="$inputs ${!i}/output/$name"
    done
    lipo -create $inputs -output $BUILD_DIR/$name
done
