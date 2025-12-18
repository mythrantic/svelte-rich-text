<script lang="ts">
	import type { dataBlock } from '../../utils/consts.js';
	import Code from '../editBlocks/code.svelte';
	import Header from '../editBlocks/header.svelte';
	import Img from '../editBlocks/img.svelte';
	import List from '../editBlocks/list.svelte';
	import Paragraph from '../editBlocks/paragraph.svelte';
	import Quote from '../editBlocks/quote.svelte';
	import { store } from '../../utils/stores.svelte.js';
	import Space from '../editBlocks/space.svelte';
	export let block: dataBlock;
	$: active = store.workingBlock && store.workingBlock.state == 'editing' && store.workingBlock.id == block.id;
	$: focused =
		store.workingBlock && store.workingBlock.state == 'focused' && store.workingBlock.id == block.id;
</script>

<div
	class="blockWrapper"
	class:focused
	class:editing={active}
	data-blockid={block.id}
	data-blocktype={block.name}
>
	{#if block.name == 'header'}
		<Header id={block.id} content={block.data} {active} />
	{:else if block.name == 'code'}
		<Code content={block.data} id={block.id} {active} />
	{:else if block.name == 'image'}
		<Img id={block.id} content={block.data} {active} />
	{:else if block.name == 'list'}
		<List id={block.id} content={block.data} {active} />
	{:else if block.name == 'paragraph'}
		<Paragraph id={block.id} content={block.data} {active} />
	{:else if block.name == 'quote'}
		<Quote id={block.id} content={block.data} {active} />
	{:else}
		<Space id={block.id} content={block.data} {active} />
	{/if}
	<span class="blockType">{block.name}</span>
</div>

<style>
	.blockWrapper {
		width: 100%;
		padding-top: 30px;
		position: relative;
	}

	.focused {
		border: 2px solid var(--primaryColor);
		border-radius: 8px;
	}

	.focused,
	.editing {
		padding-bottom: 10px;
		padding-inline: 15px;
	}
	.editing {
		border: 2px solid var(--secondaryColor);
		border-radius: 8px;
	}

	.focused .blockType,
	.editing .blockType {
		display: inline-block;
	}
	.focused .blockType {
		background-color: var(--primaryColor);
	}

	.editing .blockType {
		background-color: var(--secondaryColor);
	}

	.blockType {
		position: absolute;
		width: fit-content;
		height: fit-content;
		top: 0%;
		right: 0%;
		font-size: var(--small);
		color: var(--textColor);
		font-weight: bold;
		display: none;
		padding-inline: 12px;
		padding-block: 2px;
		border-bottom-left-radius: 12px;
		text-transform: capitalize;
	}
</style>
