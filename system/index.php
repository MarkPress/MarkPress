<?php
error_reporting(E_ERROR | E_PARSE);
include 'vendor/autoload.php';
include 'functions.php';

$that = new stdClass;
# Defaults
$that->settings->content  = 'content';
$that->settings->theme    = 'default';
$that->settings->markdown = false;

$settings = parse_ini_file('settings.ini',1);
$that->settings = (object) array_merge((array)$that->settings, (array)$settings);

$subfolder = (in_array($_SERVER['HTTP_HOST'], array('localhost', '127.0.0.1'))) ? $that->settings->root : null;
$that->uri = new URI($subfolder);

$path = $that->settings->content.'/'.$that->uri->segment(1, 'index');
if ($that->uri->segment(2)) {
    $path .= '/'.$that->uri->segment(2);
}
$file = $path.'.md';

if(file_exists($file)) {
    $template = 'themes/'.$that->settings->theme.'/show_post.tpl';
    echo parse_file($file, $template);
} else {
    if(is_dir($path)) {
        $template = 'themes/'.$that->settings->theme.'/show_news.tpl';
        echo show_news('posts/'.$that->uri->segment(1), $template);
    } else {
        echo 'calling error<br>';
        $errorPage = $that->settings->content.'/404.md';
        if(file_exists($errorPage)) {
            include $errorPage;
        } else {
            echo '404 :: Not Found';
        }
    }
}
