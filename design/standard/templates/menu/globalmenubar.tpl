<nav id="global-menubar">
{menubar(hash(
	'orientation', 'horizontal',
	'class', 'primary',
	'include_root_node', true(),
	'menu_depth', 2,
	'identifier_list', 'TopIdentifierList',
	'fetch_parameters', hash(
		'AttributeFilter', array(array('priority', 'between', array(1, 10)))
	)
))}
</nav>
