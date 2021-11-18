#!/bin/bash

KEYCLOAK_REALM="wordpress"
KEYCLOAK_DOMAIN="https://localhost"
# shellcheck disable=SC2034
KEYCLOAK_CLIENT_ID="wordpress"
# shellcheck disable=SC2034
KEYCLOAK_CLIENT_SECRET="some key"
# shellcheck disable=SC2034
KEYCLOAK_ENDPOINT="$KEYCLOAK_DOMAIN/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/auth"
KEYCLOAK_ENDPOINT_TOKEN="$KEYCLOAK_DOMAIN/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/token"
# shellcheck disable=SC2034
KEYCLOAK_SCOPE="openid"

echo $KEYCLOAK_ENDPOINT
echo $KEYCLOAK_ENDPOINT_TOKEN

JSON=$(curl --request POST $KEYCLOAK_ENDPOINT_TOKEN \
-H "Content-Type: application/x-www-form-urlencoded" \
-d 'grant_type=client_credentials' \
-d "client_secret=$KEYCLOAK_CLIENT_SECRET" \
-d "client_id=$KEYCLOAK_CLIENT_ID")

echo "$JSON"

# Get access_token without jd
# https://gist.github.com/cjus/1047794
# https://askubuntu.com/questions/1357926/how-to-extract-a-string-from-a-json-file-and-put-into-a-variable-linux
# https://unix.stackexchange.com/questions/121718/how-to-parse-json-with-shell-scripting-in-linux
# https://stackoverflow.com/questions/1955505/parsing-json-with-unix-tools
# https://unix.stackexchange.com/questions/529063/extract-string-from-each-line-of-a-file
# https://stackoverflow.com/questions/25042908/bash-extract-string-from-line-of-text

# shellcheck disable=SC2001
KC_ACCESS_TOKEN=$(echo "$JSON" | sed 's/{.*access_token":"*\([0-9a-zA-Z._-]*\)"*,*.*}/\1/')
echo "$KC_ACCESS_TOKEN"

echo "-------------------------------------------------------"

# get users
curl --dump-header --negotiate --verbose -k -l -X GET "$KEYCLOAK_DOMAIN/auth/admin/realms/$KEYCLOAK_REALM/users/?max=1" \
  -H "Accept: application/json" \
  -H 'cache-control: no-cache' \
  -H "Authorization: Bearer $KC_ACCESS_TOKEN"

echo "-------------------------------------------------------"

