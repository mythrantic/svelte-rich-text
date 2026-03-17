<script lang="ts">
	import ChevronDown from '@lucide/svelte/icons/chevron-down';

	interface Option {
		label: string;
		value: string;
		icon?: any;
	}

	interface Props {
		options: Option[];
		value?: string;
		placeholder?: string;
		label?: string;
		onchange?: (value: string) => void;
		icon?: any;
	}

	let { options, value, placeholder = 'Select...', label, onchange, icon: Icon }: Props = $props();

	let isOpen = $state(false);
	let container: HTMLDivElement;
	let selectedOption = $derived(options.find((opt) => opt.value === value));

	function handleSelect(val: string) {
		onchange?.(val);
		isOpen = false;
	}

	function handleClickOutside(e: MouseEvent) {
		const target = e.target as HTMLElement;
		if (container && !container.contains(target)) {
			isOpen = false;
		}
	}

	$effect(() => {
		if (isOpen) {
			document.addEventListener('mousedown', handleClickOutside);
			return () => document.removeEventListener('mousedown', handleClickOutside);
		}
	});
</script>

<div class="toolbar-dropdown-container" bind:this={container}>
	<button
		class="toolbar-dropdown-trigger"
		onclick={() => (isOpen = !isOpen)}
		title={label}
		aria-label={label}
		aria-haspopup="listbox"
		aria-expanded={isOpen}
	>
		{#if Icon}
			<svelte:component this={Icon} size={16} />
		{/if}
		<span class="toolbar-dropdown-label">
			{selectedOption?.label || placeholder}
		</span>
		<ChevronDown size={14} style={isOpen ? 'transform: rotate(180deg)' : ''} class="chevron" />
	</button>

	{#if isOpen}
		<div class="toolbar-dropdown-content" role="listbox">
			{#each options as option (option.value)}
				<button
					class="toolbar-dropdown-item"
					class:active={option.value === value}
					onclick={() => handleSelect(option.value)}
					role="option"
					aria-selected={option.value === value}
				>
					{#if option.icon}
						<svelte:component this={option.icon} size={14} />
					{/if}
					<span>{option.label}</span>
				</button>
			{/each}
		</div>
	{/if}
</div>

<style>
	.toolbar-dropdown-container {
		position: relative;
		display: inline-flex;
		align-items: center;
	}

	.toolbar-dropdown-trigger {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		gap: 0.375rem;
		border: 1px solid transparent;
		background-color: transparent;
		border-radius: 0.375rem;
		cursor: pointer;
		transition: all 0.15s ease-in-out;
		padding: 0.375rem 0.5rem;
		min-height: 2.5rem;
		color: var(--edra-icon-color);
		font-size: 0.875rem;
		font-weight: 500;
		white-space: nowrap;
		flex-shrink: 0;
	}

	.toolbar-dropdown-trigger:hover {
		background-color: var(--color-muted);
	}

	.toolbar-dropdown-trigger:active {
		background-color: var(--color-muted);
	}

	.chevron {
		transition: transform 0.2s ease-in-out;
	}

	.chevron.rotated {
		transform: rotate(180deg);
	}

	.toolbar-dropdown-label {
		max-width: 6rem;
		overflow: hidden;
		text-overflow: ellipsis;
	}

	.toolbar-dropdown-content {
		position: absolute;
		top: calc(100% + 0.25rem);
		left: 0;
		z-index: 50;
		min-width: max-content;
		background-color: var(--color-background);
		border: 1px solid var(--color-border);
		border-radius: 0.5rem;
		box-shadow:
			0 4px 6px -1px rgba(0, 0, 0, 0.1),
			0 2px 4px -1px rgba(0, 0, 0, 0.06);
		padding: 0.375rem;
		display: flex;
		flex-direction: column;
		max-height: 20rem;
		overflow-y: auto;
	}

	.toolbar-dropdown-item {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		padding: 0.5rem 0.75rem;
		background-color: transparent;
		border: none;
		border-radius: 0.375rem;
		cursor: pointer;
		color: var(--color-foreground);
		font-size: 0.875rem;
		transition: all 0.15s ease-in-out;
		text-align: left;
		min-width: 6rem;
		font-weight: 400;
	}

	.toolbar-dropdown-item:hover {
		background-color: var(--color-muted);
	}

	.toolbar-dropdown-item.active {
		background-color: var(--color-muted);
		font-weight: 600;
		color: var(--color-primary);
	}
</style>
