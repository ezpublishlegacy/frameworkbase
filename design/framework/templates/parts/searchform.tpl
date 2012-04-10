{def $has_placeholder= or( or(is_unset($placeholder), eq($placeholder, 'null')), and(is_set($placeholder), ne($placeholder, false())) )
	 $has_label= and(or( or(is_unset($label), eq($label, 'null')), and(is_set($label), ne($label, false())) ), not($placeholder))
}
<form action={"/content/search"|sitelink()} method="get">
{if first_set($hidden, false())}
{foreach $hidden as $key=>$value}
	<input type="hidden" name="{$key}" value="{$value}" />
{/foreach}
{/if}
	<fieldset>
		{if $has_label}<label>{cond( and(first_set($label, false()), ne($label, 'null')), $label|wash(), 'Search')}{/if}<input class="searchtext" type="text" name="SearchText"{if $has_placeholder} placeholder="{cond( and(first_set($placeholder, false()), ne($placeholder, 'null')) , $placeholder|wash(), 'Search')}"{/if} />{if $has_label}</label>{/if}
		<input class="searchbutton" type="image" name="SearchButton" alt="Search" src={'images/search.png'|ezdesign()} />
	</fieldset>
</form>