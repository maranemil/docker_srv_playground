<?php

require_once __DIR__. "/vendor/autoload.php";
$config = [

    /*
    'username' => 'someuser',
    'password' => 'somepass'
    */
    'account_suffix' => '@somedomain.com',
    'hosts'          => ['SOMESTRING.some.string'],
    'port'           => '389',
    'base_dn'        => 'dc=some,dc=domain'

];
$fields = [
    'sAMAccountName',
    'mail',
    'displayname',
    'memberof',
    'cn',
    'telephonenumber',
    'company',
    'distinguishedName',
    'uid',
    'givename',
    'sn',
    'department',
];

$ad = new \Adldap\Adldap();
$ad->addProvider($config,"default");
$provider = $ad->connect();
#$result = $provider->search()->where('samaccountname','=','*')->firstOrFail($fields);
$result=  $provider->search()->where('samaccountname','=','username')->firstOrFail($fields);
print_r($result);
#$user = $provider->search()->find('admin');
#print_r($user);
