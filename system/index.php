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
if(!empty($that->settings->timezone)) {
    date_default_timezone_set($that->settings->timezone);
}

$subfolder = null;
$subfolder = ($that->settings->root != '/') ? $that->settings->root : $subfolder;
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
        echo show_news($path, $template, $data);
    } else {
        $data = array();
        $data = setData($data);
        echo view('themes/'.$that->settings->theme.'/404.tpl', $data);
    }
}
