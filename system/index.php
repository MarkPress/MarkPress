<?php
error_reporting(E_ERROR | E_PARSE);
include 'vendor/autoload.php';
include 'functions.php';

$that = new stdClass;
# Defaults
$that->settings->homepage = 'index';
$that->settings->content  = 'posts';
$that->settings->theme    = 'default';
$that->settings->markdown = 'gfm';

use Symfony\Component\Yaml\Yaml;
$settings = Yaml::parse(file_get_contents('settings.yaml'));
$that->settings = (object) array_merge((array)$that->settings, (array)$settings);

$subfolder = (in_array($_SERVER['HTTP_HOST'], array('localhost', '127.0.0.1'))) ? $that->settings->root : null;
$that->uri = new URI($subfolder);

$path = $that->settings->content.'/'.$that->uri->segment(1, $that->settings->homepage);
$that->path = $that->uri->segment(1, $that->settings->homepage);
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
        echo show_news($path, $template);
    } else {
        $data = array();
        $data['pages']    = $that->pages;
        $data['settings'] = $that->settings;
        $data['base']     = 'http://'.$_SERVER['SERVER_NAME'].$that->settings->root;
        $data['theme']    = $data['base'].'/themes/'.$that->settings->theme;
        $data['css']      = $data['theme'].'/css';
        $data['js']       = $data['theme'].'/js';
        echo view('themes/'.$that->settings->theme.'/404.tpl', $data);
    }
}
