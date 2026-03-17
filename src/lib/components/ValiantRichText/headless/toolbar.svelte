<script lang="ts">
	import commands from '../commands/toolbar-commands.js';
	import type { EdraToolbarProps } from '../types.js';
	import FontSize from './components/toolbar/FontSize.svelte';
	import QuickColors from './components/toolbar/QuickColors.svelte';
	import SearchAndReplace from './components/toolbar/SearchAndReplace.svelte';
	import ToolBarIcon from './components/ToolBarIcon.svelte';

	const { editor, class: className, excludedCommands, children }: EdraToolbarProps = $props();

	const toolbarCommands = Object.keys(commands).filter((key) => !excludedCommands?.includes(key));

	let show = $state<boolean>(false);

	// Define group order with UX hierarchy:
	// 1. Undo/Redo (lonely, standalone)
	// 2. Essential text formatting (Bold, Italic, Underline, Strikethrough)
	// 3. Headings (H1-H4)
	// 4. Advanced text formatting (Superscript, Subscript, Link, Paragraph)
	// 5. Quote & Code
	// 6. Lists (Bullet, Ordered, Task)
	// 7. Alignment
	// 8. Formatting dropdowns (Font Size, Colors)
	// 9. Media (Image, Video, Audio, iFrame) - niche
	// 10. Table (very niche)
	// 11. Math (very niche)
	// 12. Search/Filter (far right)
	const groupOrder = [
		'undo-redo',
		'headings',
		'text-formatting',
		'alignment',
		'lists',
		'media',
		'table',
		'math'
	];

	// Commands within text-formatting to render in specific order for better UX
	const textFormattingOrder = [
		'bold',
		'italic',
		'underline',
		'strikethrough',
		'link',
		'paragraph',
		'blockQuote',
		'code',
		'superscript',
		'subscript'
	];
</script>

<div class={`edra-toolbar ${className}`}>
	{#if children}
		{@render children()}
	{:else}
		{#if !show}
			<!-- Section 1: Undo/Redo (standalone, essential) -->
			{#if commands['undo-redo'] && toolbarCommands.includes('undo-redo')}
				{@const commandGroup = commands['undo-redo']}
				<div class="edra-toolbar-group edra-group-essential">
					{#each commandGroup as command (command)}
						<ToolBarIcon {editor} {command} />
					{/each}
				</div>
				<div class="edra-toolbar-separator"></div>
			{/if}

			<!-- Section 2: Headings (document structure) -->
			{#if commands['headings'] && toolbarCommands.includes('headings')}
				{@const commandGroup = commands['headings']}
				<div class="edra-toolbar-group edra-group-structure">
					{#each commandGroup as command (command)}
						<ToolBarIcon {editor} {command} />
					{/each}
				</div>
				<div class="edra-toolbar-separator"></div>
			{/if}

			<!-- Section 3: Text Formatting (reordered for UX) -->
			{#if commands['text-formatting'] && toolbarCommands.includes('text-formatting')}
				{@const commandGroup = commands['text-formatting']}
				<div class="edra-toolbar-group edra-group-formatting">
					{#each textFormattingOrder as commandName}
						{@const command = commandGroup.find((c) => c.name === commandName)}
						{#if command}
							<ToolBarIcon {editor} {command} />
						{/if}
					{/each}
				</div>
				<div class="edra-toolbar-separator"></div>
			{/if}

			<!-- Section 4: Alignment (layout) -->
			{#if commands['alignment'] && toolbarCommands.includes('alignment')}
				{@const commandGroup = commands['alignment']}
				<div class="edra-toolbar-group edra-group-layout">
					{#each commandGroup as command (command)}
						<ToolBarIcon {editor} {command} />
					{/each}
				</div>
				<div class="edra-toolbar-separator"></div>
			{/if}

			<!-- Section 5: Lists (structure) -->
			{#if commands['lists'] && toolbarCommands.includes('lists')}
				{@const commandGroup = commands['lists']}
				<div class="edra-toolbar-group edra-group-structure">
					{#each commandGroup as command (command)}
						<ToolBarIcon {editor} {command} />
					{/each}
				</div>
				<div class="edra-toolbar-separator"></div>
			{/if}

			<!-- Section 6: Formatting Dropdowns (Font Size + Colors) -->
			<div class="edra-toolbar-formatting-group edra-group-appearance">
				<FontSize {editor} />
				<QuickColors {editor} />
			</div>
			<div class="edra-toolbar-separator"></div>

			<!-- Section 7: Media (niche, advanced) -->
			{#if commands['media'] && toolbarCommands.includes('media')}
				{@const commandGroup = commands['media']}
				<div class="edra-toolbar-group edra-group-niche">
					{#each commandGroup as command (command)}
						<ToolBarIcon {editor} {command} />
					{/each}
				</div>
				<div class="edra-toolbar-separator"></div>
			{/if}

			<!-- Section 8: Table (very niche) -->
			{#if commands['table'] && toolbarCommands.includes('table')}
				{@const commandGroup = commands['table']}
				<div class="edra-toolbar-group edra-group-niche">
					{#each commandGroup as command (command)}
						<ToolBarIcon {editor} {command} />
					{/each}
				</div>
				<div class="edra-toolbar-separator"></div>
			{/if}

			<!-- Section 9: Math (very niche) -->
			{#if commands['math'] && toolbarCommands.includes('math')}
				{@const commandGroup = commands['math']}
				<div class="edra-toolbar-group edra-group-niche">
					{#each commandGroup as command (command)}
						<ToolBarIcon {editor} {command} />
					{/each}
				</div>
				<div class="edra-toolbar-separator"></div>
			{/if}
		{/if}

		<!-- Section 10: Search/Filter (far right) -->
		<div class="edra-toolbar-search-wrapper">
			<SearchAndReplace {editor} bind:show />
		</div>
	{/if}
</div>
