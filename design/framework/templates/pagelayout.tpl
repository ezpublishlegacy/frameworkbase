<!DOCTYPE html>
<html lang="{$site.http_equiv.Content-language|wash()}" xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash()}">
{if not(is_set($extra_cache_key))}{def $extra_cache_key=''}{/if}
{def $pagedata=pagedata()}
{cache-block keys=array($module_result.uri, $is_basket_empty, $current_user.contentobject_id, $access_type.name, $extra_cache_key)}
<head>
{include uri="design:page_head.tpl" enable_link=false()}
{include uri="design:page/head_style.tpl"}
{include uri="design:page/head_script.tpl"}
</head>

<body class="{$site_classes|implode(' ')}">
	<div id="webpage">
		{include uri="design:page_header.tpl" logo_alt=$site.title|wash() logo_width=176 logo_height=36}
		{include uri="design:menu/globalmenubar.tpl"}
		<div id="site-columns">
			{if $website_toolbar}
				{debug-accumulator id="toolbar" name="Website Toolbar"}<div id="toolbar">{include uri='design:parts/website_toolbar.tpl'}</div>{/debug-accumulator}
			{/if}
			{if $pagedata.show_path}
				{include uri='design:page_toppath.tpl' delimiter='&raquo;'}
			{/if}
			{if $pagedata.has_sidebar}
				<aside id="sidebar" role="complementary">
					{if $pagedata.has_sidemenu}{include uri="design:menu/sidemenubar.tpl" show_header=false()}{/if}
					{if and(is_set($persistent_variable.sidebar), $persistent_variable.sidebar)}<div>{$persistent_variable.sidebar}</div>{/if}
					{if and($infoboxes, $infoboxes['left'])}{$infoboxes['left']}{/if}
				</aside>
			{/if}
			<{cond($pagedata.page_title, 'section', 'div')} id="site-main-content" class="{$content_classes|implode(' ')}">
			{if $pagedata.page_title}<header><h1>{$pagedata.page_title}</h1></header>{/if}
{/cache-block}
				{$module_result.content}
{cache-block keys=array($module_result.uri, $is_basket_empty, $current_user.contentobject_id, $access_type.name, $extra_cache_key)}
			</{cond($pagedata.page_title, 'section', 'div')}>
			{if $pagedata.has_extrainfo}
				<aside id="extrainfo" role="complementary">
					{if $pagedata.has_sidemenu}{include uri="design:menu/sidemenubar.tpl" show_header=false()}{/if}
					{if and(is_set($persistent_variable.extrainfo), $persistent_variable.extrainfo)}{$persistent_variable.extrainfo}{/if}
					{if and($infoboxes, $infoboxes['right'])}{$infoboxes['right']}{/if}
				</aside>
			{/if}
			{if and(is_set($persistent_variable.bottomarea), $persistent_variable.bottomarea)}
				<div id="bottomarea">{$persistent_variable.bottomarea}</div>
			{/if}
		</div>
		{include uri="design:page_footer.tpl"}
	</div>
	{* This comment will be replaced with actual debug report (if debug is on). *}
	<!--DEBUG_REPORT-->
</body>
{/cache-block}

</html>
{pagedata_exit()}