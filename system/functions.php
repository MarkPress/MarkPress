<?php
use Ciconia\Extension\Gfm;

function to_obj($input) {
    return json_decode(json_encode($input));
}

function FolderName($input) {

    if( $input[0] == '/' ) {
        $input = substr($input, 1);
    }

    if( substr($input, -1) == '/' ) {
        $input = substr($input, 0, -1);
    }

    return $input;
}

function AddPort($port) {
    if( !empty($port) ) {
        return ':'.$port;
    } else {
        return '';
    }
}

function server_url($root='') {
    $server_name = $_SERVER['SERVER_NAME'];
    $port = (!empty($_SERVER['SERVER_PORT']) ? $_SERVER['SERVER_PORT']: '');
    if (!empty($_SERVER['HTTPS']) && (strtolower($_SERVER['HTTPS']) == 'on' || $_SERVER['HTTPS'] == '1')) {
        $scheme = 'https';
    } else {
        $scheme = 'http';
    }
    return $scheme.'://'.$server_name.AddPort($port).'/'.$root;
}

function debug($data,$return=false) {
    if($return) {
        return '<pre>'.print_r($data,1).'</pre>';
    }
    echo '<pre>'.print_r($data,1).'</pre>';
}

function MarkDown($input,$type=false) {
    $ciconia = new \Ciconia\Ciconia();
    if(strtolower($type) == 'mfm') {
        $ciconia->addExtension(new Gfm\FencedCodeBlockExtension());
        $ciconia->addExtension(new Gfm\TaskListExtension());
        $ciconia->addExtension(new Gfm\InlineStyleExtension());
        $ciconia->addExtension(new Gfm\WhiteSpaceExtension());
        $ciconia->addExtension(new Gfm\TableExtension());
    }
    if(strtolower($type) == 'gfm') {
        $ciconia->addExtension(new Gfm\FencedCodeBlockExtension());
        $ciconia->addExtension(new Gfm\TaskListExtension());
        $ciconia->addExtension(new Gfm\InlineStyleExtension());
        $ciconia->addExtension(new Gfm\WhiteSpaceExtension());
        $ciconia->addExtension(new Gfm\TableExtension());
        $ciconia->addExtension(new Gfm\UrlAutoLinkExtension());
    }
    $content = $ciconia->render($input);
    return $content;
}
function view($template,$data,$settings=array('autoescape'=>false,'debug'=>false)) {
    $loader = new Twig_Loader_Filesystem('./');
    $twig = new Twig_Environment($loader, $settings);
    $twig->addFunction(new Twig_SimpleFunction('file_exists', 'file_exists'));

    return $twig->render($template, $data);
}

function parse_file($file, $template) {
    global $that;

    $page = new FrontMatter($file);
    $markdown = ($that->settings->markdown) ? $that->settings->markdown : false;
    $page->data['content'] = MarkDown($page->data['content'], $markdown);
    $data = $page->data;

    $data['post']     = $page->data;
    $data = setData($data);
    echo view($template, $data);
}

function show_news($folder='posts',$template='templates/show_news.tpl') {
    global $that;
    $files = glob("$folder/*.md");
    $html = '';
    foreach($files as $file) {
        $page  = new FrontMatter($file);
        if($page->data['route'] == '') {
            $route = $that->uri->segment(1, $that->settings->homepage).'/'.substr($file, strlen($folder)+1, -3);
        } else {
            $route = $page->data['route'];
        }
        $markdown = ($that->settings->markdown) ? $that->settings->markdown : false;
        $page->data['content'] = MarkDown($page->data['content'], $markdown);
        $page->data['route'] = $route;
        $data[] = $page->data;
    }
    function date_compare($a, $b) {
        $t1 = strtotime($a['date']);
        $t2 = strtotime($b['date']);
        return $t1 - $t2;
    }
    usort($data, 'date_compare');
    $data = array_reverse($data);

    $data['posts']    = $data;
    $data['uri']      = substr($that->uri->uri_string,1);
    $data['uri']      = $that->path;
    $data = setData($data);
    echo view($template, $data);
}

function setData($data) {
    global $that;
    $data['pages']    = $that->pages;
    $data['settings'] = $that->settings;
    $data['base']     = server_url(FolderName($that->settings->root));
    $data['theme']    = $data['base'].'/themes/'.$that->settings->theme;
    $data['css']      = $data['theme'].'/css';
    $data['js']       = $data['theme'].'/js';
    return $data;
}
