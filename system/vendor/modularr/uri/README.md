# URI Class

[![Latest Version](http://img.shields.io/packagist/v/modularr/uri.svg?style=flat)](https://packagist.org/packages/Modularr/uri)
[![Software License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Total Downloads](https://img.shields.io/packagist/dt/modularr/uri.svg?style=flat)](https://packagist.org/packages/Modularr/uri)

The URI Class provides functions that help you retrieve information from your URI strings. If you use URI routing, you can also retrieve information about the re-routed segments.

This is a library similar to [CodeIgniter](http://www.codeigniter.com) [URI Class](http://www.codeigniter.com/userguide2/libraries/uri.html), simply Instantiate the Class.

#### Install & Usage

`composer require modularr/uri`
```php
$uri = new URI('/folder_path');
```

## $uri = new URI($folder=null);

Folder is optional, but necessary if your project is in a subfolder.

## $uri->segment(n)

Permits you to retrieve a specific segment. Where n is the segment number you wish to retrieve. Segments are numbered from left to right. For example, if your full URL is this:

The segment numbers would be this:

`http://example.com/index.php/news/local/metro/crime_is_up`

1. news
2. local
3. metro
4. crime_is_up

By default the function returns FALSE (boolean) if the segment does not exist. There is an optional second parameter that permits you to set your own default value if the segment is missing. For example, this would tell the function to return the number zero in the event of failure:

```php
$product_id = $uri->segment(3, 0);
```
It helps avoid having to write code like this:
```php
if (empty($uri->segment(3)))
{
    $product_id = 0; # if segment is empty
}
else
{
    $product_id = $uri->segment(3); # get the segment
}
```

## $uri->uri_string()

Returns a string with the complete URI. For example, if this is your full URL:

`http://example.com/index.php/news/local/345`

The function would return this:

`/news/local/345`

## $uri->total_segments()

Returns the total number of segments.
