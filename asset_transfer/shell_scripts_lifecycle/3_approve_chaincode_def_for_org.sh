#!/bin/bash
# peer lifecycle chaincode queryinstalled --output json | jq .installed_chaincodes[0].package_id
# peer lifecycle chaincode approveformyorg -o orderer:7050 --channelID appchannel --name basic --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile /root/CLI/orgca/orderer/msp/tls/ca.crt

set -x #echo on

CHAINCODE_NAME="asset"
CHAINCODE_VERSION="1.0"
PACKAGE_NAME="${CHAINCODE_NAME}.tar.gz"
CHAINCODE_LABEL="${CHAINCODE_NAME}_${CHAINCODE_VERSION}"
CHAINCODE_SRC_CODE_PATH="/root/CLI/chaincodes/fabric_test_chaincodes/asset_transfer/src"
CHANCODE_LANGUAGE="node"

export ORGANISATION_NAME="hlfMSP"
export SIGNATURE_POLICY="OR('${ORGANISATION_NAME}.member')"
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


#peer lifecycle chaincode approveformyorg -o orderer:7050 --channelID appchannel --name basic --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile /root/CLI/orgca/orderer/msp/tls/ca.crt
peer lifecycle chaincode approveformyorg -o ${ORDERER_HOST}:7050 --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${CC_PACKAGE_ID} --sequence ${SEQUENCE} --tls --cafile ${ORDERER_CA}