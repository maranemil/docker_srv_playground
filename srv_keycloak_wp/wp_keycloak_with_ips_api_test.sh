#!/bin/bash

# https://github.com/keycloak/keycloak-documentation/blob/main/securing_apps/topics/oidc/oidc-generic.adoc
# https://gist.github.com/michaelknurr/7e3d7c4847765e9bbc7f18cc0e67ff78
# https://github.com/keycloak/keycloak-documentation/blob/main/authorization_services/topics/service-rpt-token-introspection.adoc
# https://connect2id.com/products/server/docs/api/token-introspection
# https://developers.redhat.com/blog/2020/11/24/authentication-and-authorization-using-the-keycloak-rest-api#keycloak_sso_demo
# https://github.com/keycloak/keycloak-documentation/blob/main/securing_apps/topics/oidc/oidc-generic.adoc
# https://developer.wordpress.org/reference/classes/requests_transport_curl/
# https://hotexamples.com/examples/-/Transport/-/php-transport-class-examples.html
# https://www.php.net/manual/en/book.oauth.php
# https://www.php.net/manual/en/oauth.examples.fireeagle.php
# https://www.php.net/manual/en/oauth.getaccesstoken.php
# https://askubuntu.com/questions/1070864/how-to-set-variable-in-the-curl-command-in-bash
# https://askubuntu.com/questions/714458/bash-script-store-curl-output-in-variable-then-format-against-string-in-va

# bash: jq:command not found
# https://stedolan.github.io/jq/download/
#sudo apt-get install jq

# configuration
# http://172.18.0.13:8080/auth/realms/wordpress/.well-known/openid-configuration

# get an access token
#curl -X POST \
#  http://172.18.0.13:8080/auth/realms/wordpress/protocol/openid-connect/token \
#  -H 'Accept: application/json' \
#  -H 'Content-Type: application/x-www-form-urlencoded' \
#  -H 'cache-control: no-cache' \
#  -d 'grant_type=password&username=wordpress&password=wordpress&client_id=wordpress&client_secret=e8158148-aa91-4cb4-8865-b2e9ade7d7ab'

KEYCLOAK_CLIENT_ID="wordpress"
KEYCLOAK_CLIENT_SECRET="e8178148-aa91-4cb4-8095-b2e9ade7d7ab"
# shellcheck disable=SC2034
KEYCLOAK_ENDPOINT="http://172.18.0.13:8080/auth/realms/wordpress/protocol/openid-connect/auth"
KEYCLOAK_ENDPOINT_TOKEN="http://172.18.0.13:8080/auth/realms/wordpress/protocol/openid-connect/token"
# miniOrange Oauth
# shellcheck disable=SC2034
KEYCLOAK_DOMAIN="http://172.18.0.13:8080"
# shellcheck disable=SC2034
KEYCLOAK_REALM="wordpress"
# shellcheck disable=SC2034
KEYCLOAK_SCOPE="openid"
KEYCLOAK_USER="wordpress"
KEYCLOAK_PASS="wordpress"

# access token
# shellcheck disable=SC2155
export KC_RESPONSE=$(curl -X POST $KEYCLOAK_ENDPOINT_TOKEN \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=$KEYCLOAK_USER" \
  -d "password=$KEYCLOAK_PASS" \
  -d 'grant_type=password' \
  -d "client_secret=$KEYCLOAK_CLIENT_SECRET" \
  -d "client_id=$KEYCLOAK_CLIENT_ID" | jq . )

# shellcheck disable=SC2034
Response=$KC_RESPONSE
#echo Response

KC_ACCESS_TOKEN=$(echo "$KC_RESPONSE"| jq -r .access_token)
# shellcheck disable=SC2034
KC_ID_TOKEN=$(echo "$KC_RESPONSE"| jq -r .id_token)
# shellcheck disable=SC2034
# shellcheck disable=SC2086
KC_REFRESH_TOKEN=$(echo $KC_RESPONSE| jq -r .refresh_token)

#curl -X POST $KEYCLOAK_ENDPOINT_TOKEN 2>/dev/null \
#  -H 'Accept: application/json' \
#  -H 'Content-Type: application/x-www-form-urlencoded' \
#  -H 'cache-control: no-cache' \
#  -d "grant_type=password&username=$KEYCLOAK_USER&password=$KEYCLOAK_PASS&client_id=$KEYCLOAK_CLIENT_ID&client_secret=$KEYCLOAK_CLIENT_SECRET" | jq --raw-output '"\(.access_token), \(.session_state)"'


# userinfo
# shellcheck disable=SC2155
# shellcheck disable=SC2016
export USER_ID=$(curl -X GET "$KEYCLOAK_DOMAIN/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/userinfo" \
  -H "Accept: application/json" \
  -H 'cache-control: no-cache' \
  -H "Authorization: Bearer $KC_ACCESS_TOKEN" | jq -r '.sub')
echo "$USER_ID"

# /realms/{realm-name}/protocol/openid-connect/auth
# http://172.18.0.13:8080/auth/realms/demo/protocol/openid-connect/auth

# introspect
#curl -k -v -X POST 'http://172.18.0.13:8080/auth/realms/demo/protocol/openid-connect/token/introspect' \
#  -H "Accept: application/json" \
#  -H 'cache-control: no-cache' \
#  -d "token=$KC_ACCESS_TOKEN"  \
#  -d "username=$KEYCLOAK_USER" \
#  -d "client_secret=$KEYCLOAK_CLIENT_SECRET" \
#  -d "client_id=$KEYCLOAK_CLIENT_ID" | jq .

# certs
#curl -L -X GET 'http://172.18.0.13:8080/auth/realms/demo/protocol/openid-connect/certs' | jq .


# get all users of gateway realm, use the token from above and use Bearer as prefix
# shellcheck disable=SC2016
curl -X GET "$KEYCLOAK_DOMAIN/auth/admin/realms/$KEYCLOAK_REALM/users" \
  -H "Authorization: Bearer $KC_ACCESS_TOKEN" \
  -H 'cache-control: no-cache' | jq .


# misc examples
#curl -d "$(jq -n --arg n "$name" '{query: $n, turnOff: true}')" \
#     -H "Content-Type: application/json" -X POST http://localhost:8080/explorer

#printf -v data '{"query":"%s", "turnOff":true}' "developer"
#curl -d "$data" -H "Content-Type: application/json" -X POST http://localhost:8080/explorer
#
# curl ipinfo.io/"1.1.1.1" 2>/dev/null | jq --raw-output '"\(.city), \(.region)"'
# find -name *.php -print0 | xargs -0 ...do something




