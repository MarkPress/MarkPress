{% set code = '404' %}
{% set status = 'page not found' %}
{% set message = "The page you are looking for was moved, removed, renamed or might never existed." %}
<html>
<head>
<style>
html{
}
body{
    margin: 0;
    padding: 0;
    background: #e7ecf0;
    font-family: Arial, Helvetica, sans-serif;
}
*{
    margin: 0;
    padding: 0;
}
p{
    font-size: 12px;
    color: #373737;
    font-family: Arial, Helvetica, sans-serif;
    line-height: 18px;
}
p a{
    color: #218bdc;
    font-size: 12px;
    text-decoration: none;
}
a{
    outline: none;
}
.f-left{
    float:left;
}
.f-right{
    float:right;
}
.clear{
    clear: both;
    overflow: hidden;
}
#block_error{
    width: 845px;
    height: 384px;
    border: 1px solid #cccccc;
    margin: 72px auto 0;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;
    border-radius: 4px;
    background: #fff url({{ theme }}/img/block.gif) no-repeat 0 51px;
}
#block_error div{
    padding: 100px 40px 0 186px;
}
#block_error div h2{
    color: #218bdc;
    font-size: 24px;
    display: block;
    padding: 0 0 14px 0;
    border-bottom: 1px solid #cccccc;
    margin-bottom: 12px;
    font-weight: normal;
}
</style>
</head>
<body marginwidth="0" marginheight="0">
    <div id="block_error">
        <div>
         <h2>Error {{ code }}. &nbspOops you've have encountered an error</h2>
        <p>It appears that Either something went wrong or the page doesn't exist anymore..<br />
        This website is temporarily unable to service your request as it has exceeded it’s resource limit. Please check back shortly.</p>
        </div>
    </div>
</body>
</html>
