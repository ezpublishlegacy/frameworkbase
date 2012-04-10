{set-block scope=root variable=cache_ttl}0{/set-block}

{def $search=false()}
{if $use_template_search}
	{set $page_limit=10}
	{def $activeFacetParameters = array()}
	{if ezhttp_hasvariable('activeFacets', 'get')}
		{set $activeFacetParameters = ezhttp('activeFacets', 'get')}
	{/if}
	{def $dateFilter=0}
	{if ezhttp_hasvariable('dateFilter', 'get')}
		{set $dateFilter = ezhttp('dateFilter', 'get')}
		{switch match=$dateFilter}
		{case match=1}
			{def $dateFilterLabel="Last day"|i18n("design/standard/content/search")}
		{/case}
		{case match=2}
			{def $dateFilterLabel="Last week"|i18n("design/standard/content/search")}
		{/case}
		{case match=3}
			{def $dateFilterLabel="Last month"|i18n("design/standard/content/search")}
		{/case}
		{case match=4}
			{def $dateFilterLabel="Last three months"|i18n("design/standard/content/search")}
		{/case}
		{case match=5}
			{def $dateFilterLabel="Last year"|i18n("design/standard/content/search")}
		{/case}			
		{/switch}	
	{/if}
	{def $filterParameters = fetch('ezfind', 'filterParameters')
		$defaultSearchFacets = fetch('ezfind', 'getDefaultSearchFacets')}
	{* def $facetParameters=$defaultSearchFacets|array_merge_recursive($activeFacetParameters) *}
	{set $search=fetch('ezfind', 'search', hash(
							'query', $search_text,
							'offset', $view_parameters.offset,
							'limit', $page_limit,
							'sort_by', hash('score', 'desc'),
							'facet', $defaultSearchFacets,
							'filter', $filterParameters,
							'publish_date', $dateFilter,
							'spell_check', array(true()),
							'subtree_array', cond(ezhttp_hasvariable('SubTreeArray', 'get'), array(ezhttp('SubTreeArray', 'get')), false())
							))}
	{set $search_result=$search['SearchResult']}
	{set $search_count=$search['SearchCount']}
	{def $search_extras=$search['SearchExtras']}
	{set $stop_word_array=$search['StopWordArray']}
	{set $search_data=$search}
	{*debug-log var=$search_extras.facet_fields msg='$search_extras.facet_fields'*}
{/if}
{def $baseURI=concat('/content/search?SearchText=', $search_text)}

{* Build the URI suffix, used throughout all URL generations in this page *}
{def $uriSuffix = ''}
{foreach $activeFacetParameters as $facetField => $facetValue}
	{set $uriSuffix = concat($uriSuffix, '&activeFacets[', $facetField, ']=', $facetValue)}
{/foreach}

{foreach $filterParameters as $name => $value}
	{set $uriSuffix = concat($uriSuffix, '&filter[]=', $name, ':', $value)}
{/foreach}

{if gt($dateFilter, 0)}
	{set $uriSuffix = concat($uriSuffix, '&dateFilter=', $dateFilter)}
{/if}

{literal}
<script type="text/javascript">
	// toggle block
	function ezfToggleBlock(id){
		var value=(document.getElementById(id).style.display=='none')?'block':'none';
		ezfSetBlock(id, value);
		ezfSetCookie(id, value);
	}
	function ezfSetBlock(id, value){
		var el=document.getElementById(id);
		if(el!=null){
			el.style.display=value;
		}
	}
	function ezfTrim(str){
		return str.replace(/^\s+|\s+$/g, '') ;
	}
	function ezfGetCookie(name){
		var cookieName='eZFind_' + name;
		var cookie=document.cookie;
		var cookieList=cookie.split(";");
			for(var idx in cookieList){
				cookie=cookieList[idx].split("=");
				if(ezfTrim(cookie[0]) == cookieName){
					return(cookie[1]);
				}
			}
		return 'none';
	}
	function ezfSetCookie(name, value){
		var cookieName='eZFind_'+name;
		var expires=new Date();
		expires.setTime(expires.getTime()+(365*24*60*60*1000));
		document.cookie = cookieName+"="+value+"; expires="+expires+";";
	}
</script>
{/literal}

<div class="content-search search-results">
	<div class="lineitem_controls">
		<div class="pager">
			 {include name=Navigator
				uri='design:navigator/google.tpl'
				page_uri='/content/search'
				page_uri_suffix=concat('?SearchText=', $search_text|urlencode, $search_timestamp|gt(0)|choose('', concat('&SearchTimestamp=', $search_timestamp)), $uriSuffix)
				item_count=$search_count
				view_parameters=$view_parameters
				item_limit=$page_limit}
		</div>
	</div>
	{foreach $search_result as $result sequence array('bglight', 'bgdark') as $bgColor}
		{node_view_gui view='ezfind_line' bgColor=$bgColor use_url_translation=first_set($use_url_translation, false()) content_node=$result}
	{/foreach}
	<div class="lineitem_controls">
		<div class="pager">
		{include name=Navigator
			uri='design:navigator/google.tpl'
			page_uri='/content/search'
			page_uri_suffix=concat('?SearchText=', $search_text|urlencode, $search_timestamp|gt(0)|choose('', concat('&SearchTimestamp=', $search_timestamp)), $uriSuffix)
			item_count=$search_count
			view_parameters=$view_parameters
			item_limit=$page_limit}
		</div>
	</div>
</div>

{set-block variable='searchbar'}
<div id="searchbar">
	<h2>{"Search"|i18n("design/ezwebin/content/search")}</h2>
	{include uri="design:parts/searchform.tpl" placeholder=$search_text|wash() hidden=hash('SubTreeArray', ezini('NodeSettings', 'RootNode', 'content.ini'))}
{if $search_extras.spellcheck_collation}
	{def $spell_url=concat('/content/search/', $search_text|count_chars()|gt(0)|choose('', concat('?SearchText=', $search_extras.spellcheck_collation|urlencode)))|sitelink('no')}
	<p>Spell check suggestion: did you mean <strong>{concat("<a href=", $spell_url, ">")}{$search_extras.spellcheck_collation}</a></strong>?</p>
{/if}
{if $stop_word_array}
	<p>{"The following words were excluded from the search"|i18n("design/base")}:{foreach $stop_word_array as $stopWord}{$stopWord.word|wash()}{delimiter}, {/delimiter}{/foreach}</p>
{/if}
{if $search_count}
	<div class="feedback">
	<h2>Search for &#147;{$search_text|wash()}&#148; returned {$search_count} matches</h2>
{*
		<fieldset>
			<legend onclick="ezfToggleBlock('ezfHelp');">{'Help'|i18n( 'design/ezwebin/content/search' )} [+/-]</legend>
			<div id="ezfHelp" style="display: none;">
				<ul>
					<li>{'The search is case insensitive. Upper and lower case characters may be used.'|i18n( 'design/ezfind/search' )}</li>
					<li>{'The search result contains all search terms.'|i18n( 'design/ezfind/search' )}</li>
					<li>{'Phrase search can be achieved by using quotes, example: "Quick brown fox jumps over the lazy dog"'|i18n( 'design/ezfind/search' )}</li>
					<li>{'Words may be excluded by using a minus ( - ) character, example: lazy -dog'|i18n( 'design/ezfind/search' )}</li>
				</ul>
			</div>
		</fieldset>
*}
	</div>
{else}
	<div class="warning">
	<h2>{'No results were found when searching for "%1".'|i18n("design/ezwebin/content/search", , array($search_text|wash))}</h2>
	{if $search_extras.hasError}{$search_extras.error|wash()}{/if}
	</div>
	<p>{'Search tips'|i18n('design/ezwebin/content/search')}</p>
	<ul>
		<li>{'Check spelling of keywords.'|i18n('design/ezwebin/content/search')}</li>
		<li>{'Try changing some keywords (eg, "car" instead of "cars").'|i18n('design/ezwebin/content/search')}</li>
		<li>{'Try searching with less specific keywords.'|i18n('design/ezwebin/content/search')}</li>
		<li>{'Reduce number of keywords to get more results.'|i18n('design/ezwebin/content/search')}</li>
	</ul>
{/if}
</div>
{/set-block}
{if and(eq(ezini('SearchSettings', 'DisplayFacets', 'site.ini'), 'enabled'), $search_count)}
{set-block variable='facets'}
{def $facetData=''}
<section class="module infobox feedback" id="search-controls">
	<header<h1>Filter Search Results</h1></header>
	<section class="infobox-content">
		{def $activeFacetsCount=0}
		<ul id="active-facets-list" class="menu vertical">
		{foreach $defaultSearchFacets as $key => $defaultFacet}
			{if array_keys( $activeFacetParameters )|contains( concat( $defaultFacet['field'], ':', $defaultFacet['name']) )}
				{def $facetData=$search_extras.facet_fields.$key}
				{foreach $facetData.nameList as $key2 => $facetName}
					{if eq( $activeFacetParameters[concat( $defaultFacet['field'], ':', $defaultFacet['name'] )], $facetName )}
						{def $activeFacetsCount=sum( $key, 1 )}
						{def $suffix=$uriSuffix|explode( concat( '&filter[]=', $facetData.queryLimit[$key2]|wash ) )|implode( '' )|explode( concat( '&activeFacets[', $defaultFacet['field'], ':', $defaultFacet['name'], ']=', $facetName ) )|implode( '' )}
						<li><a href={concat( $baseURI, $suffix )|sitelink}>[x]</a> <strong>{$defaultFacet['name']}</strong>: {$facetName}</li>
					{/if}
				{/foreach}
			{/if}
		{/foreach}
		{* handle date filter here, manually for now. Should be a facet later on *}
		{if gt( $dateFilter, 0 )}
			{set $activeFacetsCount=$activeFacetsCount|inc}
			{def $suffix=$uriSuffix|explode( concat( '&dateFilter=', $dateFilter ) )|implode( '' )}
			<li><a href={concat( $baseURI, $suffix )|sitelink}>[x]</a> <strong>{'Creation time'|i18n( 'extension/ezfind/facets' )}</strong>: {$dateFilterLabel}</li>
		{/if}
		{if ge( $activeFacetsCount, 2 )}
			<li><a href={$baseURI|sitelink}>[x]</a> <em>{'Clear all'|i18n( 'extension/ezfind/facets' )}</em></li>
		{/if}
		</ul>
		<ul id="facet-list" class="menu vertical">
		{foreach $defaultSearchFacets as $key => $defaultFacet}
			{if array_keys( $activeFacetParameters )|contains( concat( $defaultFacet['field'], ':', $defaultFacet['name']) )|not}
			<li>
				{set $facetData=$search_extras.facet_fields.$key}
				<span {*style="background-color: #F2F1ED"*}><strong>{$defaultFacet['name']}</strong></span>
				<ul>
					{foreach $facetData.nameList as $key2 => $facetName}
						{if ne( $key2, '' )}
						<li><a href={concat( $baseURI, '&amp;filter[]=', $facetData.queryLimit[$key2]|wash, '&amp;activeFacets[', $defaultFacet['field'], ':', $defaultFacet['name'], ']=', $facetName, $uriSuffix )|sitelink()}>{$facetName}</a>({$facetData.countList[$key2]})</li>
						{/if}
					{/foreach}
				</ul>
			</li>
			{/if}
		{/foreach}
		{* date filtering here. Using a simple filter for now. Should use the date facets later on *}
		{if eq( $dateFilter, 0 )}
			<li>
				<span {*style="background-color: #F2F1ED"*}><strong>{'Creation time'|i18n( 'extension/ezfind/facets' )}</strong></span>
				<ul>
					<li><a href={concat( $baseURI, '&amp;dateFilter=1', $uriSuffix )|sitelink}>{"Last day"|i18n("design/standard/content/search")}</a></li>
					<li><a href={concat( $baseURI, '&amp;dateFilter=2', $uriSuffix )|sitelink}>{"Last week"|i18n("design/standard/content/search")}</a></li>
					<li><a href={concat( $baseURI, '&amp;dateFilter=3', $uriSuffix )|sitelink}>{"Last month"|i18n("design/standard/content/search")}</a></li>
					<li><a href={concat( $baseURI, '&amp;dateFilter=4', $uriSuffix )|sitelink}>{"Last three months"|i18n("design/standard/content/search")}</a></li>
					<li><a href={concat( $baseURI, '&amp;dateFilter=5', $uriSuffix )|sitelink}>{"Last year"|i18n("design/standard/content/search")}</a></li>
				</ul>
			</li>
		{/if}
		</ul>
	</section>
</section>
{/set-block}
{/if}
{pagedata_merge(hash('sidebar', $facets, 'searchbar', $searchbar))}
{literal}<script type="text/javascript">ezfSetBlock('ezfFacets', ezfGetCookie('ezfFacets'));ezfSetBlock('ezfHelp', ezfGetCookie('ezfHelp'));</script>{/literal}