{def $limit=cond(is_set($object_parameters.limit), $object_parameters.limit, 3)
	 $offset=cond(is_set($object_parameters.offset), $object_parameters.offset, 0)
	 $children=fetch('content', 'list', hash(
		'parent_node_id', $object.main_node_id,
		'limit', $limit,
		'offset', $offset,
		'sort_by', $object.main_node.sort_array
	))
}
{if count($children)}
<div class="content-view-children">
	{foreach $children as $child}
		{node_view_gui view='line' content_node=$child}
		{delimiter}{include uri='design:content/datatype/view/ezxmltags/separator.tpl'}{/delimiter}
	{/foreach}
</div>
{/if}