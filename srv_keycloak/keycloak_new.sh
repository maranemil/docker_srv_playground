#!/bin/bash

###################################################################
# Test Endpoint keycloak version >= 17
###################################################################

ISLOCAL=true
if [ $ISLOCAL == true ]
then
  KEYCLOAK_REALM="master" # master
  KECLOACK_DOMAIN="http://0.0.0.0:8080"
  KECLOACK_DOMAIN="http://localhost:8080"
  KECLOACK_CLIENT_ID="test-client"
  KECLOACK_CLIENT_SECRET="28f6veTihUQn64Wpv3cAIdNjuCYIt7s8"
fi

# shellcheck disable=SC2034
KEYCLOAK_ENDPOINT="$KECLOACK_DOMAIN/realms/$KEYCLOAK_REALM/protocol/openid-connect/auth"
KEYCLOAK_ENDPOINT_TOKEN="$KECLOACK_DOMAIN/realms/$KEYCLOAK_REALM/protocol/openid-connect/token"
KEYCLOAK_CONFIG_API="$KECLOACK_DOMAIN/realms/$KEYCLOAK_REALM/.well-known/openid-configuration"

# shellcheck disable=SC2034
KEYCLOAK_SCOPE="openid"
echo $KEYCLOAK_ENDPOINT
echo $KEYCLOAK_ENDPOINT_TOKEN
echo $KEYCLOAK_CONFIG_API

# access token
# shellcheck disable=SC2155
export KC_RESPONSE=$(curl -X POST $KEYCLOAK_ENDPOINT_TOKEN \
                       -H "Content-Type: application/x-www-form-urlencoded" \
                       -d 'grant_type=client_credentials' \
                       -d "client_secret=$KECLOACK_CLIENT_SECRET" \
                       -d "client_id=$KECLOACK_CLIENT_ID" | jq . )
# shellcheck disable=SC2034
Response=$KC_RESPONSE
KC_ACCESS_TOKEN=$(echo "$KC_RESPONSE"| jq -r .access_token)
#KC_ACCESS_TOKEN_REF=$(echo "$KC_RESPONSE"| jq -r .refresh_token)
echo "$Response" | jq .

#sleep 1
echo "------------------------------------------------------"
URLUSERS="$KECLOACK_DOMAIN/admin/realms/$KEYCLOAK_REALM/users?max=3"
echo "$URLUSERS"
curl -X GET "$URLUSERS" -H "Authorization: bearer $KC_ACCESS_TOKEN" | jq .

#sleep 1
echo "------------------------------------------------------"
URL_CLIENTS="$KECLOACK_DOMAIN/admin/realms/$KEYCLOAK_REALM/users/count"
#URL_CLIENTS="$KECLOACK_DOMAIN_ADMIN/admin/realms/$KEYCLOAK_REALM/clients"
echo $URL_CLIENTS
curl --location --request GET  "$URL_CLIENTS" -H "Authorization: Bearer $KC_ACCESS_TOKEN" | jq .






#Service accunts roles
#- admin
#+ master-realm view-users