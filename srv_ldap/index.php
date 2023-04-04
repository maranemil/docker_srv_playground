<?php

require_once __DIR__."/vendor/autoload.php";

define("LDAP_ADMIN_USERNAME","admin");
define("LDAP_ADMIN_PASSWORD","adminpassword");
define("LDAP_USERS","user01"); // user02
define("LDAP_PASSWORDS","password1"); //password2

// ping openldap # 172.19.0.3
$config = [
    // Mandatory Configuration Options
    'hosts'            => ['openldap', 'localhost'], // 'corp-dc1.corp.acme.org', 'corp-dc2.corp.acme.org' localhost:389 openldap
    'base_dn'          => 'dc=corp,dc=acme,dc=org,dc=local,dc=com',
    'username'         => LDAP_ADMIN_USERNAME,
    'password'         => LDAP_ADMIN_PASSWORD
];
try{

	$ad = new \Adldap\Adldap();
	// Add a connection provider to Adldap.
	$ad->addProvider($config);
    // If a successful connection is made to your server, the provider will be returned.
    $provider = $ad->connect();
    // Performing a query.
    $results = $provider->search()->where('cn', '=', 'John Doe')->get();
    // Finding a record.
    $user = $provider->search()->find('jdoe');
    // Creating a new LDAP entry. You can pass in attributes into the make methods.
    $user =  $provider->make()->user([
        'cn'          => 'John Doe',
        'title'       => 'Accountant',
        'description' => 'User Account',
    ]);
    // Setting a model's attribute.
    $user->cn = 'John Doe';
    // Saving the changes to your LDAP server.
    if ($user->save()) {
        // User was saved!
    }


    /*
    $ad = new \Adldap\Adldap();
    #$config = new Adldap\Configuration\DomainConfiguration(['...']);
    $conn = $ad->addProvider($config, 'connection-one');
    $connectionName = 'connection-one';
    $provider = $ad->connect($connectionName);
     print_r($provider);
     */

} catch (Exception $e) {
    echo $e->getMessage();
}

