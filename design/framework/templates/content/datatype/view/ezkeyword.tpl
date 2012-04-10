{foreach $attribute.content.keywords as $keyword}
<a href={concat('/', $attribute.object.main_node.url_alias, '/(tag)/', $keyword|urlencode())} title="{$keyword}">{$keyword}</a>{delimiter}, {/delimiter}
{/foreach}