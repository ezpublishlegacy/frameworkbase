<!DOCTYPE html>
<html lang="{$site.http_equiv.Content-language|wash()}" xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash()}">

<head>
{include uri="design:page_head.tpl" enable_link=false()}
{include uri="design:page/head_style.tpl"}
{include uri="design:page/head_script.tpl"}
</head>

<body>
{$module_result.content}
{kill_debug()}
</body>

</html>