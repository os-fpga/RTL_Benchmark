#!/bin/bash -p
# Copyright (c) 2013 Qualcomm Technologies, Inc. All rights reserved.

if [ "${FLEXNOC_IMPORTLVL}" != "DEV" -a "${FLEXNOC_HOME}" == "" ]; then
    ERRNO=1
    echo "[ERROR][${ERRNO}] Environment variable FLEXNOC_HOME has not been set."
    echo ""
    echo "Use one of the following pairs of commands, as appropriate for your"
    echo "shell, to set the FLEXNOC_HOME environment variable by replacing the"
    echo "PATH_TO ... placeholder in the command line with your actual FLEXNOC"
    echo "installation directory, then sourcing the configuration script:"
    echo ""
    echo "   - for a BASH environment, type: "
    echo "       export FLEXNOC_HOME=PATH_TO_FLEXNOC_INSTALLATION_DIRECTORY"
    echo "     then type: "
    echo "       source \${FLEXNOC_HOME}/etc/bashrc"
    echo ""
    echo "   - for a TCSH environment, type:"
    echo "       setenv FLEXNOC_HOME PATH_TO_FLEXNOC_INSTALLATION_DIRECTORY"
    echo "     then type: "
    echo "       source \${FLEXNOC_HOME}/etc/tcshrc"
    exit ${ERRNO};
fi
if [ "${FLEXNOC_IMPORTLVL}" != "DEV" -a "${FLEXNOC_HOME:0:1}" != "/" ]; then
    ERRNO=2
    echo "[ERROR][${ERRNO}] Environment variable FLEXNOC_HOME must be set to an "
    echo "absolute path, instead of \"${FLEXNOC_HOME}\"."
    echo ""
    echo "Use one of the following pairs of commands, as appropriate for your"
    echo "shell, to set the FLEXNOC_HOME environment variable by replacing the"
    echo "PATH_TO ... placeholder in the command line with your actual FLEXNOC"
    echo "installation directory, then sourcing the configuration script:"
    echo ""
    echo "   - for a BASH environment, type:"
    echo "       export FLEXNOC_HOME=PATH_TO_FLEXNOC_INSTALLATION_DIRECTORY"
    echo "     then type:"
    echo "       source \${FLEXNOC_HOME}/etc/bashrc"
    echo ""
    echo "   - for a TCSH environment, type:"
    echo "       setenv FLEXNOC_HOME PATH_TO_FLEXNOC_INSTALLATION_DIRECTORY"
    echo "     then type:"
    echo "       source \${FLEXNOC_HOME}/etc/tcshrc"
    exit ${ERRNO};
fi
if [ "${FLEXNOC_IMPORTLVL}" == "PKG" -a "`cd ${FLEXNOC_HOME}/bin;pwd;`/FlexNoC" != "$(which FlexNoC)" ]; then
    ERRNO=4
    echo "[ERROR][${ERRNO}] Your current path: \"$(which FlexNoC)\", does not match the path defined by your FLEXNOC_HOME environment variable: \"`cd ${FLEXNOC_HOME}/bin;pwd;`/FlexNoC\"."
    echo ""
    echo "Use one of the following pairs of commands, as appropriate for your"
    echo "shell, to set the FLEXNOC_HOME environment variable by replacing the"
    echo "PATH_TO ... placeholder in the command line with your actual FLEXNOC"
    echo "installation directory, then sourcing the configuration script:"
    echo ""
    echo "   - for a BASH environment, type:"
    echo "       export FLEXNOC_HOME=PATH_TO_FLEXNOC_INSTALLATION_DIRECTORY"
    echo "     then type:"
    echo "       source \${FLEXNOC_HOME}/etc/bashrc"
    echo ""
    echo "   - for a TCSH environment, type:"
    echo "       setenv FLEXNOC_HOME PATH_TO_FLEXNOC_INSTALLATION_DIRECTORY"
    echo "     then type:"
    echo "       source \${FLEXNOC_HOME}/etc/tcshrc"
    exit ${ERRNO};
fi
if [ "${FLEXNOC_SHARE}" == "" -o "${FLEXNOC_IMPORTLVL}" == "" -o "${FLEXNOC_CFLAGS}" == "" -o "${FLEXNOC_PATH}" == "" ]; then
    ERRNO=3
    echo "[ERROR][${ERRNO}] The FLEXNOC environment script has not been sourced."
    echo ""
    echo "Use one of the following pairs of commands, as appropriate for your"
    echo "shell, to set the FLEXNOC_HOME environment variable by replacing the"
    echo "PATH_TO ... placeholder in the command line with your actual FLEXNOC"
    echo "installation directory, then sourcing the configuration script:"
    echo ""
    echo "   - for a BASH environment, type:"
    echo "       export FLEXNOC_HOME=PATH_TO_FLEXNOC_INSTALLATION_DIRECTORY"
    echo "     then type:"
    echo "       source \${FLEXNOC_HOME}/etc/bashrc"
    echo ""
    echo "   - for a TCSH environment, type:"
    echo "       setenv FLEXNOC_HOME PATH_TO_FLEXNOC_INSTALLATION_DIRECTORY"
    echo "     then type:"
    echo "       source \${FLEXNOC_HOME}/etc/tcshrc"
    exit ${ERRNO};
fi

function check_compilator {
	if [ "${GCC_HOME}" == "" ]; then
		ERRNO=5
		echo "[ERROR][${ERRNO}] Could not find G++ in the PATH, please set GCC_HOME"
		echo "   - for a BASH environment, type:"
		echo "       export GCC_HOME=PATH_TO_GCC_INSTALLATION_DIRECTORY"
		echo ""
		echo "   - for a TCSH environment, type:"
		echo "       setenv GCC_HOME PATH_TO_GCC_INSTALLATION_DIRECTORY"
		exit ${ERRNO};
	fi
}

function check_systemc {
	if [ "${SYSTEMC_HOME}" == "" ]; then
		ERRNO=6
		echo "[ERROR][${ERRNO}] Environment variable SYSTEMC_HOME had not been set."
		echo "   - for a BASH environment, type:"
		echo "       export SYSTEMC_HOME=PATH_TO_SYSTEMC_INSTALLATION_DIRECTORY"
		echo ""
		echo "   - for a TCSH environment, type:"
		echo "       setenv SYSTEMC_HOME PATH_TO_SYSTEMC_INSTALLATION_DIRECTORY"
		exit ${ERRNO};
	fi
}

function check_tlm {
	if [ "${TLM_INCLUDE}" == "" ]; then
		ERRNO=8
		echo "[ERROR][${ERRNO}] Environment variable TLM_INCLUDE had not been set."
		echo "   - for a BASH environment, type:"
		echo "       export TLM_INCLUDE=PATH_TO_TLM_INSTALLATION_DIRECTORY"
		echo ""
		echo "   - for a TCSH environment, type:"
		echo "       setenv TLM_INCLUDE PATH_TO_TLM_INSTALLATION_DIRECTORY"
		exit ${ERRNO};
	fi
}

function check_gmp {
	if [ "${GMP_LIB}" == "" ]; then
		ERRNO=9
		echo "[ERROR][${ERRNO}] Environment variable GMP_LIB had not been set."
		echo "   - for a BASH environment, type:"
		echo "       export GMP_LIB=PATH_TO_GMP_LIBRARY_DIRECTORY"
		echo ""
		echo "   - for a TCSH environment, type:"
		echo "       setenv GMP_LIB PATH_TO_GMP_LIBRARY_DIRECTORY"
		exit ${ERRNO};
	fi
	if [ "${GMP_INCLUDE}" == "" ]; then
		ERRNO=10
		echo "[ERROR][${ERRNO}] Environment variable GMP_INCLUDE had not been set."
		echo "   - for a BASH environment, type:"
		echo "       export GMP_INCLUDE=PATH_TO_GMP_INCLUDE_DIRECTORY"
		echo ""
		echo "   - for a TCSH environment, type:"
		echo "       setenv GMP_INCLUDE PATH_TO_GMP_INCLUDE_DIRECTORY"
		exit ${ERRNO};
	fi
}


while [ $# -gt 0 ]
do
	case "$1" in
		-sc) check_compilator
			 check_systemc
			 check_tlm
			 check_gmp
		;;
		*)  echo "${1} not correct !"
		echo >&2 "usage: $0 [-sc]"
		exit 1;;
	esac
	shift
done

if [ "$1" != "" ]; then
    REPORT=$1
    echo -n "Date : " > ${REPORT}
    date >> ${REPORT} 2>&1
    echo -n "uname -a : " >> ${REPORT}
    uname -a >> ${REPORT} 2>&1
    echo "" >> ${REPORT}
    echo "ldd -v ${FLEXNOC_HOME}/externals/lib/libQtNetwork.so : " >> ${REPORT}
    ldd -v ${FLEXNOC_HOME}/externals/lib/libQtNetwork.so >> ${REPORT} 2>&1
    echo "" >> ${REPORT}
    echo "ldd -v ${FLEXNOC_HOME}/externals/lib/libQtGui.so : " >> ${REPORT}
    ldd -v ${FLEXNOC_HOME}/externals/lib/libQtGui.so >> ${REPORT} 2>&1
    echo "" >> ${REPORT}
    echo "ldd -v ${FLEXNOC_HOME}/share/tools/exported/bin/mainLauncher.out : " >> ${REPORT}
    ldd -v ${FLEXNOC_HOME}/share/tools/exported/bin/mainLauncher.out >> ${REPORT} 2>&1
    echo "" >> ${REPORT}
    echo "ldd -v ${FLEXNOC_HOME}/externals/lib/python2.7/site-packages/PyQt4/QtWebKit.so : " >> ${REPORT}
    ldd -v ${FLEXNOC_HOME}/externals/lib/python2.7/site-packages/PyQt4/QtWebKit.so >> ${REPORT} 2>&1
    echo "" >> ${REPORT}
    echo -n "Which gcc : " >> ${REPORT}
    which gcc >> ${REPORT} 2>&1
    echo "" >> ${REPORT}
    echo -n "gcc -v : " >> ${REPORT}
    gcc -v >> ${REPORT} 2>&1
    echo "" >> ${REPORT}
    echo "" >> ${REPORT}
    echo -n "Which ld : " >> ${REPORT}
    which ld >> ${REPORT} 2>&1
    echo -n "ld -V : " >> ${REPORT}
    ld -V >> ${REPORT} 2>&1
fi
