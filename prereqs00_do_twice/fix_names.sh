#! /bin/bash

for d in *.src
do
    if [ -d ${d} ]
    then
	m=$(echo ${d} | sed -e 's/[-.0-9]*\.src$//')
	mv ${d} ${m} || exit 1
	echo "Entering ${m}..."
	cd ${m} || exit 1
	eval $(grep '^VERSION=' *.cygport)
	if [ -f ${m}-${VERSION}-1.cygport ]
	then
	    mv ${m}-${VERSION}-1.cygport ${m}.cygport || exit 1
	fi
	if [ -f ${m}-${VERSION}-1.src.patch ]
	then
	    mv ${m}-${VERSION}-1.src.patch achim.patch || exit 1
	    echo 'PATCH_URI="achim.patch"' >> ${m}/${m}.cygport	|| exit 1
	fi
	eval $(grep '^RELEASE=' *.cygport)
	if [ ${RELEASE} = 1 ]
	then
	    sed -i -e 's/^RELEASE=.*/RELEASE=2/' ${m}.cygport
	fi
	if [ ${RELEASE} != 2 ]
	then
	    echo "Warning: RELEASE = ${RELEASE}."
	fi
	echo "Leaving ${m}."
	cd ..
    fi
done
