#!/bin/bash
# peer lifecycle chaincode queryinstalled --output json | jq .installed_chaincodes[0].package_id
# peer lifecycle chaincode approveformyorg -o ${ORDERER_HOST}:7050 --tls --cafile ${CORE_PEER_TLS_ROOTCERT_FILE} --channelID appchannel --name bank --version 1.0 init-required --package-id $PACKAGE_ID --sequence 1 --signature-policy "OR('hlfMSP.member')"

set -x #echo on

CHAINCODE_NAME="bank"
CHAINCODE_VERSION="1.0"
PACKAGE_NAME=${CHAINCODE_NAME}.tar.gz
CHAINCODE_LABEL=${CHAINCODE_NAME}_${CHAINCODE_VERSION}
CHAINCODE_SRC_CODE_PATH="/root/CLI/chaincodes/fabric_test_chaincodes/bank_chaincode/node"
CHANCODE_LANGUAGE="node"

ORGANISATION_NAME="hlfMSP"
SIGNATURE_POLICY="OR('$ORGANISATION_NAME.peer')"
ORDERER_CA=/root/CLI/${ORGCA_HOST}/${ORDERER_HOST}/msp/cacerts/orgca-7054.pem
PACKAGE_ID=$(peer lifecycle chaincode queryinstalled --output json | jq .installed_chaincodes[0].package_id)
CHANNEL_NAME="appchannel"
SEQUENCE="1"

PEER_HOST=peer2
CORE_PEER_ADDRESS=${PEER_HOST}:7051
CORE_PEER_MSPCONFIGPATH=/root/CLI/${ORGCA_HOST}/${ADMIN_USER}/msp
CORE_PEER_TLS_ROOTCERT_FILE=/root/CLI/${ORGCA_HOST}/${PEER_HOST}/msp/tls/ca.crt


peer lifecycle chaincode approveformyorg -o ${ORDERER_HOST}:7050 --tls --cafile ${CORE_PEER_TLS_ROOTCERT_FILE} --channelID $CHANNEL_NAME --name $CHAINCODE_NAME --version $CHAINCODE_VERSION init-required --package-id $PACKAGE_ID --sequence $SEQUENCE --signature-policy $SIGNATURE_POLICY