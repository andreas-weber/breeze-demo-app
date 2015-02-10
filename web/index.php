<?php

use Silex\Application;
use Silex\Provider\MonologServiceProvider;

defined('BASEPATH')
|| define('BASEPATH', realpath(dirname(__FILE__) . '/../'));

require_once BASEPATH . '/vendor/autoload.php';

$app = new Application();

$app->register(new MonologServiceProvider(), array(
    'monolog.logfile' => '/var/log/breeze/application.log',
));

$app->get('/', function () use ($app) {
    $now = new DateTime();
    $now = $now->format('H:i:s');

    return 'Time: ' . $app->escape($now);
});

$app['monolog']->addInfo('Adding a monolog message for testing');

$app->run();
