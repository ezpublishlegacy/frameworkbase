{* Blog - Full view *}
{def $page_limit = 10
	 $blogs_count = 0
	 $uniq_id = 0
	 $uniq_post = array()
}
{if first_set($view_parameters.tag,false())}
	{set $blogs_count = fetch('content','keyword_count',hash('alphabet',rawurldecode($view_parameters.tag),
															'classid','blog_post',
															'parent_node_id',$node.node_id))}
	{if $blogs_count}
		{foreach fetch('content','keyword',hash('alphabet',rawurldecode($view_parameters.tag),
												'classid','blog_post',
												'parent_node_id',$node.node_id,
												'offset',$view_parameters.offset,
												'sort_by',array('attribute',false(),'blog_post/publication_date'),
												'limit',$page_limit)) as $blog}
			{set $uniq_id = $blog.link_object.node_id}
			{if $uniq_post|contains($uniq_id)|not}
				{node_view_gui view=line content_node=$blog.link_object}
				{set $uniq_post = $uniq_post|append($uniq_id)}
			{/if}
		{/foreach}
	{/if}
{else}
	{if and($view_parameters.month,$view_parameters.year)}
		{def $start_date = maketime(0,0,0,$view_parameters.month,cond(ne($view_parameters.day ,''),$view_parameters.day,'01'),$view_parameters.year)
			 $end_date = maketime(23,59,59,$view_parameters.month,cond(ne($view_parameters.day ,''),$view_parameters.day,makedate($view_parameters.month,'01',$view_parameters.year)|datetime('custom','%t')),$view_parameters.year)}

		{set $blogs_count = fetch('content','list_count',hash('parent_node_id',$node.node_id,
																'attribute_filter',array(and,
																		array('blog_post/publication_date','>=',$start_date),
																		array('blog_post/publication_date','<=',$end_date))))}
		{if $blogs_count}
			{foreach fetch('content','list',hash('parent_node_id',$node.node_id,
												'offset',$view_parameters.offset,
												'attribute_filter',array(and,
																			array('blog_post/publication_date','>=',$start_date),
																			array('blog_post/publication_date','<=',$end_date)),
												'sort_by',array('attribute',false(),'blog_post/publication_date'),
												'limit',$page_limit)) as $blog}
				{node_view_gui view=line content_node=$blog}
			{/foreach}
		{/if}
	{else}
		{set $blogs_count = fetch('content','list_count',hash('parent_node_id',$node.node_id))}
		{if $blogs_count}
			{foreach fetch('content','list',hash('parent_node_id',$node.node_id,
													'offset',$view_parameters.offset,
													'sort_by',array('attribute',false(),'blog_post/publication_date'),
													'limit',$page_limit)) as $blog}
				{node_view_gui view=line content_node=$blog}
			{/foreach}
		{/if}
	{/if}
{/if}
		{include name=navigator
				uri='design:navigator/google.tpl'
				page_uri=$node.url_alias
				item_count=$blogs_count
				view_parameters=$view_parameters
				item_limit=$page_limit}
		{set-block variable='extrainfo'}
			{include uri='design:parts/blog/extra_info.tpl' used_node=$node display_type='infobox'}
		{/set-block}
		{pagedata_set('extrainfo',$extrainfo)}
{undef}