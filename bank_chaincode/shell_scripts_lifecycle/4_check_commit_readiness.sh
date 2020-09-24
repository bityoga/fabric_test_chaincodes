#!/bin/bash
# peer lifecycle chaincode checkcommitreadiness --channelID appchannel --name bank --version 1.0 --sequence 1 --tls --cafile /root/CLI/orgca/orderer/msp/tls/ca.crt --output json
set -x #echo on

CHAINCODE_NAME="bank"
CHAINCODE_VERSION="1.0"
PACKAGE_NAME="${CHAINCODE_NAME}.tar.gz"
CHAINCODE_LABEL="${CHAINCODE_NAME}_${CHAINCODE_VERSION}"
CHAINCODE_SRC_CODE_PATH="/root/CLI/chaincodes/fabric_test_chaincodes/bank_chaincode/node"
CHANCODE_LANGUAGE="node"

ORGANISATION_NAME="hlfMSP"
SIGNATURE_POLICY="OR('${ORGANISATION_NAME}.peer')"
CHANNEL_NAME="appchannel"
SEQUENCE="1"

export PEER_HOST=peer2
export CORE_PEER_ADDRESS=${PEER_HOST}:7051
export CORE_PEER_MSPCONFIGPATH=/root/CLI/${ORGCA_HOST}/${ADMIN_USER}/msp
export CORE_PEER_TLS_ROOTCERT_FILE=/root/CLI/${ORGCA_HOST}/${PEER_HOST}/msp/tls/ca.crt
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=${ORGANISATION_NAME}

export ORDERER_CA=/root/CLI/${ORGCA_HOST}/${ORDERER_HOST}/msp/tls/ca.crt
export PACKAGE_ID=$(peer lifecycle chaincode queryinstalled --output json | jq .installed_chaincodes[0].package_id)

peer lifecycle chaincode checkcommitreadiness --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --tls --cafile ${ORDERER_CA} --sequence ${SEQUENCE}