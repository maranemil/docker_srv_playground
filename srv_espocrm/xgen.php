<?php

include "bootstrap.php";

use Espo\Core\{
    Application
};

use Espo\ORM\Entity;
use Espo\ORM\EntityManager;
use Espo\Modules\Crm\Entities\Account;

const FIRST_NAMES_MALE = [
    'James',
    'John',
    'Michael',
    'David',
    'Richard',
    'Joseph',
    'Thomas',
    'Matthew',
    'Anthony',
    'Mark',
    'Steven',
    'Brian',
    'Kevin',
    'Ronald',
    'Edward',
    'Oliver',
    'Henry'
];

const LAST_NAMES = [
    'Smith',
    'Martin',
    'Williams',
    'Scott',
    'Jones',
    'Brown',
    'Green',
    'Adams',
    'Wilson',
    'Lewis',
    'Nelson',
    'Moore',
    'Taylor',
    'Turner',
    'Phillips'
];

const COMPANY_NAMES = [
    'Openlane',
    'Yearin',
    'Goodsilron',
    'Condax',
    'Opentech',
    'Golddex',
    'Yearjob',
    'Isdom',
    'Gogozoom',
    'Ycorporation',
    'Nam-zim',
    'Donquadtech',
    'Warephase',
    'Donware',
    'Faxquote',
    'Sunnamplex',
    'Lexiqvolax',
    'Sumace',
    'Treequote',
    'Iselectrics',
    'Zencorporation',
    'Plusstrip',
    'Dambase',
    'Toughzap',
    'Codehow',
    'Zotware',
    'Statholdings',
    'Conecom',
    'Zathunicon',
    'Labdrill',
    'Ron-tech',
];

const MAX_ACCOUNTS = 30;
const MAX_CONTACTS = 5;
const MAX_LEADS = 300;


try {
    // init app
    $app = (new Application());
    #$app = new \Espo\Core\Application();
    $entityManager = $app->getContainer()->get('entityManager');
    $user = $entityManager->getEntity('User', 'system');
    #$app->getContainer()->setUser($user);

    // clean old data
    cleanTestData($entityManager);

    // generate accounts
    for ($i = 0; $i <= MAX_ACCOUNTS; $i++) {
        createAccounts($entityManager);
    }
    // generate contacts
    createContacts($entityManager);
    // generate leads
    for ($i = 0; $i <= MAX_LEADS; $i++) {
        createLeads($entityManager);
    }
    // add relationship accounts contacts
    updateRelationsAccountsContacts($entityManager);
} catch (Exception $e) {
    echo $e->getMessage();
}

/**
 * @throws Exception
 */
function createContacts($entityManager)
{
    $collection = $entityManager
        ->getRDBRepository('Account')
        ->limit(0, 1000)
        ->sth()
        ->find();
    foreach ($collection as $entity) {
        $accountId = $entity->getId();
        for ($i = 0; $i <= MAX_CONTACTS; $i++) {
            createContact($entityManager, $accountId);
        }
    }
}

/**
 * @param $entityManager
 * @return void
 */
function updateRelationsAccountsContacts($entityManager)
{
    /*$collection = $entityManager
        ->getRDBRepository('Account')
        ->limit(0, 1000)
        ->sth()
        ->find();
    $accountIds = [];
    foreach ($collection as $entity) {
        $accountIds[] = $entity->getId();
    }
    print_r($accountIds);*/

    $collectionContacts = $entityManager
        ->getRDBRepository('Contact')
        ->limit(0, 1000)
        ->sth()
        ->find();
    $contactIds = [];
    foreach ($collectionContacts as $entity) {
        $contactIds[] = [
            "account_id" => $entity->get('accountId'),
            "contact_id" => $entity->getId()
        ];
    }

    foreach ($contactIds as $contactId) {
        $accountId = $contactId["account_id"];
        $contactId = $contactId["contact_id"];
        $sql = "INSERT IGNORE INTO `account_contact` (account_id, contact_id)  VALUES('" . $accountId . "', '" . $contactId . "')";
        $pdo = $entityManager->getPDO();
        $sth = $pdo->prepare($sql);
        $sth->execute();
    }

    /* $insertQuery = $entityManager
         ->getQueryBuilder()
         ->insert()
         ->into('accountContact')
         ->columns(['account_id', 'contact_id'])
         ->values([
             'account_id' => $accountId,
             'contact_id' => $contact->getId(),
         ])
         ->build();
     echo $insertQuery.PHP_EOL;*/
    //$entityManager->getQueryExecutor()->execute($insertQuery);


}


/**
 * @param $entityManager
 * @return void
 */
function cleanTestData($entityManager)
{
    try {
        $sql = "SELECT * FROM `account`";
        $pdo = $entityManager->getPDO();
        $sth = $pdo->prepare($sql);
        $sth->execute();
        $rows = $sth->fetchAll(PDO::FETCH_ASSOC);
        //print_r($rows);
        foreach ($rows as $row) {
            //$o = new \StdClass();
            //$o->type = $row['type'];
            //echo $row['id'] . PHP_EOL;
            $accountId = $row['id'];
            $entityManager->getRDBRepository('Account')->deleteFromDb($accountId);
        }

        $collection = $entityManager
            ->getRDBRepository('Contact')
            ->limit(0, 1000)
            ->sth()
            ->find();
        foreach ($collection as $entity) {
            //echo $entity->getId() . PHP_EOL;
            $contactId = $entity->getId();
            $entityManager->getRDBRepository('Contact')->deleteFromDb($contactId);
        }

        $collectionLeads = $entityManager
            ->getRDBRepository('Lead')
            ->limit(0, 1000)
            ->sth()
            ->find();
        foreach ($collectionLeads as $entityLead) {
            $leadtId = $entityLead->getId();
            $entityManager->getRDBRepository('Lead')->deleteFromDb($leadtId);
        }
    } catch (Exception $e) {
        echo $e->getMessage();
    }
}


/**
 * @throws Exception
 */
function getRandomFirstName(): string
{
    return FIRST_NAMES_MALE[random_int(0, count(FIRST_NAMES_MALE) - 1)];
}

/**
 * @throws Exception
 */
function getRandomLastName(): string
{
    return LAST_NAMES[random_int(0, count(LAST_NAMES) - 1)];
}

/**
 * @throws Exception
 */
function getRandomCompanyName(): string
{
    return COMPANY_NAMES[random_int(0, count(COMPANY_NAMES) - 1)];
}

function createAccounts(object $entityManager): void
{
    try {
        // uniqid('', true)
        // md5(microtime())
        // base64_encode(random_bytes(5))
        // bin2hex(random_bytes(5))
        $accountObject = $entityManager->getEntity('Account');
        $accountObject->set("name", getRandomCompanyName().' '.bin2hex(random_bytes(5)));
        $accountObject->set("sicCode", random_int(1000000, 9000000));
        $accountObject->set("description", md5('test'));
        $entityManager->saveEntity($accountObject);
    } catch (Exception $e) {
        echo $e->getMessage();
    }
}

/**
 * @param object $entityManager
 * @param $accountId
 * @return void
 */
function createContact(object $entityManager, $accountId): void
{
    try {
        /*$account = $entityManager
            ->getRDBRepository(Account::ENTITY_TYPE)
            ->select(['id', 'name'])
            ->where([
                'type' => 'Customer',
            ])
            ->order('createdAt')
            ->findOne();
        $accountId = $account->getId();*/
        //$random = substr(md5(time()), 0, 5);

        $userObject = $entityManager->getEntity('Contact');
        $userObject->set("firstName", getRandomFirstName());
        $userObject->set("lastName", getRandomLastName());
        $userObject->set("description", 'test');
        $userObject->set("accountId", $accountId);
        $entityManager->saveEntity($userObject);
        $contactId = $userObject->id;

        $mapper = $entityManager->getMapper();
        $mapper->updateRelationColumn('Account', $accountId, 'contacts', $contactId, 'isInactive', false);
    } catch (Exception $e) {
        echo $e->getMessage();
    }
}

function createLeads(object $entityManager)
{
    try {
        // https://github.com/espocrm/espocrm/issues/1393
        $record = $entityManager->getEntity('Lead');
        //$emailAddress = base64_encode(random_bytes(8)) . '@example.com';
        //$emailAddress = md5(time()) . '@example.com';
        $record->set('name', 'test');
        $record->set('lastName', getRandomCompanyName());
        //$record->set('emailAddress', $emailAddress);
        $record->set('description', date("Y-m-d H:i:s"));
        $record->set('opportunityAmount', 100.00);
        $record->set('opportunityAmountCurrency', 'USD');
        $entityManager->saveEntity($record); // , ['silent' => true]

    } catch (Exception $e) {
        echo $e->getMessage();
    }
}

/*
https://gist.github.com/demersdesigns/aac366882659a989e958
https://www.rong-chang.com/namesdict/100_last_names.htm
https://www.babycenter.com/baby-names/most-popular/top-baby-names
https://www.ssa.gov/oact/babynames/decades/century.html
https://github.com/dominictarr/random-name


http://phptester.net/
https://extendsclass.com/php.html
https://www.browserling.com/tools/json-minify
*/

/*
https://docs.espocrm.com/development/api/account/
https://docs.espocrm.com/development/orm/
https://docs.espocrm.com/development/orm/
https://docs.espocrm.com/development/hooks/
https://docs.espocrm.com/development/orm/
https://docs.espocrm.com/development/acl/
https://docs.espocrm.com/administration/fields/
https://docs.espocrm.com/administration/formula/
https://docs.espocrm.com/development/orm/
https://docs.espocrm.com/development/select-builder/
https://docs.espocrm.com/development/coding-rules/
https://hotexamples.com/examples/espo.core.orm.repositories/RDB/-/php-rdb-class-examples.html
https://hotexamples.com/de/examples/espo.orm/Entity/-/php-entity-class-examples.html
https://hotexamples.com/de/examples/espo.orm/Entity/get/php-entity-get-method-examples.html
https://hotexamples.com/de/examples/espo.orm/Entity/getEntityType/php-entity-getentitytype-method-examples.html
https://hotexamples.com/de/examples/espo.orm/Entity/isNew/php-entity-isnew-method-examples.html
https://hotexamples.com/examples/espo.orm/Entity/get/php-entity-get-method-examples.html
https://hotexamples.com/examples/espo.orm/Entity/get/php-entity-get-method-examples.html
https://hotexamples.com/de/examples/espo.orm/Entity/-/php-entity-class-examples.html

https://github.com/espocrm/espocrm/issues/1393
*/