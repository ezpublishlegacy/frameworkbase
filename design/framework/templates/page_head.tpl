
<title>{$pagedata.title}</title>
<meta charset="utf-8" />

{if $site.redirect}<meta http-equiv="Refresh" content="{$site.redirect.timer}; URL={$site.redirect.location}" />{/if}

{foreach $site.meta as $key=>$item}
{if and(not($pagedata.is_error), array('description', 'keywords')|contains($key))}
{if and($pagedata.is_content, is_set($current_node.data_map[concat('meta_', $key)]), $current_node.data_map[concat('meta_', $key)].has_content)}
{set-block variable='item'}{attribute_view_gui attribute=$current_node.data_map[concat('meta_',$key)]}{/set-block}
{/if}
{/if}
<meta name="{$key|wash()}" content="{$item|wash()|trim()}" />

{/foreach}
<meta name="MSSmartTagsPreventParsing" content="TRUE" />
<meta name="generator" content="eZ Publish" />

{if $pagedata.is_content}<link rel="canonical" href={$current_node.object.main_node|sitelink(, true())} />{/if}

{if first_set($enable_link, true())}{include uri="design:link.tpl" enable_help=first_set($enable_help, true()) enable_link=first_set($enable_link, true())}{/if}
