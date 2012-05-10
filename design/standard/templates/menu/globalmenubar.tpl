<nav id="global-menubar">
{menubar('primary'hash(
	'orientation', 'horizontal',
	'class', 'primary dynamic',
	'include_root_node', true(),
	'menu_depth', 2,
	'identifier_list', 'TopIdentifierList',
	'fetch_parameters', hash(
		'attribute_filter', array(array('priority', 'between', array(1, 10)))
	)
))}
</nav>
