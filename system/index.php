<?php
if($debug) { error_reporting(E_ERROR | E_PARSE); }
include 'vendor/autoload.php';
include 'functions.php';

$that['pages'] = [];
$that['settings'] = [];
/**/
# Defaults
$that['settings']['homepage'] = 'index';
$that['settings']['content']  = 'posts';
$that['settings']['theme']    = 'default';
$that['settings']['markdown'] = 'gfm';

# Overwrite with information from Settings file
use Symfony\Component\Yaml\Yaml;
$settings = Yaml::parse(file_get_contents('settings.yaml'));
$that['settings'] = array_merge($that['settings'], $settings);
if(!empty($that['settings']['timezone'])) {
    date_default_timezone_set($that['settings']['timezone']);
}

# Overwrite settings with custom variables set by user
if(!empty($_GET['theme'])) {
    if (is_dir('themes/'.$_GET['theme'])) {
        $theme_is = $_GET['theme'];
    } else {
        $theme_is = $that['settings']['theme'];
    }
    $that['settings']['theme'] = $theme_is;
}
/**/
$subfolder = null;
$subfolder = ($that['settings']['root'] != '/') ? $that['settings']['root'] : $subfolder;
$that['uri'] = new URI(remove_trailing($subfolder));
/**/

/* 
 * 
 */
$total_segments = $that['uri']->total_segments();
if($_SERVER['REQUEST_URI'] == $that['settings']['root']) {
    $template = 'show_post.tpl';
} else {
    if( is_dir_path($_SERVER['REQUEST_URI']) ) {
        $template = 'show_news.tpl';
    } else {
        $template = 'show_post.tpl';
    }
}
if($debug) { echo $template.'<br>'; }
$template = 'themes/'.$that['settings']['theme'].'/'.$template;

$loop_segments = $total_segments;
$loop_segments = is_dir_path($_SERVER['REQUEST_URI']) ? $total_segments-1 : $total_segments;
$seperator = '';
// Set Default Path Start
$path = trailing($that['settings']['content']);

for($segment = 1; $segment <= $loop_segments; $segment++) {
    if($debug) {
        echo $segment . ': ' . $that['uri']->segment($segment).'<br>';
    }
    $seperator = ($segment == $loop_segments) ? '' : '/';
    $path .=  $that['uri']->segment($segment).$seperator;
}
/**/
function is_dir_path_or_homepage($path, $homepage='') {
    if($path == $homepage) {
        return true;
    } else {
        return is_dir_path($path) ? true : false;
    }
}
function is_dir_path_not_homepage($path, $homepage='') {
    if($path != $homepage) {
        if( is_dir_path($path) ) {
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}
/**/
if($_SERVER['REQUEST_URI'] == $that['settings']['root']) {
    $file = $path.$that['settings']['homepage'].'.md';
} else {
    if(is_dir_path($_SERVER['REQUEST_URI'])) {
        $file = $path.'/';
    } else {
        $file = $path.'.md';
    }
}
/**/
if($debug) {
    echo '<br> file: ' . $file.'<br>';

    # echo $this_is_dir.'<br>';
    echo '<br> total: ' . $total_segments.'<br>';
    # die();
}
/**/
# Check if Path is NOT a Directory (according to URL)
if($_SERVER['REQUEST_URI'] == $that['settings']['root']) {
    if($debug) { echo 'IS HOMEPAGE<br>'; }
    echo parse_file($file, $template);
} else {
    if(!is_dir_path($_SERVER['REQUEST_URI'])) {
        if($debug) { echo 'REQUEST URI: IS NOT DIRECTORY<br>'; }
        # Check if file exists
        if(file_exists($file)) {
            if($debug) { echo 'FILE EXISTS: IS FILE<br>'; }
            # If So return File with Post Template
            // $template = 'themes/'.$that['settings']['theme'].'/show_post.tpl';
            echo parse_file($file, $template);
        } else {
            if($debug) { echo 'FILE EXISTS: IS NOT FILE<br>'; }
            # If not return error template
            $data = array();
            $data = setData($data);
            echo view('themes/'.$that['settings']['theme'].'/404.tpl', $data);
        }
    } else { # Path IS a Directory (according to URL)
        if($debug) { echo 'REQUEST URI: IS DIRECTORY<br>'; }
        # Check if path is actually a real directory on the disk
        if(is_dir($path)) {
            if($debug) { echo 'IS DIR: IS DIR<br>'; }
            # If So return File with Directory / Archive Template
            // $template = 'themes/'.$that['settings']['theme'].'/show_news.tpl';
            echo show_news($path, $template, $data);
        } else {
            if($debug) { echo 'IS DIR: IS NOT DIR<br>'; }
            # If not return error template
            $data = array();
            $data = setData($data);
            echo view('themes/'.$that['settings']['theme'].'/404.tpl', $data);
        }
    }
}
/**/
