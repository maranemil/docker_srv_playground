<?php

/** The name of the database for WordPress */
define('DB_NAME', $_SERVER['DB_NAME'] ?? $_ENV['DB_NAME'] ?? null);
 
/** MySQL database username */
define('DB_USER', $_SERVER['DB_USER'] ?? $_ENV['DB_USER'] ?? null);
 
/** MySQL database password */
define('DB_PASSWORD', $_SERVER['DB_PASSWORD'] ?? $_ENV['DB_PASSWORD'] ?? null);
 
/** MySQL hostname */
define('DB_HOST', $_SERVER['DB_HOST'] ?? $_ENV['DB_HOST'] ?? null);
 
// ... later ...
 
define('WP_DEBUG', (bool) ($ENV['WP_DEBUG'] ?? false));
define('WP_DEBUG_LOG', (bool) ($ENV['WP_DEBUG'] ?? false));