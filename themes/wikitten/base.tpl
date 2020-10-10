<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>{% block title %}{% endblock %}</title> <!-- --
        <base href="{{ base }}/"> <!-- --
        <link rel="shortcut icon" href="{{theme}}/static/img/favicon.ico"> <!-- -->
        <link rel="stylesheet" href="{{theme}}/static/css/bootstrap.min.css"> <!-- -->
        <link rel="stylesheet" href="{{theme}}/static/css/prettify.css">
        <link rel="stylesheet" href="{{theme}}/static/css/codemirror.css">
        <link rel="stylesheet" href="{{theme}}/static/css/main.css">
        <link rel="stylesheet" href="{{theme}}/static/css/custom.css">
{% if settings.description %}
        <meta name="description" content="{{ settings.description }}">
{% endif %}
{% if settings.keywords %}
        <meta name="keywords" content="{{ settings.keywords }}">
{% endif %}
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
{% if settings.author %}
        <meta name="author" content="{{ settings.author }}">
{% endif %}

        <script src="{{theme}}/static/js/jquery.min.js"></script>
        <script src="{{theme}}/static/js/prettify.js"></script><!-- --
        <script src="{{theme}}/static/js/codemirror.min.js"></script><!-- -->
    </head>
<body>
    <div id="main">
        <div class="inner">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-12 col-md-3">
                        <div id="sidebar">
                            <div class="inner">
                                <h2><span>{{ settings.sitename }}</span></h2>
<!-- --
<div id="tree-filter" class="input-group">
    <input type="text" id="tree-filter-query" placeholder="Search file &amp; directory names." class="form-control input-sm">
    <a id="tree-filter-clear-query" title="Clear current search..." class="input-group-addon input-sm">
        <i class="glyphicon glyphicon-remove"></i>
    </a>
</div>
<!-- -->
<ul class="unstyled" id="tree-filter-results"></ul>

<ul class="unstyled" id="tree">
    <li class="directory">
        <a href="#" data-role="directory"><i class="glyphicon glyphicon-folder-close"></i>&nbsp; code snippets (expand me!)</a><ul class="unstyled" id="tree">
        <li class="file">
            <a href="{{ base }}/code snippets (expand me!)/Bash.sh">Bash.sh</a>
        </li>
        <li class="file">
            <a href="{{ base }}/code snippets (expand me!)/CSS.css">CSS.css</a></li>
            <li class="file"><a href="{{ base }}/code snippets (expand me!)/JavaScript.js">JavaScript.js</a></li><li class="file"><a href="{{ base }}/code snippets (expand me!)/PHP.php">PHP.php</a></li>
            <li class="file"><a href="{{ base }}/code snippets (expand me!)/Python.py">Python.py</a></li>
            <li class="file"><a href="{{ base }}/code snippets (expand me!)/Ruby.rb">Ruby.rb</a></li>
            <li class="file"><a href="{{ base }}/code snippets (expand me!)/Scheme.scm">Scheme.scm</a></li>
            <li class="file"><a href="{{ base }}/code snippets (expand me!)/SQL.sql">SQL.sql</a></li>
            <li class="file"><a href="{{ base }}/code snippets (expand me!)/XML.xml">XML.xml</a></li>
        </ul>
    </li>
    <li class="directory">
        <a href="#" data-role="directory">
            <i class="glyphicon glyphicon-folder-close"></i> you can also
        </a>
        <ul class="unstyled" id="tree">
            <li class="directory">
                <a href="#" data-role="directory"><i class="glyphicon glyphicon-folder-close"></i> nest directories</a>
                <ul class="unstyled" id="tree">
                    <li class="file">
                        <a href="{{ base }}/you can also/nest directories/binary files are OK too.jpg">
                            binary files are OK too.jpg
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </li>
    <li class="file active"><a href="{{ base }}/index.md">index.md</a></li>
    <li class="file"><a href="{{ base }}/Sample HTML document.html">Sample HTML document.html</a></li>
    <li class="file"><a href="{{ base }}/Sample Markdown document.md">Sample Markdown document.md</a></li>
</ul>
<script>
    // Case-insensitive alternative to :contains():
    // All credit to Mina Gabriel:
    // http://stackoverflow.com/a/15033857/443373
    $.expr[':'].containsIgnoreCase = function (n, i, m) {
        return jQuery(n).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
    };

    $(document).ready(function() {
        var iconFolderOpenClass  = 'glyphicon glyphicon-folder-open',
            iconFolderCloseClass = 'glyphicon glyphicon-folder-close',

            // Handle live search/filtering:
            tree             = $('#tree'),
            resultsTree      = $('#tree-filter-results')
            filterInput      = $('#tree-filter-query'),
            clearFilterInput = $('#tree-filter-clear-query')
        ;

        // Auto-focus the search field:
        filterInput.focus();

        // Cancels a filtering action and puts everything back
        // in its place:
        function cancelFilterAction()
        {
            filterInput.val('').removeClass('active');
            resultsTree.empty();
            tree.show();
        }

        // Clear the filter input when the X to its right is clicked:
        clearFilterInput.click(cancelFilterAction);

        // Same thing if the user presses ESC and the filter is active:
        $(document).keyup(function(e) {
            e.keyCode == 27 && filterInput.hasClass('active') && cancelFilterAction();
        });

        // Perform live searches as the user types:
        // @todo: check support for 'input' event across more browsers?
        filterInput.bind('input', function() {
            var value         = filterInput.val(),
                query         = $.trim(value),
                isActive      = value != ''
            ;

            // Add a visual cue to show that the filter function is active:
            filterInput.toggleClass('active', isActive);

            // If we have no query, cleanup and bail out:
            if(!isActive) {
                cancelFilterAction();
                return;
            }

            // Hide the actual tree before displaying the fake results tree:
            if(tree.is(':visible')) {
                tree.hide();
            }

            // Sanitize the search query so it won't so easily break
            // the :contains operator:
            query = query
                        .replace(/\(/g, '\\(')
                        .replace(/\)/g, '\\)')
                    ;

            // Get all nodes containing the search query (searches for all a, and returns
            // their parent nodes <li>).
            resultsTree.html(tree.find('a:containsIgnoreCase(' + query + ')').parent().clone());
        });

        // Handle directory-tree expansion:
        $(document).on('click', '#sidebar a[data-role="directory"]', function (event) {
            event.preventDefault();

            var icon = $(this).children('.glyphicon');
            var open = icon.hasClass(iconFolderOpenClass);
            var subtree = $(this).siblings('ul')[0];

            icon.removeClass(iconFolderOpenClass).removeClass(iconFolderCloseClass);

            if (open) {
                if (typeof subtree != 'undefined') {
                    $(subtree).slideUp({ duration: 100 });
                }
                icon.addClass(iconFolderCloseClass);
            } else {
                if (typeof subtree != 'undefined') {
                    $(subtree).slideDown({ duration: 100 });
                }
                icon.addClass(iconFolderOpenClass);
            }
        });
    });
</script>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-9">
                        <div id="content">
                            <div class="inner">
                                <div class="breadcrumbs">
                                    <ul class="breadcrumb">
                                        <li>
                                            <a href="{{ base }}/"><i class="glyphicon glyphicon-home glyphicon-white"></i> /wiki</a>
                                        </li>
                                        <li>
                                            <a href="{{ base }}/index.md"><i class="glyphicon glyphicon-file glyphicon-white"></i>index.md</a>
                                        </li>
                                    </ul>
                                </div>

    <div id="render">
        {% block content %}{% endblock %}
        <div style="clear:both"></div>
    </div>
    <script>
        $('#render pre').addClass('prettyprint linenums');
        prettyPrint();

        $('#render a[href^="#"]').click(function(event) {
            event.preventDefault();
            document.location.hash = $(this).attr('href').replace('#', '');
        });
    </script>

    <script>
        CodeMirror.defineInitHook(function () {
            $('#source').hide();
        });

        var mode = false;
        var modes = {
            'md': 'markdown',
            'js': 'javascript',
            'php': 'php',
            'sql': 'text/x-sql',
            'py': 'python',
            'scm': 'scheme',
            'clj': 'clojure',
            'rb': 'ruby',
            'css': 'css',
            'hs': 'haskell',
            'lsh': 'haskell',
            'pl': 'perl',
            'r': 'r',
            'scss': 'sass',
            'sh': 'shell',
            'xml': 'xml',
            'html': 'htmlmixed',
            'htm': 'htmlmixed'
        };
        var extension = 'md';
        if (typeof modes[extension] != 'undefined') {
            mode = modes[extension];
        }

        var editor = CodeMirror.fromTextArea(document.getElementById('editor'), {
            lineNumbers: true,
            lineWrapping: true,
                        theme: 'default',
                        mode: mode
                        ,readOnly: true
                    });

        $('#toggle').click(function (event) {
            event.preventDefault();
            $('#render').toggle();
            $('#source').toggle();
            if ($('#source').is(':visible')) {
                editor.refresh();
            }

        });

            </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
