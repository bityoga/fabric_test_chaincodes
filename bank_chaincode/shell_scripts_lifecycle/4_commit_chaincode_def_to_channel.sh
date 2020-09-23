#!/bin/bash
# peer lifecycle chaincode checkcommitreadiness -o ${ORDERER_HOST}:7050 --channelID appchannel --name bank --version 1.0 --tls --cafile ${ORDERER_CA} --init-required --sequence 1
# peer lifecycle chaincode commit -o ${ORDERER_HOST}:7050 --channelID appchannel --name bank --version 1.0 --sequence 1 --init-required --tls --cafile ${ORDERER_CA} --peerAddresses ${CORE_PEER_ADDRESS} --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}

set -x #echo on

CHAINCODE_NAME="bank"
CHAINCODE_VERSION="1.0"
PACKAGE_NAME="${CHAINCODE_NAME}.tar.gz"
CHAINCODE_LABEL="${CHAINCODE_NAME}_${CHAINCODE_VERSION}"
CHAINCODE_SRC_CODE_PATH="/root/CLI/chaincodes/fabric_test_chaincodes/bank_chaincode/node"
CHANCODE_LANGUAGE="node"

ORGANISATION_NAME="hlfMSP"
SIGNATURE_POLICY="OR('${ORGANISATION_NAME}.peer')"
ORDERER_CA=/root/CLI/${ORGCA_HOST}/${ORDERER_HOST}/msp/cacerts/orgca-7054.pem
PACKAGE_ID=$(peer lifecycle chaincode queryinstalled --output json | jq .installed_chaincodes[0].package_id)
CHANNEL_NAME="appchannel"
SEQUENCE="1"

PEER_HOST=peer2
CORE_PEER_ADDRESS=${PEER_HOST}:7051
CORE_PEER_MSPCONFIGPATH=/root/CLI/${ORGCA_HOST}/${ADMIN_USER}/msp
CORE_PEER_TLS_ROOTCERT_FILE=/root/CLI/${ORGCA_HOST}/${PEER_HOST}/msp/tls/ca.crt

peer lifecycle chaincode checkcommitreadiness -o $ORDERER_HOST:7050 --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --tls --cafile $ORDERER_CA --init-required --sequence $SEQUENCE &&

peer lifecycle chaincode commit -o $ORDERER_HOST:7050 --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION --sequence $SEQUENCE --init-required --tls --cafile $ORDERER_CA --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE