#!/bin/bash
# peer chaincode invoke -o orderer:7050 --tls --cafile /root/CLI/orgca/orderer/msp/tls/ca.crt -C appchannel -n bank --peerAddresses peer2:7051 --tlsRootCertFiles /root/CLI/orgca/peer2/msp/tls/ca.crt -c '{"Args":["init","a","100","b","200"]}'

set -x #echo on

CHAINCODE_NAME="bank"
CHANNEL_NAME="appchannel"
INVOKE_PARAMS='{"Args":["invoke","a","b","10"]}'
INSTANTIATE_PARAMS='{"Args":["init","a","100","b","200"]}'
ORGANISATION_NAME="hlfMSP"

export PEER_HOST=peer2
export CORE_PEER_ADDRESS=${PEER_HOST}:7051
export CORE_PEER_MSPCONFIGPATH=/root/CLI/${ORGCA_HOST}/${ADMIN_USER}/msp
export CORE_PEER_TLS_ROOTCERT_FILE=/root/CLI/${ORGCA_HOST}/${PEER_HOST}/msp/tls/ca.crt
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=${ORGANISATION_NAME}

export ORDERER_CA=/root/CLI/${ORGCA_HOST}/${ORDERER_HOST}/msp/tls/ca.crt
export PACKAGE_ID=$(peer lifecycle chaincode queryinstalled --output json | jq .installed_chaincodes[0].package_id)

peer chaincode invoke -o ${ORDERER_HOST}:7050 --tls --cafile ${ORDERER_CA} -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} --peerAddresses ${CORE_PEER_ADDRESS} --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} -c ${INVOKE_PARAMS}