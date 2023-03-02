#!/bin/bash

###################################################################
# Test Endpoint keycloak version < 17
###################################################################

ISLOCAL=true
if [ $ISLOCAL == true ]
then
  KEYCLOAK_REALM="master" # master
  KECLOACK_DOMAIN="http://0.0.0.0:8081"
  KECLOACK_DOMAIN="http://localhost:8081"
  KECLOACK_CLIENT_ID="test-client"
  KECLOACK_CLIENT_SECRET="d3b29b24-583c-4e71-9fb7-bd1ba71105b1"
fi

# shellcheck disable=SC2034
KEYCLOAK_ENDPOINT="$KECLOACK_DOMAIN/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/auth"
KEYCLOAK_ENDPOINT_TOKEN="$KECLOACK_DOMAIN/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/token"
KEYCLOAK_CONFIG_API="$KECLOACK_DOMAIN/auth/realms/$KEYCLOAK_REALM/.well-known/openid-configuration"

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
URLUSERS="$KECLOACK_DOMAIN/auth/admin/realms/$KEYCLOAK_REALM/users"
echo "$URLUSERS"
curl -X GET "$URLUSERS"  -H "Authorization: Bearer $KC_ACCESS_TOKEN" | jq .

#sleep 1
echo "------------------------------------------------------"
URLUSERS="$KECLOACK_DOMAIN/auth/admin/realms/$KEYCLOAK_REALM/users/count"
echo $URLUSERS
curl --location --request GET  "$URLUSERS" -H "Authorization: Bearer $KC_ACCESS_TOKEN" | jq .


# http://localhost:8081/auth/realms/master/protocol/openid-connect/auth
# http://localhost:8081/auth/realms/master/protocol/openid-connect/token
# http://localhost:8081/auth/realms/master/.well-known/openid-configuration
# sudo apt-get install -y jq