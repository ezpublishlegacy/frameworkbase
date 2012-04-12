{* Folder - Full view *}
{def $rssexport=rssexport($node.node_id)}

	{if count($rssexport)}<a class="rss" href="{concat('/rss/feed/', $rssexport.access_url)|ezroot('no')}" title="{$rssexport.title|wash()}"><img src="{'images/rss.png'|ezdesign('no')}" alt="{$rssexport.title|wash()}" /> Get the RSS Feed</a>{/if}

{if eq(ezini('folder', 'SummaryInFullView', 'content.ini'), 'enabled')}
	{if $node.data_map.short_description.has_content}<div class="attribute-xmlblock short-desription">{attribute_view_gui attribute=$node.data_map.short_description}</div>{/if}
{/if}

{if $node.data_map.description.has_content}
	<div class="attribute-xmlblock">{attribute_view_gui attribute=$node.data_map.description}</div>
{/if}

{if $node.data_map.show_children.data_int}
{def $page_limit = 10
	 $classes = ezini('MenuContentSettings', 'ExtraIdentifierList', 'menu.ini')
	 $children = array()
	 $children_count = ''
}

{set $classes = $classes|merge(ezini('ChildrenNodeList', 'ExcludedClasses', 'content.ini'))}

{set $children_count=fetch('content', 'list_count', hash(
		'parent_node_id', $node.node_id,
		'class_filter_type', 'exclude',
		'class_filter_array', $classes
	))
}
{if $children_count}
	<div class="content-view-children">
		{foreach fetch('content', 'list', hash('parent_node_id', $node.node_id, 'offset', $view_parameters.offset, 'sort_by', $node.sort_array, 'class_filter_type', 'exclude', 'class_filter_array', $classes, 'limit', $page_limit)) as $child}
			{node_view_gui view='line' content_node=$child}
			{delimiter}{include uri="design:content/datatype/view/ezxmltags/separator.tpl"}{/delimiter}
		{/foreach}
	</div>
{/if}

	{include
		name=navigator
		uri='design:navigator/google.tpl'
		page_uri=$node.url_alias
		item_count=$children_count
		view_parameters=$view_parameters
		item_limit=$page_limit
	}

{/if}