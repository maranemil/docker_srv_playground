### Migration Tips for adapting previous custom code to work with Espo 6.0+

```text
https://forum.espocrm.com/forum/developer-help/65066-tips-for-adapting-previous-custom-code-to-work-with-espo-6-0
https://forum.espocrm.com/forum/developer-help/65066-tips-for-adapting-previous-custom-code-to-work-with-espo-6-0
https://github.com/espocrm/espocrm/tree/master/application/Espo/Hooks
https://forum.espocrm.com/forum/developer-help/72636-custom-services-no-longer-recommended
https://docs.espocrm.com/development/orm/
https://docs.espocrm.com/development/coding-rules/
https://docs.espocrm.com/development/select-builder/
https://docs.espocrm.com/development/orm/
https://forum.espocrm.com/forum/feature-requests/71797-deprecate-getpdo
https://docs.espocrm.com/development/acl/
https://docs.espocrm.com/development/select-manager/
https://docs.espocrm.com/development/custom-field-type/
https://docs.espocrm.com/development/services/
https://docs.espocrm.com/development/services/
https://docs.espocrm.com/development/di/
https://docs.espocrm.com/development/view/
https://docs.espocrm.com/development/acl/
https://github.com/espocrm/documentation/blob/master/docs/administration/formula.md#attribute
https://forum.espocrm.com/forum/installation-and-upgrade-help/75424-solutions-to-adapting-previous-custom-code-to-work-with-espo-7-x
https://forum.espocrm.com/forum/developer-help/77957-selectmanagers-to-v7-x
https://docs.espocrm.com/development/select-manager/
```

---
### SelectManagers

Step 1:Create custom "Select" classes for each type of filter previously
defined in the SelectManager:

```php
# BEFORE
# application/Espo/Modules/PropertyManagement/SelectManagers/ServiceTicket.php
# PHP Code:
#-------------------------------
namespace Espo\Modules\PropertyManagement\SelectManagers;
class ServiceTicket extends \Espo\Core\SelectManagers\Base
{
    protected function boolFilterOpen(&$result)
    {
        $this->filterOpen($result);
    }
    protected function filterOpen(&$result)
    {
        $result['whereClause'][] = array('status!=' => ['Completed', 'Canceled', 'Deferred', 'Rejected']);
    }
}
```
```php
# AFTER
# application/Espo/Modules/PropertyManagement/Classes/Select/ServiceTicket/PrimaryFilters/Open.php
# PHP Code:
#-------------------------------
namespace Espo\Modules\PropertyManagement\Classes\Select\ServiceTicket\PrimaryFilters;
use Espo\ORM\Query\SelectBuilder;
use Espo\ORM\Query\Part\Condition as Cond;
use Espo\Core\Select\Primary\Filter;

class Open implements Filter
{
    public function apply(SelectBuilder $queryBuilder): void
    {
        $notOpenList = ['Completed', 'Canceled', 'Deferred', 'Rejected'];
        $queryBuilder->where(
            Cond::notIn(
                Cond::column('status'),
                $notOpenList
            )
        );
    }
}
```
```php
# application/Espo/Modules/PropertyManagement/Classes/Select/ServiceTicket/BoolFilters/Open.php
# PHP Code:
#-------------------------------
namespace Espo\Modules\PropertyManagement\Classes\Select\Ser viceTicket\BoolFilters;
use Espo\Core\Select\Bool\Filter;
use Espo\ORM\Query\SelectBuilder;
use Espo\ORM\Query\Part\Where\OrGroupBuilder;
use Espo\ORM\Query\Part\Condition as Cond;

class Open implements Filter
{
    public function apply(SelectBuilder $queryBuilder, OrGroupBuilder $orGroupBuilder): void
    {
        $notOpenList = ['Completed', 'Canceled', 'Deferred', 'Rejected'];
        $orGroupBuilder->add(
            Cond::notIn(
                Cond::column('status'),
                $notOpenList
            )
        );
    }
}
```

Step 2:Create custom metadata script to have Espo invoke the new classes to apply filters instead of using the deprecated SelectManager definitions:
```js
application/Espo/Modules/PropertyManagement/Respurces/metadata/selectDefs/ServiceTicket.json
Code:
#-------------------------------
{
    "primaryFilterClassNameMap": {
        "open": "Espo\\Modules\\PropertyManagement\\Classes\\Selec t\\ServiceTicket\\PrimaryFilters\\Open"
    },
    "boolFilterClassNameMap": {
        "open": "Espo\\Modules\\PropertyManagement\\Classes\\Selec t\\ServiceTicket\\BoolFilters\\Open"
    }
}
```

### Job class

```code
# BEFORE Code:
#-------------------------------
use Espo\Core\EntryPoints\{
    EntryPoint
};
use Espo\Core\EntryPoints\{
    EntryPoint
};
public function run(Request $request)
```

```code
NOW Code:
#-------------------------------
use Espo\Core\EntryPoint\{
    EntryPoint
};
use Espo\Core\{
    Api\Request,
    Api\Response
};
public function run(Request $request, Response $response): void
```



### Job class
```
# BEFORE:Code:
#-------------------------------

use Espo\Core\{
    Jobs\Job
};

class InstantiateRecurringInvoices implements Job{
	public function run()
}
```

```
NOW:Code:
#-------------------------------
use Espo\Core\{
    Job\JobDataLess
};

class InstantiateRecurringInvoices implements JobDataLess{
	public function run(): void
}
```



### Custom Controller

```
BEFORE:Code:
#-------------------------------
namespace Espo\Modules\ControlBoard\Controllers;
public function getActionListDataCards($params, $request, $data)
{
    (more code here)
    $params = [];
    // get the collection parameters from the front-end request
    $this->fetchListParamsFromRequest($params, $request, $data);

}
```

```
AFTER Code:
#-------------------------------
namespace Espo\Modules\ControlBoard\Controllers;
use Espo\Core\Api\Request;

public function getActionListDataCards(Request $request): object
{
    (more code here)
    // get the collection parameters from the front-end request
    $params = $request->getQueryParams();
}
```



#### Issue: Upcoming elimination of the Select Manager class and substitution by the Select Builder framework

```
BEFORE:Code:
#-------------------------------
namespace Espo\Modules\ControlBoard\Controllers;

class ControlBoard extends \Espo\Core\Templates\Controllers\Base
{
    public function getActionListDataCards($params, $data, $request)
    {
        if (!$this -> getAcl() -> check($this -> name, 'read')) {
            throw new Forbidden("No read access for {$this -> name}.");
        }
        $params = [];
        // get the collection parameters from the front-end routing request
        $this -> fetchListParamsFromRequest($params, $request, $data);
        $maxSizeLimit = $this -> getConfig() -> get('recordListMaxSizeLimit', self::MAX_SIZE_LIMIT);
        if (empty($params['maxSize'])) {
            $params['maxSize'] = $maxSizeLimit;
        }
        if (!empty($params['maxSize']) & & $params['maxSize']  >  $maxSizeLimit) {
            throw new Forbidden("Max size should should not exceed " . $maxSizeLimit . ". Use offset and limit.");
        }
        $result = $this -> getRecordService() -> getListDataCards($params);
        return (object) [
            'total' = > $result -> total,
            'list' = > $result -> collection -> getValueMapList(),
            'additionalData' = > $result -> additionalData
        ];
    }
}
```

```
AFTER Code:
#-------------------------------
namespace Espo\Modules\ControlBoard\Controllers;
use Espo\Core\Api\Request;

class ControlBoard extends \Espo\Core\Templates\Controllers\Base
{
    public function getActionListDataCards(Request $request): object
    {
        if (!$this -> getAcl() -> check($this -> name, 'read')) {
            throw new Forbidden("No read access for {$this -> name}.");
        }
        // get the collection parameters from the front-end request
        $searchParams = $this -> searchParamsFetcher -> fetch($request);
        $result = $this -> getRecordService() -> getListDataCards($searchParams);
        return (object) [
            'total' => $result -> total,
            'list' => $result -> collection -> getValueMapList(),
            'additionalData' => $result -> additionalData
        ];
    }
}
```



#### Issue: Deprecated use of function getEntityManager() in Controllers,

```
BEFORE:Code:
#-------------------------------
namespace Espo\Modules\Esignature\Controllers;

use Espo\Core\{
Container,
Exceptions\BadRequest,
Api\Request
};

class Esignature
{
    protected $container;
    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    public function postActionPrintForEsignature(Request $request): string
    {
        $data = $request->getParsedBody();
        $entity = $this->container->get('entityManager')->getEntity($data->entityType,$data->entityId);
        $template = $this->container->get('entityManager')->getEntity('Template',$data->templateId);
        if(empty($entity)) {
            throw new BadRequest('Entity "{$data->entityType}" ID "{$data->entityId}" not found');
        }
        if(empty($template)) {
            throw new BadRequest('Template ID "{$data->templateId}" not found');
        }
        $result = $this->container->get('serviceFactory')->create('Esignature')->printForEsignature($entity, $template, $data->isPortal);
        return $result;
    }
}
```
```
NOW Code:
#-------------------------------

namespace Espo\Modules\Esignature\Controllers;
use Espo\Core\{
Di,
Api\Request
};

class Esignature implements Di\ServiceFactoryAware, Di\EntityManagerAware
{

    use Di\ServiceFactorySetter;
    use Di\EntityManagerSetter;

    public function postActionPrintForEsignature(Request $request): string
    {
        $data = $request->getParsedBody();
        $entity = $this->entityManager->getEntity($data->entityType,$data->entityId);
        $template = $this->entityManager->getEntity('Template',$data->templateId);
        if(empty($entity)) {
            throw new BadRequest('Entity "{$data->entityType}" ID "{$data->entityId}" not found');
        }
        if(empty($template)) {
            throw new BadRequest('Template ID "{$data->templateId}" not found');
        }
        $result = $this->serviceFactory->create('Esignature')->printForEsignature($entity, $template, $data->isPortal);
        return $result;
    }

}
```



#### Using Dependency Injection (Di) instead of utilizing "use" statements in a class definition
```
BEFORE: PHP Code:
#-------------------------------
namespace Espo\Modules\Chats\Services;
use Espo\Core\Utils\Metadata;

class ChatForumAdmin
{
    protected $metadata;
     public function __construct(Metadata $metadata)
    {
        $this->metadata = $metadata;
    }
    public function createLinks() {
        // some code
        $existingSidePanelsInMetadata = $this->metadata->get('clientDefs.' . $linkPayload->parentEntity . '.sidePanels.detail');
        // more code
    }

}
```
```
NOW PHP Code:
#-------------------------------
namespace Espo\Modules\Chats\Services;
use Espo\Core\Di;

class ChatForumAdmin implements Di\MetadataAware
{
    use Di\MetadataSetter;
    public function createLinks() {
        // some code
        $existingSidePanelsInMetadata = $this->metadata->get('clientDefs.' . $linkPayload->parentEntity . '.sidePanels.detail');
        // more code
    }
}
```

#### getPDO deprecated
```
BEFORE:Code:
#-------------------------------
$pdo = $this->getEntityManager()->getPDO();
$entityManager = $this->getEntityManager();
$patientList = $entityManager->getRepository('Patient')->where([
'deleted' => 0
])->find();

foreach ($patientList as $patient) {
$sql = "SELECT MAX(DATE(date_time)) as dateLastCare, MIN(DATE(date_time)) as dateFirstCare FROM care WHERE national_number='" .$patient->get('nationalNumber') ."' AND deleted='0' GROUP BY national_number;";

$sth = $pdo->prepare($sql);
$sth->execute();
$row = $sth->fetch();
if ($row){
$patient->set('dateLastCare', $row['dateLastCare']);
$patient->set('dateFirstCare', $row['dateFirstCare']);
$entityManager->saveEntity($patient, ['skipAll' => true]);
}
}
```

```
NOW:Code:
#-------------------------------
$query = $entityManager->getQueryBuilder()
    ->select(... expression ... can be in OOP way as of v6.2.0)
    ->from(...)
    ->where(...)
    ->groupBy(...)
    ->build();

$row = $entityManager
    ->getSqlExecutor()
    ->execute($query)
    ->fetch();

$patient->set('dateLastCare', $row['dateLastCare']);
```
```
$query = $em->getQueryBuilder()
->select()
->from( 'Care')
->select([
'MAX:(dateTime)',
'MIN:(dateTime)'
])
->where( [
'nationalNumber' => $patient->get('nationalNumber')
])
->groupBy( [ 'nationalNumber' ])
->build();
$row = $em
->getQueryExecutor()
->execute($query)
->fetch();

$GLOBALS['log']->warning( $row['MIN:(dateTime)'] .' => ' .$row['MAX:(dateTime)'] );
```



#### Custom services no longer recommended
```
Code:
#-------------------------------
namespace Espo\Custom\Hooks\MyEntity;
use Espo\Custom\MyCustomService;
class MyHook
{
    private $service;
    public function __construct(MyCustomService $service)
    {
         $this->service = $service;
    }
    public function afterSave(Entity $entity): void
    {
        $this->service->doSomethingWithEntity($entity);
    }
}
```
```
BEFORE: Code:
#-------------------------------
namespace Espo\Custom\Services;
class Service extends \Espo\Core\Templates\Services\Base
 {
   public function test($str) {
   $GLOBALS['log']->debug($str);
 }
}
```

```
NOW: Code:
#-------------------------------
namespace Espo\Custom\Hooks\Service;
use \Espo\Core\Exceptions\Error;
use Espo\ORM\Entity;
use Espo\Custom\Services\Service;
class SaveService extends \Espo\Core\Hooks\Base
{
   private $serviceTest;
   public function __construct(Service $service) {
     $this->serviceTest = $service;
   }

   public function beforeSave(Entity $en, array $options = array()) {
     $GLOBALS['log']->debug("SaveService: beforeSave");
     $this->serviceTest->test("hello2");
       ...
   }
}
```



#### Base deprecated - Espo\Core\Jobs\Base is deprecated.
```
#-------------------------------
namespace Espo\Custom\Jobs;
use Espo\Custom\MyCustomService;
use Espo\ORM\EntityManager;

class MyJob // no extending here
{
    private $service;

    private $entityManager;

    public function __construct(MyCustomService $service, EntityManager $entityManager)
    {
         $this->service = $service;
         $this->entityManager = $entityManager;
    }

    ...
}
```

```
BEFORE: Code:
#-------------------------------
class MyCustomHook extends \Espo\Core\Hooks\Base {
    // some code
    $this -> getEntityManager() ->
    // more code
}
```
```
NOW:Code:
#-------------------------------
use Espo\Core\ORM\EntityManager;
class MyCustomHook {
    protected $entityManager;

    public function _construct(EntityManager $entityManager) {
        $this -> entityManager = $entityManager;
    }

    // some code
    $this -> entityManager ->
    // more code
}
```


####
```
BEFORE:Code:
#-------------------------------
class MyCustomHook extends \Espo\Core\Hooks\Base {
    // some code
    $this -> getConfig() ->
    // more code
}
```
```
NOW:Code:
#-------------------------------
use Espo\Core\Utils\Config;

class MyCustomHook {
    protected $config;

    public function __construct(Config $config) {
        $this -> config = $config;

    // some code
    $this -> config ->
    // more code
```

```
BEFORE:Code:
#-------------------------------
class MyCustomHook extends \Espo\Core\Hooks\Base {

    // some code
    $this -> getMetadata() ->
    // more code
}
```
```
NOW:Code:
#-------------------------------
use Espo\Core\Utils\Metadata;

class MyCustomHook {
    protected $metadata;

    public function __construct(Metadata $metadata) {
        $this -> metadata = $metadata;
    }

    // some code
    $this -> metadata ->
    // more code
}
```

#### -
```
BEFORE:Code:
#-------------------------------
class MyCustomHook extends \Espo\Core\Hooks\Base {
// custom hook functions
...
$this -> getContainer() ->
...
}
```
```
NOW:Code:
#-------------------------------
use Espo\Core\Container;

class MyCustomHook {
protected $container;
public function __construct(Container $container) {
$this -> container = $container;
}

// custom hook functions
....
$this > container ->
```

#### ----
```
BEFORE:Code:
#-------------------------------
class MyCustomHook extends \Espo\Core\Hooks\Base {

// custom hook functions
...
[COLOR=#000000]$this -> getServiceFactory() ->[/COLOR]
...
}
```
```
NOW:Code:
#-------------------------------
use Espo\Core\ServiceFactory;

class MyCustomHook {
protected $serviceFactory;

public function __construct(ServiceFactory $serviceFactory) {
$this -> serviceFactory = $serviceFactory;
}

// custom hook functions
....
[COLOR=#000000]$this -> serviceFactory ->[/COLOR]
```


#### -
```
BEFORE:Code:
#-------------------------------
class MyCustomHook extends \Espo\Core\Hooks\Base {

// custom hook functions
...
[COLOR=#000000]$this -> getUser() -> [/COLOR]
}
```
```

NOW:Code:
#-------------------------------
use Espo\Entities\User;
class MyCustomHook {
protected $user;
public function __construct(User $user) {
$this -> user = $user;
}
// custom hook functions
....
[COLOR=#000000]$this -> user -> [/COLOR]
```


```
BEFORE:Code:
#-------------------------------
class MyCustomHook extends \Espo\Core\Hooks\Base {
// custom hook functions
...
[COLOR=#000000]$this -> getContainer() -> get('mailSender');[/COLOR]
...
}
```
```
NOW:Code:
#-------------------------------
use Espo\Core\Di;
class MyCustomHook implements Di\EmailSenderAware {
use Di\EmailSenderSetter;
// custom hook functions
....
[COLOR=#000000]$mailSender = $this -> emailSender -> create();[/COLOR]
....
Entry Points:
Entry points can only be invoked now using GET requests, if your code has entry point calls using POST requests (like we had because in some cases I didn't want to display the payload parameters in the browser's url) you could replace the entry point call with a standard Ajax - Controller - Service -Controller - Ajax implementation as follows:
```

#### ----
```
BEFORE: (view code)
Code:
#-------------------------------
......
var url = '?entryPoint=chatNotification';
var options = {
    notificationType: 'eMail',
    authorId: authorId,
    subject: subject,
    body: body,
    portalBody: portalBody,
    distributionList: distributionList,
    portalDistributionList: portalDistributionList
};
var payload = JSON.stringify(options);
var xmlhttp = new XMLHttpRequest();
xmlhttp.open("POST", url);
xmlhttp.setRequestHeader("Content-type", "application/json");
var self = this;
xmlhttp.onreadystatechange = function() {
    if (xmlhttp.readyState === XMLHttpRequest.DONE) {
        if (xmlhttp.status === 200) {
            console.log("Email Notifications sent to: ",xmlhttp.responseText);
        } else if (xmlhttp.status === 400) {
            alert('There was an error 400');
        } else {
        alert('something else other than 200 was returned');
        }
    }
};
xmlhttp.send(payload);
```
```
BEFORE: (entry point class code)
PHP Code:
#-------------------------------
class ChatNotification extends \Espo\Core\EntryPoints\Base
{
    public function run()
    {
        //convert the POST JSON input received into a PHP associative array
        $requestPayload = file_get_contents("php://input");
        $payload = json_decode($requestPayload, true);
        $notificationType = $payload["notificationType"];
        if($notificationType === "eMail") {
            $this -> getServiceFactory() -> create('ChatNotification') -> emailNotification($payload);
        } elseif($notificationType === "sms") {
            $this -> getServiceFactory() -> create('ChatNotification') -> smsNotification($payload);
        }
    }
}
```
```
NOW: (view class code)
Code:
#-------------------------------
var payload = {
    notificationType: 'eMail',
    authorId: authorId,
    subject: subject,
    body: body,
    portalBody: portalBody,
    distributionList: distributionList,
    portalDistributionList: portalDistributionList
};
// Make the request to the back-end: Ajax Call &gt; PHP Controller &gt; PHP Service &gt; PHP Controller &gt; Ajax Response
this.ajaxPostRequest('ChatPostNotification/action/sendChatActivityNotification', payload).then(
    function (responseData) {
        var serverResponse = '';
        if(typeof(responseData === "object")) {
            serverResponse = JSON.parse(responseData);
        } else {
            serverResponse = responseData;
        }
        console.log("Email Notifications sent to: ",serverResponse);
    }.bind(this)).fail(
    function (xhr) {
        xhr.errorIsHandled = true;
    }
);
```
```
NOW: (back-end controller class code)
PHP Code:
#-------------------------------
public function postActionSendChatActivityNotification($params, $data) {
    // build the payload to send to the Service class
    $payload = (object)[];
    $payload- > notificationType = $data -> notificationType;
    $payload -> authorId = $data -> authorId;
    $payload -> subject = $data -> subject;
    $payload -> body = $data -> body;
    $payload -> portalBody = $data ->portalBody;
    $payload -> distributionList = $data -> distributionList;
    $payload -> portalDistributionList = $data -> portalDistributionList;
    // invoke the appropriate service function depending on the type of notification requested
    if($payload > notificationType === "eMail") {
        $response = $this -> getServiceFactory() -> create('ChatNotification') -> emailNotification($payload);
    } elseif($payload -> notificationType === "sms") {
        $response = $this -> getServiceFactory() -> ('ChatNotification') -> smsNotification($payload);
    }
    return $response;
}
```
```
NOW: (back-end service class code)
PHP Code:
#-------------------------------
public function emailNotification($payload) {
    // Code to prepare and send notifications via eMail and store the list of email addresses to which the notifications were sent
    ......
    // return the list of email addresses to the controller
    echo json_encode($sentList);
}
```


#### Service Classes:
```
The base class Espo\Services\Services.php was refactored,
custom service class that extend from it will need the following modifications:
BEFORE
#-------------------------------

NOW
#-------------------------------
$this -> getSelectAttributeList($params);
$this -> getSelectManager() -> getSelectAttributeList($params);
```

#### ZendImap
```

BEFORE
use Zend\Mail\Protocol\Imap as ZendImap;

AFTER
use Laminas\Mail\Protocol\Imap as ZendImap;
```

------------------------------
#### getEntityManager

```

BEFORE
$this->getEntityManager()
->getQuery() # Method 'getQuery' is deprecated
->createSelectQuery('Call', $selectParams); # Method 'createSelectQuery' is deprecated
  
AFTER
$this->entityManager
->getQueryBuilder()
->select()
->from('Call')
->where($selectParams)
->build();
```


------------------------------

#### Class 'Base' is deprecated
```

BEFORE
namespace Espo\Custom\SelectManagers;
use Espo\Core\SelectManagers\Base;
class CaseX extends Base{}

AFTER
use Espo\ORM\Query\SelectBuilder;
use Espo\Core\Select\Primary\Filter;
class CaseX implements Filter{}
```

-------------------------------

#### Class 'SelectManager' is deprecated  @deprecated Since v7.0. 
##### Use SelectBuilder instead.


```

https://github.com/espocrm/espocrm/blob/master/application/Espo/Core/SelectManagers/Base.php
https://github.com/espocrm/espocrm/blob/master/application/Espo/Core/Select/SelectManager.php

https://github.com/espocrm/documentation/tree/master/i18n/ro_RO/development
https://github.com/espocrm/documentation/blob/master/i18n/ro_RO/development/orm.md

https://docs.espocrm.com/administration/formula/
https://docs.espocrm.com/development/services/
https://docs.espocrm.com/development/select-manager/
https://docs.espocrm.com/development/di/
https://docs.espocrm.com/administration/troubleshooting/
https://docs.espocrm.com/development/orm/

https://forum.espocrm.com/forum/developer-help/77957-selectmanagers-to-v7-x
https://forum.espocrm.com/forum/developer-help/52428-summ-records-grouped-by-field-of-current-record

https://hotexamples.com/de/examples/espo.orm/Entity/getEntityType/php-entity-getentitytype-method-examples.html
https://hotexamples.com/examples/espo.services/Record/-/php-record-class-examples.html
```


