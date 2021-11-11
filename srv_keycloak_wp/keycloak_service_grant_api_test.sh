#!/bin/bash

# https://www.keycloak.org/docs/latest/server_admin/
# https://www.keycloak.org/docs/15.0/server_admin/index.html
# https://www.keycloak.org/docs/latest/authorization_services/
# https://access.redhat.com/documentation/en-us/red_hat_single_sign-on/7.3/html-single/server_administration_guide/index
# https://github.com/keycloak/keycloak-documentation/blob/main/server_admin/topics/clients/oidc/service-accounts.adoc
# https://github.com/keycloak/keycloak-documentation/blob/main/server_admin/topics/identity-broker/oidc.adoc
# https://www.keycloak.org/docs/11.0/server_admin/

# https://medium.com/scalac/user-authentication-with-keycloak-part-1-35295107acd
# https://medium.com/@mihirrajdixit/getting-started-with-service-accounts-in-keycloak-c8f6798a0675#
# https://medium.com/keycloak/keycloak-as-an-identity-broker-an-identity-provider-af1b150ea94
# https://www.appsdeveloperblog.com/keycloak-client-credentials-grant-example/
# https://medium.com/@hasnat.saeed/install-keycloak-openid-connect-client-adapter-on-wildfly-on-ubuntu-18-04-ef98a99fc528
# https://quarkus.io/guides/security-openid-connect-web-authentication

# https://www.youtube.com/watch?v=D7NN_GIv10A


# miniOrange Oauth
# shellcheck disable=SC2034
KEYCLOAK_REALM="wordpress"
# shellcheck disable=SC2034
KEYCLOAK_SCOPE="openid"
KEYCLOAK_DOMAIN="http://localhost:8088"
KEYCLOAK_CLIENT_ID="vagrant"
KEYCLOAK_CLIENT_SECRET="f3e0e4a9-ca19-4612-a4ce-bd3bd0a6fb9e"
# shellcheck disable=SC2034
KEYCLOAK_ENDPOINT="$KEYCLOAK_DOMAIN/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/auth"
KEYCLOAK_ENDPOINT_TOKEN="$KEYCLOAK_DOMAIN/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/token"


#curl --location --request POST 'http://localhost:8088/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/token' \
#--header 'Content-Type: application/x-www-form-urlencoded' \
#--header 'Authorization: Basic ZGVtb2FwcDowMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDA=' \
#--data-urlencode 'grant_type=client_credentials'


#curl --location --request POST 'http://localhost:8080/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/token' \
#--header 'Content-Type: application/x-www-form-urlencoded' \
#--data-urlencode 'client_id=photo-app-client-credentials' \
#--data-urlencode 'client_secret=91813ee4-0769-4a7f-9dd3-a12f1f67631e' \
#--data-urlencode 'scope=email' \
#--data-urlencode 'grant_type=client_credentials'

# access token
# shellcheck disable=SC2155
export KC_RESPONSE=$(curl -X POST $KEYCLOAK_ENDPOINT_TOKEN \
                       -H "Content-Type: application/x-www-form-urlencoded" \
                       -d 'grant_type=client_credentials' \
                       -d "client_secret=$KEYCLOAK_CLIENT_SECRET" \
                       -d "client_id=$KEYCLOAK_CLIENT_ID" | jq . )

Response=$KC_RESPONSE
echo "$Response"

KC_ACCESS_TOKEN=$(echo "$KC_RESPONSE"| jq -r .access_token)
# shellcheck disable=SC2034
KC_ID_TOKEN=$(echo "$KC_RESPONSE"| jq -r .id_token)
# shellcheck disable=SC2034
KC_REFRESH_TOKEN=$(echo "$KC_RESPONSE"| jq -r .refresh_token)

# userinfo
# shellcheck disable=SC2155
export USER_ID=$(curl -X GET "$KEYCLOAK_DOMAIN/auth/realms/$KEYCLOAK_REALM/protocol/openid-connect/userinfo" \
  -H "Accept: application/json" \
  -H 'cache-control: no-cache' \
  -H "Authorization: Bearer $KC_ACCESS_TOKEN" | jq -r '.sub')
echo "$USER_ID"

# get users
curl -X GET "$KEYCLOAK_DOMAIN/auth/admin/realms/$KEYCLOAK_REALM/users" \
  -H "Accept: application/json" \
  -H 'cache-control: no-cache' \
  -H "Authorization: Bearer $KC_ACCESS_TOKEN" | jq .


# {
#    "id": "bbfc19cb-5c14-483c-a265-0b4b522ef399",
#    "createdTimestamp": 1636638598615,
#    "username": "wordpress2",
#    "enabled": true,
#    "totp": false,
#    "emailVerified": false,
#    "disableableCredentialTypes": [],
#    "requiredActions": [],
#    "notBefore": 0,
#    "access": {
#      "manageGroupMembership": false,
#      "view": true,
#      "mapRoles": false,
#      "impersonate": false,
#      "manage": false
#    }
#  }