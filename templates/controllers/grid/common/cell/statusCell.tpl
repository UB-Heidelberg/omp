{**
 * templates/controllers/grid/common/cell/statusCell.tpl
 *
 * Copyright (c) 2000-2011 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * a regular grid cell (with or without actions)
 *}
{assign var=cellId value="cell-"|concat:$id}
<span id="{$cellId}" class="pkp_linkActions">
	{if count($actions) gt 0}
		{assign var=defaultCellAction value=$actions[0]}
		{include file="linkAction/linkAction.tpl" action=$defaultCellAction contextId=$cellId imageClass="task"}
	{else}
		<a class="task {$status|escape}">status</a>
	{/if}
</span>

