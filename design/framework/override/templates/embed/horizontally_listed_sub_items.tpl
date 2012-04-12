{def $limit=cond(is_set($object_parameters.limit), $object_parameters.limit, 3)
	 $offset=cond(is_set($object_parameters.offset), $object_parameters.offset, 0)
	 $children=fetch('content', 'list', hash(
		'parent_node_id', $object.main_node_id,
		'limit', $limit,
		'offset', $offset,
		'class_filter_type', 'exclude',
		'class_filter_array', ezini('MenuContentSettings', 'ExtraIdentifierList', 'menu.ini'),
		'sort_by', $object.main_node.sort_array
	))
}
<h2>{$object.name|wash()}</h2>
{if count($children)}
<div class="content-view-children">
	{foreach $children as $child}
		{node_view_gui view='horizontallylistedsubitems' content_node=$child}
	{/foreach}
</div>
{/if}