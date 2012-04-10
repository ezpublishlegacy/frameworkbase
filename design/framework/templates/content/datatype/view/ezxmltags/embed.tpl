{template_merge(hash(
	'element', cond(and($object_parameters.align, ne($object_parameters.align,'center')), 'aside', 'div'),
	'alignment', $object_parameters.align,
	'show_image', and(cond(is_set($hide_image), not($hide_image), true()), cond(is_set($object.data_map.image), $object.data_map.image.has_content, false()))
))}
<{template_get('element')}{if is_set($object_parameters.id)} id="{$object_parameters.id}"{/if} class="content-view-embed class-{$object.class_identifier}{if template_get('show_image')} line-image{/if} {if and( template_get('alignment'), ne(template_get('alignment'), 'none'))}align-{template_get('alignment')}{else}noalign{/if}{if ne($classification|trim, '')} {$classification|wash}{/if}">
{content_view_gui view=$view link_parameters=$link_parameters object_parameters=$object_parameters content_object=$object classification=$classification}
</{template_get('element')}>

{template_unset(array('element', 'alignment', 'show_image'))}