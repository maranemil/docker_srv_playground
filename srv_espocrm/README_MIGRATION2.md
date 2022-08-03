```

FIX: MySQL – SELECT Command Denied To User
https://www.webhostface.com/kb/knowledgebase/mysql-select-command-denied-user/
https://stackoverflow.com/questions/4767055/error-select-command-denied-to-user-useridip-address-for-table-table

GRANT SELECT ON database_name.* TO 'espocrm'@'localhost';

GRANT ALL PRIVILEGES ON the_database.* TO 'espocrm'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```

------------------------------

```

How can PPAs be removed?

https://askubuntu.com/questions/307/how-can-ppas-be-removed
https://tableplus.com/blog/2019/10/tableplus-linux-installation.html

sudo add-apt-repository ppa:whatever/ppa
sudo add-apt-repository --remove ppa:whatever/ppa
```



--------------------------------------------------
```

Customization: How to create custom entity
https://www.espocrm.com/blog/how-to-create-custom-entity/

create new folders

application/Espo/Modules/PM
application/Espo/Modules/PM/Controllers/
application/Espo/Modules/PM/Entities/
application/Espo/Modules/PM/Resources/

Metadata definition

application/Espo/Modules/PM/Resources/metadata/scopes/Project.json

{
'entity': true,
'layouts': true,
'tab': true,
'acl': true,
'module': 'PM',
'customizable': true,
'stream': true,
'importable': true
}

application/Espo/Modules/PM/Resources/metadata/scopes/ProjectTask.json

{
'entity': true,
'layouts': true,
'tab': false,
'acl': true,
'module': 'PM',
'customizable': true,
'stream': true,
'importable': true
}

application/Espo/Modules/PM/Resources/metadata/entityDefs/Project.json

{
'fields':{
'name':{
'type':'varchar',
'required':true
},
'status':{
'type':'enum',
'options':[
'Draft',
'Active',
'Completed',
'On Hold',
'Dropped'
],
'default':'Active'
},
'description':{
'type':'text'
},
'account':{
'type':'link'
},
'createdAt':{
'type':'datetime',
'readOnly':true
},
'modifiedAt':{
'type':'datetime',
'readOnly':true
},
'createdBy':{
'type':'link',
'readOnly':true
},
'modifiedBy':{
'type':'link',
'readOnly':true
},
'assignedUser':{
'type':'link',
'required':true
},
'teams':{
'type':'linkMultiple'
}
},
'links':{
'createdBy':{
'type':'belongsTo',
'entity':'User'
},
'modifiedBy':{
'type':'belongsTo',
'entity':'User'
},
'assignedUser':{
'type':'belongsTo',
'entity':'User'
},
'teams':{
'type':'hasMany',
'entity':'Team',
'relationName':'EntityTeam'
},
'account':{
'type':'belongsTo',
'entity':'Account',
'foreign':'projects'
},
'projectTasks':{
'type':'hasMany',
'entity':'ProjectTask',
'foreign':'project'
}
},
'collection':{
'sortBy':'createdAt',
'asc':false,
'boolFilters':[
'onlyMy'
]
}
}

application/Espo/Modules/PM/Resources/metadata/entityDefs/ProjectTask.json

{
'fields':{
'name':{
'type':'varchar',
'required':true
},
'status':{
'type':'enum',
'options':[
'Not Started',
'Started',
'Completed',
'Canceled'
],
'default':'Not Started'
},
'dateStart':{
'type':'date'
},
'dateEnd':{
'type':'date'
},
'estimatedEffort':{
'type':'float'
},
'actualDuration':{
'type':'float'
},
'description':{
'type':'text'
},
'project':{
'type':'link'
},
'createdAt':{
'type':'datetime',
'readOnly':true
},
'modifiedAt':{
'type':'datetime',
'readOnly':true
},
'createdBy':{
'type':'link',
'readOnly':true
},
'modifiedBy':{
'type':'link',
'readOnly':true
},
'assignedUser':{
'type':'link',
'required':true
},
'teams':{
'type':'linkMultiple'
}
},
'links':{
'createdBy':{
'type':'belongsTo',
'entity':'User'
},
'modifiedBy':{
'type':'belongsTo',
'entity':'User'
},
'assignedUser':{
'type':'belongsTo',
'entity':'User'
},
'teams':{
'type':'hasMany',
'entity':'Team',
'relationName':'EntityTeam'
},
'project':{
'type':'belongsTo',
'entity':'Project',
'foreign':'projectTasks'
}
},
'collection':{
'sortBy':'createdAt',
'asc':false,
'boolFilters':[
'onlyMy'
]
}
}

--------

application/Espo/Modules/PM/Resources/metadata/clientDefs/Project.json

{
'controller': 'Controllers.Record'
}

application/Espo/Modules/PM/Resources/metadata/clientDefs/ProjectTask.json

{
'controller': 'Controllers.Record'
}


Controller classes
------------------
application/Espo/Modules/PM/Controllers/Project.php

namespace Espo\Modules\PM\Controllers;
class Project extends \Espo\Core\Controllers\Record{}

application/Espo/Modules/PM/Controllers/ProjectTask.php

namespace Espo\Modules\PM\Controllers;
class ProjectTask extends \Espo\Core\Controllers\Record{}

Entity classes
------------------
application/Espo/Modules/PM/Entities/Project.php

namespace Espo\Modules\PM\Entities; 
class Project extends \Espo\Core\ORM\Entity{}

application/Espo/Modules/PM/Entities/ProjectTask.php

namespace Espo\Modules\PM\Entities; 
class ProjectTask extends \Espo\Core\ORM\Entity{}

Language (I18n)
------------------

application/Espo/Modules/PM/Resources/i18n/en_US/Global.json

{
'scopeNames':{
'Project':'Project',
'ProjectTask':'Project Task'
},
'scopeNamesPlural':{
'Project':'Projects',
'ProjectTask':'Project Tasks'
}
}

application/Espo/Modules/PM/Resources/i18n/en_US/Project.json

{
'labels':{
'Create Project':'Create Project'
},
'fields':{
'name':'Name',
'status':'Status',
'account':'Account'
},
'links':{
'projectTasks':'Project Tasks'
}
}

application/Espo/Modules/PM/Resources/i18n/en_US/ProjectTask.json

{
'labels':{
'Create ProjectTask':'Create Project Task'
},
'fields':{
'name':'Name',
'status':'Status',
'project':'Project',
'dateStart':'Date Start',
'dateEnd':'Date End',
'estimatedEffort':'Estimated Effort (hrs)',
'actualDuration':'Actual Duration (hrs)'
}
}



https://www.espocrm.com/wp-content/uploads/PM.zip

https://docs.espocrm.com/development/hooks/
https://docs.espocrm.com/administration/bpm-events/
https://docs.espocrm.com/development/hooks/
```

---------------------------------------------------
```

https://forum.espocrm.com/forum/developer-help/55999-how-to-configure-webhook-returning-404

make a custom API entry point,


custom/Espo/Custom/Resources/routes.json
[
  {
    “route”: “/ExternalForm/:action/:apiKey”,
    “method”: “post”,
    “params”: {
      “controller”: “ExternalForm”,
      “action”: “:action”,
      “apiKey”: “:apiKey”
   },
    “conditions”: {
      “auth”: false
    }
  }
]

custom/Espo/Custom/Controllers/ExternalForm.php

namespace Espo\Custom\Controllers;

use \Espo\Core\Exceptions\Forbidden;
use \Espo\Core\Exceptions\BadRequest;
use \Espo\Core\Exceptions\NotFound;

class ExternalForm extends \Espo\Core\Controllers\Base
{
  public function postActionSomeExample($params, $data, $request, $response)
  {
     if (empty($params[‘apiKey’])) throw new BadRequest(‘No API Key!’);
     if (empty($data)) throw new BadRequest(‘No payload provided’);

     $allowOrigin = $this->getConfig()->get(‘leadCaptureAllowOrigin’, ‘*’);
     $response->headers->set(‘Access-Control-Allow-Origin’, $allowOrigin);

     $apiKey = $params[‘apiKey’];
     $validKey = $this->getServiceFactory()->create(‘LeadCapture’)->isApiKeyValid($apiKey);

     if ($validKey) {
       $lead = $this->getServiceFactory()->create(‘Lead’)->someActionName($data, $apiKey);
       return $lead
     } else {
        return ‘some error message!’;
     }
  }
}


send a POST request to:
https://{espocrm_root}/api/v1/ExternalForm/someExample/{someApiKey}

custom/Espo/Custom/Services/Lead.php
```

---------------------------------------------------
```

https://docs.espocrm.com/
https://docs.espocrm.com/administration/bpm-events/
https://docs.espocrm.com/administration/troubleshooting/
https://github.com/espocrm/documentation/blob/master/docs/administration/bpm-drip-email-campaign.md
https://github.com/espocrm/documentation/blob/master/docs/administration/bpm-activities.md
https://github.com/espocrm/documentation/blob/master/docs/administration/bpm.md#manipulating
--------------------------------------------------
https://docs.espocrm.com/administration/bpm-activities/
https://docs.espocrm.com/administration/config-params/
https://docs.espocrm.com/administration/extensions/
https://docs.espocrm.com/administration/formula/
https://docs.espocrm.com/administration/import/
https://docs.espocrm.com/development/api-action/
https://docs.espocrm.com/development/coding-rules/
https://docs.espocrm.com/development/di/
https://docs.espocrm.com/development/metadata/select-defs/
https://docs.espocrm.com/development/select-builder/
https://docs.espocrm.com/development/select-manager/
https://docs.espocrm.com/development/services/


php command.php extension --file="path/to/extension/package.zip"


https://github.com/espocrm
https://github.com/espocrm/espocrm
https://github.com/espocrm/ext-template
https://github.com/espocrm/ext-real-estate
https://github.com/espocrm/ext-sms-providers
https://www.espocrm.com/extensions/real-estate/
https://www.espocrm.com/industries/real-estate/
https://github.com/espocrm/ext-real-estate/releases

https://hotexamples.com/de/examples/espo.core.selectmanagers/Base/-/php-base-class-examples.html
--------------------------------------------------
```


### SelectManagers to v7.x

```

Before
namespace Espo\Custom\SelectManagers;
class Patient extends \Espo\Core\SelectManagers\Base{
    protected function boolFilterOpen(&$result)
    {
        $this->filterOpen($result);
    }

    protected function filterOpen(&$result)
    {
        $result['whereClause'][] = array(
        'status!=' => ['Completed', 'Canceled', 'Deferred', 'Rejected']);
    }
}


AFTER
namespace Espo\Custom\Select;
use Espo\ORM\Query\SelectBuilder;
use Espo\ORM\Query\Part\Condition as Cond;
use Espo\Core\Select\Primary\Filter;
class Patient implements Filter {
     public function apply(
	SelectBuilder $queryBuilder, 
	OrGroupBuilder $orGroupBuilder): void
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

application/Espo/Custom/Resources/metadata/selectDefs/Patient.json

https://forum.espocrm.com/forum/developer-help/77957-selectmanagers-to-v7-x
```


------------------------------------------
```

https://forum.espocrm.com/forum/general/45461-default-filters

custom/Espo/Custom/SelectManagers/Contact.php

namespace Espo\Custom\SelectManagers;
class Contact extends \Espo\Modules\Crm\SelectManagers\Contact
{
    protected function boolFilterIsActive(&$result)
    {
        $result['whereClause'][] = array('isActive' => true);
    }
}

# Resources/clientDefs/
{
    "boolFilterList": [
        "onlyMy",
        "isActive"
    ]
} 


custom/Espo/Custom/Resources/metadata/clientDefs/Contact.json

{
    "defaultFilterData": {
           "primary": "active"
     }
}

{
    "defaultFilterData": {
           "advanced": {
                "orderDate": {
                        "type": "lastSevenDays"
                 }
            }
     }
}
```

------------------------------------------
```

https://forum.espocrm.com/forum/installation-and-upgrade-help/75013-upgrade-6-10-to-v7-selectmanagers-recorddefs

namespace Espo\Custom\SelectManagers;

class Account extends \Espo\Modules\Crm\SelectManagers\Account
{
	protected function boolFilterIsMember(&$result)
	{
		$result['whereClause'][] = array('isMember' => true);
	}
	protected function boolFilterIsActive(&$result)
	{
		$result['whereClause'][] = array('isActive' => true);	
	}
}


namespace Espo\Custom\SelectBuilder;
use Espo\ORM\Query\Part\Condition as Cond;
use Espo\ORM\Query\SelectBuilder;

class Account extends SelectBuilder
{
    public function apply(SelectBuilder $queryBuilder): void
    {
        $notOpenList = [true];
        $queryBuilder->where(
            Cond::notIn(
                Cond::column('isActive'),
                $notOpenList
            )
        );
    }
}
```

------------------------------------------------------------------------------------
```

https://forum.espocrm.com/forum/developer-help/65066-tips-for-adapting-previous-custom-code-to-work-with-espo-6-0

Tips for adapting previous custom code to work with Espo 6.0+


BEFORE:
Code:
class MyCustomHook extends \Espo\Core\Hooks\Base {
    // some code
    $this -> getEntityManager() ->
    // more code
}
NOW:
Code:
use Espo\Core\ORM\EntityManager;
class MyCustomHook {
    protected $entityManager;

    public function __construct(EntityManager $entityManager) {
        $this->entityManager = $entityManager;
    }

    // some code
    $this -> entityManager ->
    // more code
}

BEFORE:
Code:
class MyCustomHook extends \Espo\Core\Hooks\Base {
    // some code
    $this -> getConfig() ->
    // more code
}
NOW:
Code:
use Espo\Core\Utils\Config;

class MyCustomHook {
    protected $config;

    public function __construct(Config $config) {
        $this -> config = $config;

    // some code
    $this -> config ->
    // more code

BEFORE:
Code:
class MyCustomHook extends \Espo\Core\Hooks\Base {

    // some code
    $this -> getMetadata() ->
    // more code
}
NOW:
Code:
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
BEFORE:
Code:
class MyCustomHook extends \Espo\Core\Hooks\Base {

// custom hook functions
...
$this -> getContainer() ->
...
}
NOW:
Code:
use Espo\Core\Container;

class MyCustomHook {
protected $container;

public function __construct(Container $container) {
$this -> container = $container;
}

// custom hook functions
....
$this > container ->
....
BEFORE:
Code:
class MyCustomHook extends \Espo\Core\Hooks\Base {

// custom hook functions
...
[COLOR=#000000]$this -> getServiceFactory() ->[/COLOR]
...
}
NOW:
Code:
use Espo\Core\ServiceFactory;

class MyCustomHook {
protected $serviceFactory;

public function __construct(ServiceFactory $serviceFactory) {
$this -> serviceFactory = $serviceFactory;
}

// custom hook functions
....
[COLOR=#000000]$this -> serviceFactory ->[/COLOR]
....
BEFORE:
Code:
class MyCustomHook extends \Espo\Core\Hooks\Base {

// custom hook functions
...
[COLOR=#000000]$this -> getUser() -> [/COLOR]
}
NOW:
Code:
use Espo\Entities\User;

class MyCustomHook {
protected $user;

public function __construct(User $user) {
$this -> user = $user;
}

// custom hook functions
....
[COLOR=#000000]$this -> user -> [/COLOR]
....
BEFORE:
Code:
class MyCustomHook extends \Espo\Core\Hooks\Base {

// custom hook functions
...
[COLOR=#000000]$this -> getContainer() -> get('mailSender');[/COLOR]
...
}
NOW:
Code:
use Espo\Core\Di;

class MyCustomHook implements Di\EmailSenderAware {

use Di\EmailSenderSetter;

// custom hook functions
....
[COLOR=#000000]$mailSender = $this -> emailSender -> create();[/COLOR]
....

Entry Points:

Entry points can only be invoked now using GET requests, if your code has entry point calls using POST requests (like we had because in some cases I didn't want to display the payload parameters in the browser's url) you could replace the entry point call with a standard Ajax - Controller - Service -Controller - Ajax implementation as follows:

BEFORE: (view code)
Code:
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
BEFORE: (entry point class code)
PHP Code:
......
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


NOW: (view class code)
Code:
......
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
NOW: (back-end controller class code)
PHP Code:
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
NOW: (back-end service class code)
PHP Code:
public function emailNotification($payload) {
    // Code to prepare and send notifications via eMail and store the list of email addresses to which the notifications were sent
    ......
    // return the list of email addresses to the controller
    echo json_encode($sentList);
} 

Service Classes:

The base class Espo\Services\Services.php was refactored, custom service class that extend from it will need the following modifications:
BEFORE	NOW
$this -> getSelectAttributeList($params);	$this -> getSelectManager() -> getSelectAttributeList($params);
```

-------------------------------------
```

https://forum.espocrm.com/forum/installation-and-upgrade-help/75424-solutions-to-adapting-previous-custom-code-to-work-with-espo-7-x

Solutions to adapting previous custom code to work with Espo 7.x


Solution: Modify the custom EntryPoint class as follows:
BEFORE:
Code:
use Espo\Core\EntryPoints\{
EntryPoint
};
use Espo\Core\EntryPoints\{
EntryPoint
};
NOW:
Code:
use Espo\Core\EntryPoint\{
EntryPoint
};
use Espo\Core\{
Api\Request,
Api\Response
};
BEFORE:
Code:
public function run(Request $request)
NOW:
Code:
public function run(Request $request, Response $response): void

--

Solution: Modify the method signature in the Custom Controller:
BEFORE:
Code:
namespace Espo\Modules\ControlBoard\Controllers;

class ControlBoard extends \Espo\Core\Templates\Controllers\Base
{
    public function actionTotalsByCriteria($params, $request, $data) {
         $criteriaScope = $data->get('criteriaScope');
         (more code here)
    }
}
AFTER:
Code:
namespace Espo\Modules\ControlBoard\Controllers;

use Espo\Core\Api\Request;

class ControlBoard extends \Espo\Core\Templates\Controllers\Base
{
    public function actionTotalsByCriteria(Request $request):array {
        $data = $request->getQueryParams();
        $criteriaScope = $data["criteriaScope"];
        (more code here)        
    }
}
ERROR MESSAGE:
ERROR: Slim Application Error Type: Error Code: 0 Message: Call to undefined method Espo\Modules\PropertyManagement\Controllers\Servic eTicket::fetchListParamsFromRequest()
Solution: Modify the method call
BEFORE:
Code:
public function getActionListDataCards($params, $request, $data)
{
    (more code here)
    $params = [];
    // get the collection parameters from the front-end request
    $this->fetchListParamsFromRequest($params, $request, $data);
    (mode code here)
}
AFTER
Code:
public function getActionListDataCards(Request $request): object
{
    (more code here)
    // get the collection parameters from the front-end request
    $params = $request->getQueryParams();
}

---

BEFORE:
Code:
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
AFTER
Code:
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

---

BEFORE:
Code:
namespace Espo\Modules\ControlBoard\Services;

use Espo\Core\Utils\Util;

class ControlBoard extends \Espo\Services\Record
{

    public function getListDataCards($params)
    {
        $disableCount = $this->metadata->get(['entityDefs', $this->entityType, 'collection', 'countDisabled']) ?? false;
        if ($this->listCountQueryDisabled || $this->getMetadata()->get(['entityDefs', $this->entityType, 'collection', countDisabled']) ) {
            $disableCount = true;
        }
        $maxSize = 0;
        if ($disableCount) {
            if (!empty($params['maxSize'])) {
                $maxSize = $params['maxSize'];
                $params['maxSize'] = $params['maxSize'] + 1;
            }
        }

        // translate the front-end parameters ($params) for the SELECT query into specifications understood by the Espo ORM language
        $selectParams = $this->getSelectParams($params);  

        // define additional values for he ORM SELECT query parameters
        $selectParams['maxTextColumnsLength'] = $this->getMaxSelectTextAttributeLength();

        // extract the list of fields to be included into the ORM SELECT query parameters from the front-end input ($params)
        $selectAttributeList = $this->getSelectManager()->getSelectAttributeList($params);
        if ($selectAttributeList) {
            $selectParams['select'] = $selectAttributeList;
        } else {
            $selectParams['skipTextColumns'] = $this->isSkipSelectTextAttributes();
        }

        // extract the Control Board display data from the target entity's entitydefs
        $controlBoardCriteriaData = $this->getMetadata()->get(['entityDefs', $this->entityType, 'controlBoardCriteriaData']);
        $controlBoardCriteriaField = $controlBoardCriteriaData['controlBoardCriteriaField'];
        $fieldSelectStatement = $this->getMetadata()->get(['entityDefs', $this->entityType, 'fields', $controlBoardCriteriaField, 'select']);
        // update if necessary the criteria filed's value
        if ($fieldSelectStatement) {
            $pdo = $this->getEntityManager()->getPDO();
            $sql = 'UPDATE '.Util::camelCaseToUnderscore($this->entityType).' SET `'.$controlBoardCriteriaField.'` = '.$fieldSelectStatement;
            $sth = $pdo->prepare($sql);
            $sth->execute();
        }
        // fetch a collection of target entity records
        $collection = new \Espo\ORM\EntityCollection([], $this->entityType);  
        // get the filter values for each data group
        $criteriaConditionGroups = $controlBoardCriteriaData['criteriaConditionGroups'];
        $additionalData = (object) [
            'groupList' => []
        ];
        // fetch sub-collections of each data group
        foreach ($criteriaConditionGroups as $group) {
            $selectParamsSub = $selectParams;
            $type = $group['conditionGroupType'];
            $label = $group['conditionGroupLabel'];
            $conditionIndex = 0;
            foreach($group['conditionValues'] as $whereCondition) {
                $operator = '';
                if($whereCondition['operator'] && $whereCondition['operator'] !== '=') {
                    $operator = $whereCondition['operator'];
                }
                $groupValue = $whereCondition['value'];
                if($whereCondition['valueType'] && $whereCondition['valueType'] === 'int') {
                    $groupValue = intval($groupValue);
                }
                if($conditionIndex > 0 && $type === 'or') {
                    $selectParamsSub['whereClause'][] = ['OR' => [$controlBoardCriteriaField.$operator => $groupValue]];
                } else {
                    $selectParamsSub['whereClause'][] = [$controlBoardCriteriaField.$operator => $groupValue];
                }
                $conditionIndex++;
            }
            $o = (object) [
                'name' => $label
            ];
            $collectionSub = $this->getRepository()->find($selectParamsSub);
            if (!$disableCount) {
                $totalSub = $this->getRepository()->count($selectParamsSub);
            } else {
                if ($maxSize && count($collectionSub) > $maxSize) {
                    $totalSub = -1;
                    unset($collectionSub[count($collectionSub) - 1]);
                } else {
                    $totalSub = -2;
                }
            }
            foreach ($collectionSub as $e) {
                $this->loadAdditionalFieldsForList($e);
                if (!empty($params['loadAdditionalFields'])) {
                    $this->loadAdditionalFields($e);
                }
                if (!empty($selectAttributeList)) {
                    $this->loadLinkMultipleFieldsForList($e, $selectAttributeList);
                }
                $this->prepareEntityForOutput($e);
                $collection[] = $e;
            }
            $o->total = $totalSub;
            $o->list = $collectionSub->getValueMapList();
            $additionalData->groupList[] = $o;
        }
        if (!$disableCount) {
            $total = $this->getRepository()->count($selectParams);
        } else {
            if ($maxSize && count($collection) > $maxSize) {
                $total = -1;
                unset($collection[count($collection) - 1]);
            } else {
                $total = -2;
            }
        }
        return (object) [
            'total' => $total,
            'collection' => $collection,
            'additionalData' => $additionalData
        ];
    }
}
AFTER:
Code:
namespace Espo\Modules\ControlBoard\Services;

use Espo\Core\Utils\Util;
use Espo\Core\{
FieldProcessing\ListLoadProcessor,
FieldProcessing\Loader\Params as FieldLoaderParams
};

class ControlBoard extends \Espo\Services\Record
{

    public function getListDataCards($searchParams)
    {
        $disableCount = $this->metadata->get(['entityDefs', $this->entityType, 'collection', 'countDisabled']) ?? false;
        $maxSize = $searchParams->getMaxSize();
        if ($disableCount && $maxSize) {
            $searchParams = $searchParams->withMaxSize($maxSize + 1);
        }

        // use the SelectBuilderFactory class to generate Espo's ORM SELECT query values from the front-end input ($searchParams)
        $query = $this->selectBuilderFactory->create()->from($this->entityType)->withStrictAccessControl()->withSearchParams($searchParams)->build();

        // initialize the group filtering query specs
        $additionalData = (object) ['groupList' => [],];

        // instantiate the target entity's Repository class
        $repository = $this->entityManager->getRepository($this->entityType);

        // get the filter values for each data group
        $controlBoardCriteriaData = $this->metadata->get(['entityDefs', $this->entityType,'controlBoardCriteriaData']);
        
         $controlBoardCriteriaField = $controlBoardCriteriaData['controlBoardCriteriaField'];

        $fieldSelectStatement = $this->getMetadata()->get(['entityDefs', $this->entityType, 'fields',$controlBoardCriteriaField, 'select']);

        if ($fieldSelectStatement) {
            $pdo = $this->getEntityManager()->getPDO();
            $sql = 'UPDATE '.Util::camelCaseToUnderscore($this->entityType).' SET `'.$controlBoardCriteriaField.'` = '.$fieldSelectStatement;
            $sth = $pdo->prepare($sql);
            $sth->execute();
        }

        // fetch a collection of target entity records
        $collection = new \Espo\ORM\EntityCollection([], $this->entityType);

        $criteriaConditionGroups = $controlBoardCriteriaData['criteriaConditionGroups'];

        $additionalData = (object) [
            'groupList' => []
        ];

        // create sub collections for each condition group filtering values
        foreach ($criteriaConditionGroups as $group) {
            $type = $group['conditionGroupType'];
            $label = $group['conditionGroupLabel'];
            $conditionIndex = 0;
            foreach($group['conditionValues'] as $whereCondition) {
                $whereClause = [];
                $operator = '';
                if($whereCondition['operator'] && $whereCondition['operator'] !== '=') {
                    $operator = $whereCondition['operator'];
                }
                $groupValue = $whereCondition['value'];
                if($whereCondition['valueType'] && $whereCondition['valueType'] === 'int') {
                    $groupValue = intval($groupValue);
                }
                if($conditionIndex > 0 && $type === 'or') {
                    $whereClause[] = ['OR' => [$controlBoardCriteriaField.$operator => $groupValue]];
                } else {
                    $whereClause[] = [$controlBoardCriteriaField.$operator => $groupValue];
                }
                $conditionIndex++;
            }
            $itemSelectBuilder = $this->entityManager->getQueryBuilder()->select()->clone($query);
            $itemSelectBuilder->where($whereClause);
            $groupObject = (object) [
                'name' => $label
            ];
            $itemQuery = $itemSelectBuilder->build();

            $collectionSub = $repository->clone($itemQuery)->find();

            if (!$disableCount) {
                $totalSub = $repository->clone($itemQuery)->count();
            } else {
                if ($maxSize && count($collectionSub) > $maxSize) {
                    $totalSub = -1;
                    unset($collectionSub[count($collectionSub) - 1]);
                } else {
                    $totalSub = -2;
                }
            }
            $fieldLoader = new FieldLoaderParams();
            $loadProcessorParams = $fieldLoader->withSelect($searchParams->getSelect());
            foreach ($collectionSub as $e) {
                $this->listLoadProcessor->process($e, $loadProcessorParams);
                $recordService->prepareEntityForOutput($e);
                $collection[] = $e;
            }
            $groupObject->total = $totalSub;
            $groupObject->list = $collectionSub->getValueMapList();
            $additionalData->groupList[] = $groupObject;
        }
        if (!$disableCount) {
            $total = $repository->clone($query)->count();
        } else {
            if ($maxSize && count($collection) > $maxSize) {
                $total = -1;
                unset($collection[count($collection) - 1]);
            } else {
                $total = -2;
            }
        }
        $result = (object) [
            'total' => $total,
            'collection' => $collection,
            'additionalData' => $additionalData
        ];
        return $result;
    }
}
```

-----
```

BEFORE:
Code:
namespace Espo\Modules\ListPlus\Controllers;

use Espo\Core\{
Container,
Api\Request
};

class ListPlusAdmin
{
    protected $container;

    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    public function postActionCreateScopeBackEndChanges(Request $request) {
        // extract the payload from the request object
        $dataObj = $request->getParsedBody();
        // invoke service class to execute the instructions passing the payload as object
        $result = $this->container->get('serviceFactory')->create('ListPlusAdmin')->createScopeBackEndChanges($dataObj);
        return $result;
    }
}
AFTER:
Code:
namespace Espo\Modules\ListPlus\Controllers;

use Espo\Core\{
Di,
Api\Request
};

class ListPlusAdmin implements Di\ServiceFactoryAware
{
    use Di\ServiceFactorySetter;

    public function postActionCreateScopeBackEndChanges(Request $request) {
        // extract the payload from the request object
        $dataObj = $request->getParsedBody();
        // invoke service class to execute the instructions passing the payload as object
        $result = $this->serviceFactory->create('ListPlusAdmin')->createScopeBackEndChanges($dataObj);
        return $result;
    }
}
```

---
```


BEFORE:
Code:
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
AFTER:
Code:
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

---
```

BEFORE:
PHP Code:
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
NOW
PHP Code:
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


---------------------------------------------------------------------------
```

https://forum.espocrm.com/forum/developer-help/52428-summ-records-grouped-by-field-of-current-record

namespace Espo\Custom\Core\Formula\Functions\EntityGroup;

use \Espo\ORM\Entity;
use \Espo\Core\Exceptions\Error;

class OfferSummType extends \Espo\Core\Formula\Functions\Base
{
    protected function init()
    {
        $this->addDependency('entityManager');
        $this->addDependency('selectManagerFactory');
    }

    public function process(\StdClass $item)
    {
        /*
        if (!property_exists($item, 'value')) {
            throw new Error();
        }

        if (!is_array($item->value)) {
            throw new Error();
        }

        if (count($item->value) < 2) {
            throw new Error();
        }
        */


        $entity = $this->getEntity();
        //$entityManager = $this->getInjection('entityManager');


        //$entityManager = $this->getEntityManager();
        $entityManager = $this->getInjection('entityManager');

        $offerId = $entity->get('offer');
        if (!offerId) {
            throw new Error();
        }
        $selectParams['select'] = ['offerId', 'SUM:' . 'summ'];
        $selectParams['where'] = [
            'offerId' => $offerId
        ];
        $selectParams['groupBy'] = ['offerId'];

        $entityManager->getRepository($entity->getEntityName())->handleSelectParams($selectParams);


        $sql = $entityManager->getQuery()->createSelectQuery($entity->getEntityName(), $selectParams);

        $pdo = $entityManager->getPDO();
        $sth = $pdo->prepare($sql);
        $sth->execute();
        $rowList = $sth->fetchAll(\PDO::FETCH_ASSOC);

        if (empty($rowList)) {
            return 0;
        }

        return floatval($rowList[0]['SUM:' . 'summ']);


        /*
        $entityManager = $this->getEntityManager();
        $offerDatas = $this->getRepository();
        $offer = $entityManager->getEntity('Offer');
        $offerdatasList = $offerDatas->findRelated($offer, '$offerdatas');
        $summ = 0;
        foreach ($offerdatasList as $key => $value) {
            if($key == 'summ') $summ += $value; 
        }

        return $summ;
        */
        /*
        $offer = $this->evaluate($item->value[0]);
        $entityManager = $this->getEntityManager();
        $offerData = $entityManager->getEntity('OfferData');
        $offer = $entityManager->getEntity('Offer');
        */

        /*
        $haystack = $this->evaluate($item->value[0]);
        $needle = $this->evaluate($item->value[1]);

        if (count($item->value) > 2) {
            $offset = $this->evaluate($item->value[2]);
            return !(strpos($haystack, $needle, $offset) === false);
        } else {
            return !(strpos($haystack, $needle) === false);
        }
        */
    }
}
```

---------------------------------------------------------------------------
```

https://forum.espocrm.com/forum/developer-help/51431-how-to-add-reminder-field-to-new-entity


namespace Espo\Custom\Services;

use \Espo\Core\Exceptions\Error;
use \Espo\Core\Exceptions\NotFound;
use \Espo\Core\Exceptions\Forbidden;

use \Espo\ORM\Entity;

use \PDO;

class Activities extends \Espo\Modules\Crm\Services\Activities
{

    public function getPopupNotifications($userId)
    {
        $pdo = $this->getPDO();

        $dt = new \DateTime();

        $pastHours = $this->getConfig()->get('reminderPastHours', self::REMINDER_PAST_HOURS);

        $now = $dt->format('Y-m-d H:i:s');
        $nowShifted = $dt->sub(new \DateInterval('PT'.strval($pastHours).'H'))->format('Y-m-d H:i:s');

        $sql = "
            SELECT id, entity_type AS 'entityType', entity_id AS 'entityId'
            FROM `reminder`
            WHERE
                `type` = 'Popup' AND
                `user_id` = ".$pdo->quote($userId)." AND
                `remind_at` <= '{$now}' AND
                `start_at` > '{$nowShifted}' AND
                `deleted` = 0
        ";

        $sth = $pdo->prepare($sql);
        $sth->execute();
        $rowList = $sth->fetchAll(PDO::FETCH_ASSOC);

        $resultList = [];
        foreach ($rowList as $row) {
            $reminderId = $row['id'];
            $entityType = $row['entityType'];
            $entityId = $row['entityId'];

            $entity = $this->getEntityManager()->getEntity($entityType, $entityId);
            $data = null;

            if ($entity) {

                $dateAttribute = 'dateStart';
                if ($entityType === 'Case') {
                    $dateAttribute = 'dateEnd';
                }

                $data = [
                    'id' => $entity->id,
                    'entityType' => $entityType,
                    $dateAttribute => $entity->get($dateAttribute),
                    'name' => $entity->get('name')
                ];
            } else {
                continue;
            }
            $resultList[] = [
                'id' => $reminderId,
                'data' => $data
            ];

        }
        return $resultList;
    }

}

```

----------------------
```

LDAP Auth not working - user found, but error is wrong username/password

https://forum.espocrm.com/forum/installation-and-upgrade-help/54712-ldap-auth-not-working-user-found-but-error-is-wrong-username-password
https://forum.espocrm.com/forum/general/62683-fallback-authentication-mechanism-when-ldap-fails
https://docs.espocrm.com/administration/server-configuration/#permissions
https://docs.espocrm.com/administration/troubleshooting/


'authenticationMethod' => 'Espo', 


'authenticationMethod' => 'LDAP',
'ldapUserNameAttribute' => 'uid',
'ldapUserObjectClass' => 'inetOrgPerson',
'ldapHost' => 'ldap.xxxxx.com',
'ldapPort' => '389',
'ldapAuth' => true,
'ldapSecurity' => 'TLS',
'ldapUsername' => 'uid=xxxxx.xxxxx,ou=Users,o=xxxxx,dc=xxxxx,dc=com',
'ldapPassword' => 'xxxxx',
'ldapBindRequiresDn' => true,
'ldapBaseDn' => 'o=xxxxx,dc=xxxxx,dc=com',
'ldapUserLoginFilter' => 'memberOf=cn=EspoCRM LDAP Users,ou=Users,o=xxxxx,dc=xxxxx,dc=com',
'ldapTryUsernameSplit' => false,
'ldapOptReferrals' => false,
'ldapCreateEspoUser' => false,
'ldapAccountCanonicalForm' => 'Dn'

https://github.com/espocrm/espocrm/commit/30afaa56ab873c32dd80dff92cd498eba82f54fc


$entityManager = $this->entityManager; # old way
$entityManager = $this->getEntityManager(); # new way

$systemUser = $entityManager->getRepository('User')->get('system'); # old way
$systemUser = $entityManager->getEntity('User', 'system'); # new way



-----


BEFORE
use Zend\Mail\Protocol\Imap as ZendImap;

AFTER
use Laminas\Mail\Protocol\Imap as ZendImap;

------------------------------

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


------------------------------

Class 'Base' is deprecated

BEFORE
namespace Espo\Custom\SelectManagers;
use Espo\Core\SelectManagers\Base;
class CaseX extends Base{}

AFTER
namespace Espo\Custom\SelectBuilder;
use Espo\ORM\Query\SelectBuilder;
use Espo\Core\Select\Primary\Filter;
class CaseX implements Filter{}
```

-------------------------------
```

Class 'SelectManager' is deprecated  @deprecated Since v7.0. Use SelectBuilder instead.

https://github.com/espocrm/espocrm/blob/master/application/Espo/Core/SelectManagers/Base.php
https://github.com/espocrm/espocrm/blob/master/application/Espo/Core/Select/SelectManager.php

https://github.com/espocrm/documentation/tree/master/i18n/ro_RO/development
https://github.com/espocrm/documentation/blob/master/i18n/ro_RO/development/orm.md

https://docs.espocrm.com/administration/formula/
https://docs.espocrm.com/administration/troubleshooting/
https://docs.espocrm.com/development/di/
https://docs.espocrm.com/development/orm/
https://docs.espocrm.com/development/select-manager/
https://docs.espocrm.com/development/services/

https://forum.espocrm.com/forum/developer-help/77957-selectmanagers-to-v7-x
https://forum.espocrm.com/forum/developer-help/52428-summ-records-grouped-by-field-of-current-record


https://hotexamples.com/de/examples/espo.orm/Entity/getEntityType/php-entity-getentitytype-method-examples.html
https://hotexamples.com/examples/espo.services/Record/-/php-record-class-examples.html
```









































