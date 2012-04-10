{def $related_content=fetch('ezfind', 'moreLikeThis', hash('query_type', 'nid',
														'query', $node.node_id,
														'subtree_array', array(2),
														'limit', 5,
														'class_filter_type', 'exclude',
														'class_filter_array', array('image', 'banner', 'infobox')
))
}
{set $related_content=$related_content['SearchResult']}
{include uri="design:parts/display_related_content.tpl"}