#!/bin/bash
# peer lifecycle chaincode checkcommitreadiness --channelID appchannel --name basic --version 1.0 --sequence 1 --tls --cafile /root/CLI/orgca/orderer/msp/tls/ca.crt --output json
set -x #echo on

CHAINCODE_NAME="asset"
CHAINCODE_VERSION="1.0"
PACKAGE_NAME="${CHAINCODE_NAME}.tar.gz"
CHAINCODE_LABEL="${CHAINCODE_NAME}_${CHAINCODE_VERSION}"
CHAINCODE_SRC_CODE_PATH="/root/CLI/chaincodes/fabric_test_chaincodes/asset_transfer/src"
CHANCODE_LANGUAGE="node"

export ORGANISATION_NAME="hlfMSP"
export SIGNATURE_POLICY="OR('${ORGANISATION_NAME}.peer')"
export CHANNEL_NAME="appchannel"
export SEQUENCE="1"

export PEER_HOST=peer2
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=${ORGANISATION_NAME}
export CORE_PEER_TLS_ROOTCERT_FILE=/root/CLI/${ORGCA_HOST}/${PEER_HOST}/msp/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/CLI/${ORGCA_HOST}/${ADMIN_USER}/msp
export CORE_PEER_ADDRESS=${PEER_HOST}:7051

export CC_PACKAGE_ID=$(peer lifecycle chaincode queryinstalled --output json | jq .installed_chaincodes[0].package_id)
export ORDERER_CA=/root/CLI/${ORGCA_HOST}/${ORDERER_HOST}/msp/tls/ca.crt

#peer lifecycle chaincode checkcommitreadiness --channelID appchannel --name basic --version 1.0 --sequence 1 --tls --cafile /root/CLI/orgca/orderer/msp/tls/ca.crt --output json
peer lifecycle chaincode checkcommitreadiness --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence ${SEQUENCE} --tls --cafile ${ORDERER_CA} --output json