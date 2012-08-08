{* List Sub Items - Custom Tag *}
{def $node = fetch('content','node',hash('node_id',$page|explode('://')[1]))
	 $ticker_limit=cond(eq($stylize,'ticker'),ezini('CustomAttribute_listsubitems_stylize','TickerLimit','ezoe_attributes.ini'),false())
	 $dataNodes = fetch('content', 'list', hash('parent_node_id',$node.node_id,
						'limit', first_set(cond($ticker_limit,$ticker_limit,$limit),3),
						'sort_by', $node.sort_array))
	 $has_header = and(is_set($header),ne($header,''))
	 $rssexport=rssexport($node.node_id)
}
{if array('event_calendar','multicalendar')|contains($node.class_identifier)}
{set $dataNodes=fetch('content', 'tree', hash('parent_node_id',$node.node_id,
						'limit', first_set(cond($ticker_limit,$ticker_limit,$limit),3),
						'sort_by', array('attribute',true(),'event/from_time'),
						'class_filter_type','include',
						'class_filter_array',array('event'),
						'attribute_filter',array(array('event/from_time','>=',currentdate()))
						))
}
{/if}
{if ne($stylize,'ticker')}
<section class="{if eq($stylize,'advanced')}advanced{/if}{if ne($stylize,'basic')} module{/if} customtag custom-tag-listsubitems">
	<header><h1>{if or($has_header, eq($stylize,'custom'))}{cond(eq($header,'$content'),$content,$header)}{else}{$node.name|wash()}{/if}</h1>{if count($rssexport)}<a class="rss" href="{concat('/rss/feed/', $rssexport.access_url)|ezroot('no')}" title="{$rssexport.title|wash()}"><img src="{'images/rss.png'|ezdesign('no')}" alt="{$rssexport.title|wash()}" /></a>{/if}</header>
	<section class="customtag-content view-item-list">
	{foreach $dataNodes as $subitem}
		{node_view_gui view=$children_view content_node=$subitem htmlshorten=cond(eq($children_view,'listitem'), array(80,concat('... <a href="',$subitem|sitelink('no'),'">More</a>')), false() )}
		{delimiter}{include uri="design:content/datatype/view/ezxmltags/separator.tpl"}{/delimiter}
	{/foreach}
{if ne($stylize,'basic')}
		{if is_set($alltext)}{if ne($alltext,'$none')}<a class="seeall" href={$node|sitelink()}>{$alltext}</a>{/if}{else}<a class="seeall" href={$node|sitelink()}>See All</a>{/if}
{/if}
	</section>
</section>

{else}
<section class="module customtag custom-tag-scrollable vertical">
	<header><h1>{if or($has_header, eq($stylize,'custom'))}{cond(eq($header,'$content'),$content,$header)}{else}{$node.name|wash()}{/if}</h1>{if count($rssexport)}<a class="rss" href="{concat('/rss/feed/', $rssexport.access_url)|ezroot('no')}" title="{$rssexport.title|wash()}"><img src="{'images/rss.png'|ezdesign('no')}" alt="{$rssexport.title|wash()}" /></a>{/if}</header>
	<section class="customtag-content">
		<a class="prev browse up"></a><hr class="line" />
			<div class="scrollable">
				<div class="items">
					<div>
						{foreach $dataNodes as $key=>$subitem}
							{if and(gt($key,1),lt($key,count($dataNodes)),eq(mod($key,$limit),0))}</div><div>{/if}
							{node_view_gui view=$children_view content_node=$subitem}
						{/foreach}
					</div>
				</div>
			</div>
		<a class="next browse down"></a><hr class='line' />
		{if is_set($alltext)}{if ne($alltext,'$none')}<a class="seeall" href={$node|sitelink()}>{$alltext}</a>{/if}{else}<a class="seeall" href={$node|sitelink()}>See All</a>{/if}
	</section>
</section>
{/if} 
