<?php

include "bootstrap.php";

use Espo\Core\{
    Application
};

#use Espo\ORM\Entity;
#use Espo\ORM\EntityManager;

try {
    $app = (new Application());
    $entityManager = $app->getContainer()->get('entityManager');
    createContact($entityManager);
    // createUser($entityManager); not working
} catch (Exception $e) {
    echo $e->getMessage();
}


/**
 * @param object $entityManager
 * @return void
 */
function createContact(object $entityManager): void
{
    $random = substr(md5(time()), 0, 5);
    $firstName = 'first' . $random;
    $lastName = 'last' . $random;
    $userObject = $entityManager->getEntity('Contact');
    $userObject->set("firstName", $firstName);
    $userObject->set("lastName", $lastName);
    $entityManager->saveEntity($userObject);
}

function createUser(object $entityManager): void
{

// encrypt the password
// define a password - use any value
    $password = "password";
// encrypt the password
    $fileM = new \Espo\Core\Utils\File\Manager();
    $config = new \Espo\Core\Utils\Config($fileM);
    $passwordHash = new \Espo\Core\Utils\PasswordHash($config);
    $encodedPassword = $passwordHash->hash($password, true);

    // https://docs.espocrm.com/development/orm/
    // https://hotexamples.com/examples/espo.orm/Entity/getEntityType/php-entity-getentitytype-method-examples.html
    // https://docs.espocrm.com/administration/troubleshooting/

    $random = substr(md5(time()), 0, 5);
    $firstName = 'first' . $random;
    $lastName = 'last' . $random;

    $userObject = $entityManager->getEntity('User');   // create a new user instance
    $userObject->set("firstName", $firstName);
    $userObject->set("lastName", $lastName);
    $usename = $random;
    $userObject->set("userName", $usename);
    $userObject->set("name", $usename);
    $userObject->set("password", $encodedPassword);
    #$userObject->set("confirmPasword", $encodedPassword);
//$userObject->set("contactId",$contactId);
    $userObject->set("isActive", true);
    #$userObject->set("isPortalUser", 0);
    $userObject->set("type", "regular");
    $userObject->set("createdById", 1);
// persist the new user instance
    $entityManager->saveEntity($userObject);
// get the new user id
#$newUserObject = $entityManager->getRepository('User')->where(['contactId'=>$contactId])->findOne();
#echo $userId = $newUserObject->get('id');
}

