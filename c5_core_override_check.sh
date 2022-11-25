#!/bin/bash
#
# Concrete CMS Core Override Checker
# ----------
# Version 1.0.0
# By katzueno
#
# INSTRUCTION:
# https://github.com/katzueno/c5_core_override_check
# ----------
# USE IT AT YOUR OWN RISK!
# LICENSE: MIT

# Parameters
DIR_WORKING=$1
DIR_CONCRETE5=$2
## Get Download URL and version from https://www.concrete5.org/developers/developer-downloads/
CONCRETE5_VERSION="8.5.12"
URL_CONCRETE5="https://www.concretecms.org/download_file/2bba0898-1539-48ff-b273-0cbddc7588da"

# ==============================
#
# DO NOT TOUCH BELOW THIS LINE (unless you know what you're doing.)
#
# ==============================

echo " -- -- -- -- -- -- -- -- -- -- --"
echo "  Concrete CMS core file checker v 1.0.0"
echo " -- -- -- -- -- -- -- -- -- -- --"
echo "Please check the following parameters:"
echo ""
echo "Working Directory   : ${DIR_WORKING}"
echo "Concrete CMS Directory : ${DIR_CONCRETE5}"
echo "Concrete CMS Version   : ${CONCRETE5_VERSION}"
echo "Concrete CMS URL       : ${URL_CONCRETE5}"
echo " -- -- -- -- -- -- -- -- -- -- --"
echo "[y]. Proceed?"
echo "[q]. Quit?"
read -p "Enter your selection:  (y/q): " yesno
case "$yesno" in [yY]*) ;; *) echo "OK. See you soon!" ; exit 0 ;; esac

while :
do
    echo "Starting"
    break
done

# https://unix.stackexchange.com/questions/285924/how-to-compare-a-programs-version-in-a-shell-script
requiredver="8.0.0"
if [ "$(printf '%s\n' "$requiredver" "${CONCRETE5_VERSION}" | sort -V | head -n1)" = "$requiredver" ]; then 
  echo "Greater than or equal to ${requiredver}. We are proceeding"
else
  echo "Less than ${requiredver}"
fi

requiredver="8.5.8"
if [ "$(printf '%s\n' "$requiredver" "${CONCRETE5_VERSION}" | sort -V | head -n1)" = "$requiredver" ]; then 
  CONCRETE5_PACKAGE_DIRECTORY_NAME="concrete-cms-${CONCRETE5_VERSION}"
else
  CONCRETE5_PACKAGE_DIRECTORY_NAME="concrete5-${CONCRETE5_VERSION}"
fi

echo "cd to working directory (doesn't do much)"
echo "${DIR_WORKING}"
cd ${DIR_WORKING}
echo "Copying concrete directory of web to working directory"
cp -r ${DIR_CONCRETE5}/concrete concrete5_web
echo "Fetching original concrete5 core file"
## wget concrete5-8.5.2-original.zip https://www.concrete5.org/download_file/-/view/111592/8497/
wget -O ${CONCRETE5_PACKAGE_DIRECTORY_NAME}-original.zip ${URL_CONCRETE5}
echo "Unzipping original concrete5 package to the working directory"
## unzip concrete5-8.5.2-original.zip
unzip ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME}-original.zip
echo "Moving concrete directory of original package to the working directory"
## mv concrete5-8.5.2/concrete concrete5-8.5.2-original
mv ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME}/concrete ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME}-original
echo "Removing concrete5 original zip file"
## rm concrete5-8.5.2-original.zip
rm ${CONCRETE5_PACKAGE_DIRECTORY_NAME}-original.zip
echo "Now diffing the difference between original package & concrete folder on web server"
## diff -Nurd concrete5-8.5.2-original concrete5_web > concrete5.diff
diff -Nurd ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME}-original ${DIR_WORKING}/concrete5_web > ${DIR_WORKING}/concrete5.diff
echo "Result:"
wc -c < ${DIR_WORKING}/concrete5.diff
echo "If the result is 0, it's success."

if [ -s ${DIR_WORKING}/concrete5.diff ]; then
    echo "********************"
    echo "WARNING: There is some core override."
    echo "********************"
    CURRENT_TIME=$(date "+%Y%m%d%H%M%S")
    echo "Saving diff file as:"
    echo "--> ${DIR_WORKING}/concrete5_${CURRENT_TIME}.diff."
    echo "Make sure to check the diff file!"
    cp ${DIR_WORKING}/concrete5.diff ${DIR_WORKING}/concrete5_${CURRENT_TIME}.diff
else
    echo "Congratulations! No concrete5 core override!"
fi

echo " -- -- -- -- -- -- -- -- -- -- --"
echo "Would you like to delete temporary directory & files?"
echo " -- -- -- -- -- -- -- -- -- -- --"
echo "- ${DIR_WORKING}/concrete5_web"
echo "- ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME}"
echo "- ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME}-original"
echo "- ${DIR_WORKING}/concrete5.diff"
echo " -- -- -- -- -- -- -- -- -- -- --"
echo "[y]. Yes?"
echo "[q]. Quit?"
read -p "Enter your selection:  (y/q): " yesno
case "$yesno" in [yY]*) ;; *) echo "Exiting WITHOUT deleting working files. Good bye." ; exit 0 ;; esac
while :
do
    echo "Starting"
    break
done

echo "Deleting the following temporary directory & files"
echo "- ${DIR_WORKING}/concrete5_web"
echo "- ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME}"
echo "- ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME}-original"
echo "- ${DIR_WORKING}/concrete5.diff"
rm -r ${DIR_WORKING}/concrete5_web ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME} ${DIR_WORKING}/${CONCRETE5_PACKAGE_DIRECTORY_NAME}-original ${DIR_WORKING}/concrete5.diff
echo "All Done."
