{def $kewords=ezkeywordlist('blog_post', $used_node.node_id)
	 $archived=ezarchive('blog_post', $used_node.node_id)
}
{if $used_node.data_map.description.has_content}
{set-block variable='description'}{attribute_view_gui attribute=$used_node.data_map.description}{/set-block}
{include uri="design:content/datatype/view/ezxmltags/contentbox.tpl" content=$description display_type='infobox'}
{/if}

{set-block variable='calendar'}
{include
	uri='design:parts/calendar.tpl'
	class_identifier='blog_post'
	parameters=hash(
		'sort_by', array('attribute', true(), 'blog_post/publication_date'),
		'class_filter_type', 'include',
		'class_filter_array', array('blog_post'),
		'main_node_only', true()
		)
	attributes=hash('items', hash('from', 'publication_date'))
}
{/set-block}
{include uri="design:content/datatype/view/ezxmltags/contentbox.tpl" content=$calendar display_type='infobox' class=array('calendar')}

{if count($kewords)}
{set-block variable='kewords'}
{if first_set($tag_cloud, false())}	<p>{eztagcloud( hash( 'class_identifier', 'blog_post', 'parent_node_id', $used_node.node_id ) )}</p>{/if}
	<ul>
	{foreach $kewords as $keyword}
		<li><a href={concat( $used_node.url_alias, "/(tag)/", $keyword.keyword|rawurlencode )|sitelink()} title="{$keyword.keyword}">{$keyword.keyword} ({fetch( 'content', 'keyword_count', hash( 'alphabet', $keyword.keyword, 'classid', 'blog_post', 'parent_node_id', $used_node.node_id ) )})</a></li>
	{/foreach}
	</ul>
{/set-block}
{include uri="design:content/datatype/view/ezxmltags/contentbox.tpl" content=$kewords header='Tags' display_type='infobox'}
{/if}

{if count($archived)}
{set-block variable='archive'}
<ul>
{foreach $archived as $archive}
	<li><a href={concat( $used_node.url_alias, "/(month)/", $archive.month, "/(year)/", $archive.year )|sitelink()} title="">{$archive.timestamp|datetime( 'custom', '%F %Y' )}</a></li>
{/foreach}
</ul>
{/set-block}
{include uri="design:content/datatype/view/ezxmltags/contentbox.tpl" content=$archive header='Archive' display_type='infobox'}
{/if}
