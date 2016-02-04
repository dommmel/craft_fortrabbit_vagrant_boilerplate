#!/bin/bash

# Working dir is one level above
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

wget "http://buildwithcraft.com/latest.zip?accept_license=yes" -N -P /tmp && \
rm -rf /tmp/craft && \
unzip -q -o "/tmp/latest.zip?accept_license=yes" -d /tmp/craft && \
rm -rf ${DIR}/craft/app && mv /tmp/craft/craft/app craft && \
if [ -d ${DIR}/craft_customizations ]
 then rsync -a -v ${DIR}/craft_customizations/ ${DIR}/craft
fi