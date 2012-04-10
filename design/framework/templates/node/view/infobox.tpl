{def $hide_header=$node.data_map.hide_header.data_int
	 $infobox_link=$node|sitelink('no')
}

{if and($node.data_map.image.has_content, $node.data_map.content.has_content|not())}
<div class="module infobox align-center"><div class="infobox-image">{attribute_view_gui attribute=$node.data_map.image}</div></div>
{else}
<{cond($hide_header, 'div', 'section')} class="module infobox infobox_{$node.node_id}">
	{if $node.data_map.image.has_content}<div class="infobox-image">{attribute_view_gui attribute=$node.data_map.image image_class='infoboximage' href=cond(ne($infobox_link, ''), $infobox_link, false()) css_class='attribute-image'}</div>{/if}
	{if not($hide_header)}<header><h1>{$node.name|wash()}</h1></header>{/if}
	<div class="infobox-content">
		{attribute_view_gui attribute=$node.object.data_map.content}
		{if ne($infobox_link, '')}
			<div class="infobox-link"><a href="{$infobox_link}">{cond(ne($node.data_map.external_link.data_text, ''), $node.data_map.external_link.data_text, $node.name)|wash()}</a></div>
		{/if}
	</div>
{if or($node.object.can_edit, $node.object.can_remove)}
	<div class="controls">
		<form action={"/content/action"|ezroot()} method="post">
		{if $node.object.can_edit}
			<input type="image" name="EditButton" src={"edit-infobox-ico.gif"|ezimage()} alt="Edit" />
			<input type="hidden" name="ContentObjectLanguageCode" value="{$node.object.current_language}" />
		{/if}
		{if $node.object.can_remove}
			<input type="image" name="ActionRemove" src={"trash-infobox-ico.gif"|ezimage()} alt="Remove" />
		{/if}
			<input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
			<input type="hidden" name="NodeID" value="{$node.node_id}" />
			<input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
		</form>
	</div>
{/if}
</{cond($hide_header, 'div', 'section')}>
{/if}
{undef $hide_header}