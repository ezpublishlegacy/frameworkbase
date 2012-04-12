{* File - List embed view *}
{if $object.data_map.file.has_content}
{def $file = $object.data_map.file
	 $icon_size='small'
	 $icon_title=$file.content.mime_type
}
<div class="content-body attribute-{$file.content.mime_type_part}">
	{$file.content.mime_type|mimetype_icon($icon_size,$icon_title)}<a href={concat("content/download/", $file.contentobject_id, "/", $file.id, "/file/", $file.content.original_filename)|sitelink()}>{$file.content.original_filename|wash("xhtml")}</a> {$file.content.filesize|si(byte)}
</div>
{undef $file}
{else}
<div class="content-body">
	<a href={$object.main_node.url_alias|sitelink()}>{$object.name|wash}</a>
</div>
{/if}