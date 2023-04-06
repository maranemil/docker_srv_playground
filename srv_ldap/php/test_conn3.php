<?php
/*
#########################################################
authenticating
#########################################################

https://ldaprecord.com/docs/core/v2/quickstart/
https://ldaprecord.com/docs/core/v1/authentication/#group-memberships
https://ldaprecord.com/docs/core/v1/configuration/#ssl--tls
https://ldaprecord.com/docs/core/v1/authentication/#authenticating-with-other-username-attributes
https://ldaprecord.com/docs/laravel/v1/usage/#models
https://ldaprecord.com/docs/core/v2/searching/#wheres
https://lean-ocean.com/ldaprecord-wie-du-ldap-in-deine-laravel-application-integrierst/
https://github.com/DirectoryTree/LdapRecord-Docs/blob/master/laravel/v1/auth/configuration.md

dc – Domain Component. Der Einstiegspunkt der Baumstruktur, vergleichbar mit root in Linux-Systemen
ou – Organizational Unit. z.B: Abteilungen, Teams etc. Von diesen können beliebig viele ineinander geschachtelt werden.
cn – Common Name. Die eigentlichen Datensätze, z.B: Personen, Dateien etc.

cn=lisa,ou=dev,ou=user,dc=server,dc=com
*/

# https://www.tutorialspoint.com/online_php_formatter.htm
require_once __DIR__. "/vendor/autoload.php";

use \LdapRecord\Connection;
use \LdapRecord\Auth\BindException;
$options = [
#'account_suffix' => $this->setting['account_suffix'], @example.com
'hosts' => [$this->setting['domain_controllers']], //  domain
'port' => $this->setting['ad_port'], // 389
'base_dn' => $this->setting['base_dn'] //   dc=example,dc=com
];
$connection = new Connection($options);
try {
    $connection->auth()->bind($username . $account_suffix, $password);
}
catch(\LdapRecord\Auth\BindException $e) {
    $error = $e->getDetailedError()->getDiagnosticMessage();
    if (strpos($error, '532') !== false) {
        echo 'Your password has expired.';
    } elseif (strpos($error, '533') !== false) {
        echo 'Your account is disabled.';
    } elseif (strpos($error, '701') !== false) {
        echo 'Your account has expired';
    } elseif (strpos($error, '775') !== false) {
        echo 'Your account is locked.';
    }
    echo 'Username or password is incorrect.';
}
if ($connection->auth()->attempt($username . $account_suffix, $password)) {
    $authenticated = 1;
}
#...
$query = $connection->query();
$query->where('sAMAccountName', 'contains', $username)->limit(5)->get();
#...
$connection = new \LdapRecord\Connection(['...']);
$connection->connect();
$user = $connection->query()->where('samaccountname', '=', $_POST['username'])->firstOrFail();
// Get the groups from the user.
$userGroups = $user['memberof'];