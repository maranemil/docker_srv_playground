#!/bin/bash

# Settings
USER=espocrm
PASSWORD=database_password
HOSTNAME=172.21.0.3
DATABASE=espocrm
ANONYMIZED=anonymized

# anonymise data
mysql -u $USER -p$PASSWORD -h $HOSTNAME -D $DATABASE <<EOF

  # ----------------------
  UPDATE IGNORE account SET
    name='$ANONYMIZED',
    website='$ANONYMIZED',
    sic_code='12345678',
    billing_address_street='$ANONYMIZED',
    billing_address_city='$ANONYMIZED',
    billing_address_state='$ANONYMIZED',
    billing_address_country='$ANONYMIZED',
    billing_address_postal_code='10000',
    shipping_address_street='10000',
    shipping_address_city='$ANONYMIZED',
    shipping_address_state='$ANONYMIZED',
    shipping_address_country='$ANONYMIZED',
    shipping_address_postal_code='10000',
    description='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE account_contact SET role='$ANONYMIZED' WHERE 1;
  DELETE FROM action_history_record WHERE 1;
  UPDATE attachment SET name='$ANONYMIZED.pdf' WHERE 1;
  DELETE FROM auth_log_record WHERE 1;
  DELETE FROM auth_token WHERE 1;

  UPDATE IGNORE \`call\` SET
    name="$ANONYMIZED",
    description="$ANONYMIZED",
    date_start=NOW(),
    date_end=NOW()
  WHERE 1;

  # ----------------------
  UPDATE IGNORE campaign SET
    name='$ANONYMIZED',
    budget='10',
    description='$ANONYMIZED',
    start_date=NOW(),
    end_date=NOW()
  WHERE 1;

  # ----------------------
  DELETE FROM campaign_log_record WHERE 1;

  # ----------------------
  UPDATE IGNORE campaign_tracking_url SET
    name='$ANONYMIZED',
    url='$ANONYMIZED',
    action='$ANONYMIZED',
    message='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE \`case\` SET
    name='$ANONYMIZED',
    description='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE contact SET
    name='$ANONYMIZED',
    first_name='$ANONYMIZED',
    last_name='$ANONYMIZED',
    description='$ANONYMIZED',
    address_street='$ANONYMIZED',
    address_city='$ANONYMIZED',
    address_state='$ANONYMIZED',
    address_country='$ANONYMIZED',
    address_postal_code='10000',
    middle_name='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE contact_opportunity SET
    role='$ANONYMIZED' WHERE 1;

  # ----------------------
  UPDATE IGNORE document SET
    description='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE document_folder SET
    name='$ANONYMIZED',
    description='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE email SET
    name='$ANONYMIZED'
  WHERE 1;
  -- DELETE FROM email WHERE 1;

  # ----------------------
  DELETE FROM email_account WHERE 1;

  # ----------------------
  UPDATE IGNORE email_address SET
    name='$ANONYMIZED@localhost.de',
    lower='$ANONYMIZED@localhost.de'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE email_folder SET
    name='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  DELETE FROM email_inbound_email WHERE 1;
  DELETE FROM email_queue_item WHERE 1;

  # ----------------------
  UPDATE IGNORE email_template SET
    name='$ANONYMIZED',
    subject='$ANONYMIZED',
    body='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  # Account Contact Lead User
  /*UPDATE IGNORE entity_email_address SET
    entity_type='$ANONYMIZED'
  WHERE 1;*/

  # ----------------------
  # Account Contact Lead User
  /*UPDATE IGNORE entity_phone_number SET
    entity_type='$ANONYMIZED'
  WHERE 1;*/

  # ----------------------
  DELETE FROM inbound_email WHERE 1;
  DELETE FROM inbound_email_team WHERE 1;
  DELETE FROM integration WHERE 1;

  # ----------------------
  DELETE FROM job WHERE 1;

  # ----------------------
  UPDATE IGNORE knowledge_base_article SET
     name='$ANONYMIZED',
     body='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE layout_record SET
     name='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE layout_set SET
     name='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE \`lead\` SET
     name='$ANONYMIZED',
     first_name='$ANONYMIZED',
     last_name='$ANONYMIZED',
     title='$ANONYMIZED',
     industry='$ANONYMIZED',
     website='$ANONYMIZED',
     address_street='$ANONYMIZED',
     address_city='$ANONYMIZED',
     address_state='$ANONYMIZED',
     address_country='$ANONYMIZED',
     address_postal_code=10000,
     description='$ANONYMIZED',
     account_name='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE lead_capture SET
     name='$ANONYMIZED',
     lead_source='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  DELETE FROM lead_capture_log_record WHERE 1;
  DELETE FROM mass_action WHERE 1;
  DELETE FROM mass_email WHERE 1;
  DELETE FROM mass_email_target_list WHERE 1;
  DELETE FROM mass_email_target_list_excluding WHERE 1;

  # ----------------------
  UPDATE IGNORE meeting SET
     name='$ANONYMIZED',
     date_start=NOW(),
     date_end=NOW()
  WHERE 1;

  # ----------------------
  UPDATE IGNORE opportunity SET
     name='$ANONYMIZED',
     description='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  DELETE FROM password_change_request WHERE 1;

  # ----------------------
  UPDATE IGNORE phone_number SET
     name='1234567890',
     \`numeric\`=1234567890
  WHERE 1;

  # ----------------------
  UPDATE IGNORE portal SET
     name='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  DELETE FROM reminder WHERE 1;
  DELETE FROM scheduled_job WHERE 1;
  DELETE FROM scheduled_job_log_record WHERE 1;
  DELETE FROM sms WHERE 1;
  DELETE FROM sms_phone_number WHERE 1;

  # ----------------------
  UPDATE IGNORE target_list SET
     name='$ANONYMIZED',
     description='$ANONYMIZED'
  WHERE 1;

  # ----------------------
  UPDATE IGNORE task SET
     name='$ANONYMIZED',
     description='$ANONYMIZED',
     date_start=NOW(),
     date_end=NOW()
  WHERE 1;

  DELETE FROM two_factor_code WHERE 1;

  # ----------------------
  UPDATE IGNORE user SET
     name='$ANONYMIZED',
     password='1234',
     first_name='$ANONYMIZED',
     last_name='$ANONYMIZED'
  WHERE name != 'Admin' ;

  DELETE FROM webhook WHERE 1;
  DELETE FROM webhook_event_queue_item WHERE 1;
  DELETE FROM webhook_queue_item WHERE 1;

EOF




