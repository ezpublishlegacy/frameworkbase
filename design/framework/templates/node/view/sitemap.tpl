{def $pageLimit=ezini('SiteMapSettings', 'Limit', 'content.ini')
	 $subChildren=false()
	 $classFilterType = ezini('SiteMapSettings', 'ClassFilterType', 'content.ini')
	 $classFilterArray = ezini('SiteMapSettings', 'ClassFilter', 'content.ini')
	 $children=fetch('content', 'list', hash('parent_node_id', $node.node_id,
					'limit', $pageLimit,
					'offset', $view_parameters.offset,
					'class_filter_type', $classFilterType,
					'class_filter_array', $classFilterArray,
					'attribute_filter', array( 'and', array('section', '=', '1'), array('priority', 'between', array(1, 100)) ),
					'sort_by', $node.sort_array))
	 $colCount = ezini('SiteMapSettings', 'Columns', 'content.ini')|int()
	 $rowCount = ezini('SiteMapSettings', 'Rows', 'content.ini')|int()
	 $use=ezini('SiteMapSettings', 'UseCount', 'content.ini')
}

{if eq($use, 'columns')}
	{set $rowCount=ceil(div(count($children), $colCount))}
{elseif eq($use, 'rows')}
	{set $colCount=ceil(div(count($children), $rowCount))}
{/if}

<header><h1>{"Site Map"|i18n("design/ezwebin/view/sitemap")} {$node.name|wash()}</h1></header>
<div class="column">
{foreach $children as $key => $child}
  {if and( gt($key, 0), eq($key|mod($rowCount), 0) )}
</div>
<div class="column">
  {/if}
   <div class="sitemap-item">
	<h2><a href={$child|sitelink()}>{$child.name|wash()}</a></h2>
  {set $subChildren=fetch('content', 'list', hash('parent_node_id', $child.node_id,
						'limit', $pageLimit,
						'sort_by', cond($child|is('event_calendar'), array('attribute', false(), 'event/from_time'), $child.sort_array ),
						'class_filter_type', $classFilterType,
						'class_filter_array', $classFilterArray))
  }
  {if count($subChildren)}
	<ul>
     {foreach $subChildren as $subChild}
	  <li><a href={$subChild|sitelink()}>{$subChild.name|wash()}</a></li>
     {/foreach}
	</ul>
  {/if}
   </div>
{/foreach}
</div>