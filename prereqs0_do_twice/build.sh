#! /bin/bash

SYSARCH=$(uname -m)

mods="
                               perl-Archive-Zip
                               perl-YAML-LibYAML
                              perl-Module-Build
                              perl-PAR-Dist
                              perl-SUPER
                              perl-Sub-Identify
                              perl-inc-latest
                             perl-Test-MockModule
                          perl-List-MoreUtils
                         perl-Exporter-Tiny
                         perl-List-MoreUtils-XS
"

rm -f build_failures.txt
rm -f test_failures.txt
touch build_failures.txt
touch test_failures.txt
exit_status=0
for m in $mods
do
    mv -f ${m}* ${m}
    cd ${m}
    eval $(grep ^NAME *.cygport)
    eval $(grep ^VERSION *.cygport)
    eval $(grep ^RELEASE *.cygport)
    ARCH=${SYSARCH}
    eval $(grep ^ARCH *.cygport)
    PVR=${NAME}-${VERSION}-${RELEASE}
    mv -f ${PVR}.cygport ${NAME}.cygport
    if [ -f ${NAME}-${VERSION}-${RELEASE}.src.patch ]
    then
	mv ${NAME}-${VERSION}-${RELEASE}.src.patch achim.patch
	echo 'PATCH_URI="achim.patch"' >> ${NAME}.cygport
    fi
    if [ ${RELEASE} = 1 ]
    then
	sed -i -e 's/RELEASE=1/RELEASE=2' ${NAME}.cygport
    fi
    echo "Building $m..."
    if cygport ${NAME}.cygport all
    then
	cygport ${NAME}.cygport test || echo $m >> ../test_failures.txt
	if [ ${SYSARCH} = x86_64 ]
	then
	    cp -alf $
	else
	    DEST_ARCH=${ARCH}
	fi
	cp -alf 
	


	exit_status=1
	echo $m >> ../build_failures.txt
	
	
   
