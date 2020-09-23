#!/bin/bash
# peer lifecycle chaincode install bank.tar.gz
# peer lifecycle chaincode queryinstalled --output json
set -x #echo on

CHAINCODE_NAME="bank"
CHAINCODE_VERSION="1.0"
PACKAGE_NAME=${CHAINCODE_NAME}.tar.gz
CHAINCODE_LABEL=${CHAINCODE_NAME}_${CHAINCODE_VERSION}
CHAINCODE_SRC_CODE_PATH="/root/CLI/chaincodes/fabric_test_chaincodes/bank_chaincode/node"
CHANCODE_LANGUAGE="node"

PEER_HOST=peer2
CORE_PEER_ADDRESS=${PEER_HOST}:7051
CORE_PEER_MSPCONFIGPATH=/root/CLI/${ORGCA_HOST}/${ADMIN_USER}/msp
CORE_PEER_TLS_ROOTCERT_FILE=/root/CLI/${ORGCA_HOST}/${PEER_HOST}/msp/tls/ca.crt

peer lifecycle chaincode install ${PACKAGE_NAME} &&
peer lifecycle chaincode queryinstalled --output json