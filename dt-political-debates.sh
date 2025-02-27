#!/bin/bash
ODTP_USER_EMAIL=example@mail.com
DT_PATH=$(pwd)

DIGITAL_TWIN_NAME=dt-political-debates-1
EXECUTION_NAME=dt-political-debates-execution-1

# Removing gitkeep
rm ${DT_PATH}/dt-political-debates/execution/.gitkeep

# Pulling all the components and versions
odtp new odtp-component-entry \
--component-version v1.0.0 \
--repository https://github.com/sdsc-ordes/odtp-unog-digitalrecordings-scrapper

odtp new odtp-component-entry \
--component-version v0.1.1 \
--repository https://github.com/sdsc-ordes/odtp-pyannote-whisper

# Creating new digital twin
odtp new digital-twin-entry \
--user-email ${ODTP_USER_EMAIL} \
--name ${DIGITAL_TWIN_NAME}

# Creating new execution
odtp new execution-entry \
--name ${EXECUTION_NAME} \
--digital-twin-name ${DIGITAL_TWIN_NAME} \
--component-tags dtp-unog-digitalrecordings-scrapper:v1.0.0,odtp-pyannote-whisper:v0.1.1 \
--ports ,

# Preparing execution
odtp execution prepare \
--execution-name ${EXECUTION_NAME} \
--project-path ${DT_PATH}/dt-political-debates/execution

# Running execution
odtp execution run \
--execution-name ${EXECUTION_NAME}