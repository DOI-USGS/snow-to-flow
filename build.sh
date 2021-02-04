echo "this is the var $E_VUE_BUILD_MODE"
if [ "$E_VUE_BUILD_MODE" = "test" ]
then npm run build-test
elif [ "$E_VUE_BUILD_MODE" = "beta" ]
then npm run build-beta
else npm run build
fi
