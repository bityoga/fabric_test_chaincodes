#!/bin/bash
# peer lifecycle chaincode commit -o orderer:7050 --channelID appchannel --name basic --version 1.0 --sequence 1 --tls --cafile /root/CLI/orgca/orderer/msp/tls/ca.crt --peerAddresses peer2:7051 --tlsRootCertFiles /root/CLI/orgca/peer2/msp/tls/ca.crt
# peer lifecycle chaincode querycommitted --channelID appchannel --name basic --cafile /root/CLI/orgca/orderer/msp/tls/ca.crt
set -x #echo on

CHAINCODE_NAME="articonf-bank-demo"
CHAINCODE_VERSION="1.0"
PACKAGE_NAME="${CHAINCODE_NAME}.tar.gz"
CHAINCODE_LABEL="${CHAINCODE_NAME}_${CHAINCODE_VERSION}"
CHAINCODE_SRC_CODE_PATH="/root/CLI/chaincodes/fabric_test_chaincodes/articonf_demo/src"
CHANCODE_LANGUAGE="node"

ORGANISATION_NAME="hlfMSP"
SIGNATURE_POLICY="OR('${ORGANISATION_NAME}.peer')"
CHANNEL_NAME="appchannel"
SEQUENCE="1"

export PEER_HOST=peer2
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=${ORGANISATION_NAME}
export CORE_PEER_TLS_ROOTCERT_FILE=/root/CLI/${ORGCA_HOST}/${PEER_HOST}/msp/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/root/CLI/${ORGCA_HOST}/${ADMIN_USER}/msp
export CORE_PEER_ADDRESS=${PEER_HOST}:7051

export CC_PACKAGE_ID=$(peer lifecycle chaincode queryinstalled --output json | jq .installed_chaincodes[0].package_id)
export ORDERER_CA=/root/CLI/${ORGCA_HOST}/${ORDERER_HOST}/msp/tls/ca.crt

peer lifecycle chaincode commit -o ${ORDERER_HOST}:7050 --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence ${SEQUENCE} --tls --cafile ${ORDERER_CA} --peerAddresses ${CORE_PEER_ADDRESS} --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} &&
peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --cafile ${ORDERER_CA}
