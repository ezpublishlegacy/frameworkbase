{def $star_attribute=first_set($node.data_map.starrating, false())}

{if first_set($node.data_map.like.data_int, true())|not}
	{set $star_attribute = false()}
{/if}

{* Image - Gallery line view *}
<div class="content-view-galleryline class-image">
	<div class="attribute-image"{if is_set($#image_style)} style="{$#image_style}"{/if}>
		<a href={$node.data_map.image.content['original'].url|sitelink()}>{attribute_view_gui attribute=$node.data_map.image image_class=gallerythumbnail}</a>
	</div>
	<div class="attribute-name"{if is_set($#image_style)} style="{$#image_style|explode(';').0}"{/if}>
		<p>{$node.name|shorten(14)|wash()} <a href="JavaScript:void(0);" id="ezsr_{$star_attribute.id}_{$star_attribute.version}_5" class="ezsr-stars-5 liketxt" rel="nofollow" title="Clicking the Like link next to something that you enjoy is an easy way to let someone know that you like it, without leaving a comment. The fact that you liked it is noted next to each item.">like it</a></p>
	</div>
	
</div>

{run-once}
{if has_access_to_limitation( 'ezjscore', 'call', hash( 'FunctionList', 'ezstarrating_rate' ) )}
    {def $preferred_lib = ezini('eZJSCore', 'PreferredLibrary', 'ezjscore.ini')}
    {if array( 'yui3', 'jquery' )|contains( $preferred_lib )|not()}
        {* Prefer jQuery if something else is used globally, since it's smaller then yui3. *}
        {set $preferred_lib = 'jquery'}
    {/if}
    {ezscript_require( array( concat( 'ezjsc::', $preferred_lib, 'io' ), concat( 'ezstarratingtemplate_crm::', $preferred_lib ) ) )}
{/if}
{/run-once}