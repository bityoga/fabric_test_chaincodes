#!/bin/bash
# peer lifecycle chaincode package bank.tar.gz --path /root/CLI/chaincodes/fabric_test_chaincodes/bank_chaincode/node/ --lang node --label bank_1

set -x #echo on

CHAINCODE_NAME="asset"
CHAINCODE_VERSION="1.0"
PACKAGE_NAME="${CHAINCODE_NAME}.tar.gz"
CHAINCODE_LABEL="${CHAINCODE_NAME}_${CHAINCODE_VERSION}"
CHAINCODE_SRC_CODE_PATH="/root/CLI/chaincodes/fabric_test_chaincodes/asset_transfer"
CHANCODE_LANGUAGE="node"


export PEER_HOST=peer2
export CORE_PEER_ADDRESS=${PEER_HOST}:7051
export CORE_PEER_MSPCONFIGPATH=/root/CLI/${ORGCA_HOST}/${ADMIN_USER}/msp
export CORE_PEER_TLS_ROOTCERT_FILE=/root/CLI/${ORGCA_HOST}/${PEER_HOST}/msp/tls/ca.crt

peer lifecycle chaincode package ${PACKAGE_NAME} --path ${CHAINCODE_SRC_CODE_PATH} --lang ${CHANCODE_LANGUAGE} --label ${CHAINCODE_LABEL}